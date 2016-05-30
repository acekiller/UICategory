//
//  YMRichTextPattern.m
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMRichTextPattern.h"
#import "NSTextAttachment+YMRTPattern.h"
#import "NSString+YMRTPattern.h"

@interface YMRichTextPattern ()

@end

@implementation YMRichTextPattern

@synthesize regular=_regular,patternType=_patternType,font=_font, directory=_directory;
@synthesize delegate=_delegate,tapHandler=_tapHandler;

- (instancetype) initWithResourceDiretory:(NSString *)directory font:(UIFont *)font delegate:(id<YMRichTextConfigProtocol>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.font = font ? font : [UIFont systemFontOfSize:15.f];
        self.regular = @"";
        self.patternType = YMRichPatternWithAttribute;
    }
    return self;
}

- (instancetype) initWithFont:(UIFont *)font
                     delegate:(id<YMRichTextConfigProtocol>)delegate
{
    return [self initWithResourceDiretory:nil font:font delegate:delegate];
}

- (instancetype) initWithFont:(UIFont *)font
{
    return [self initWithFont:font
                     delegate:nil];
}

- (instancetype) initWithDelegate:(id <YMRichTextConfigProtocol>)delegate
{
    return [self initWithFont:[UIFont systemFontOfSize:15.f]
                     delegate:delegate];
}

- (instancetype) init
{
    return [self initWithDelegate:nil];
}

#pragma mark --Attribute Metthod

- (NSDictionary *)styleParams:(NSString *)result
{
    return @{};
}

- (NSString *)showString:(NSString *)result
{
    return @"";
}

#pragma mark --Attachement Method

- (Class)attachementClass
{
    return [NSTextAttachment class];
}

- (YMPatternResults *)patternResultStringFromString:(NSString *)string
                                        checkResult:(NSTextCheckingResult *)checkResult
{
    YMPatternResults *result = [[YMPatternResults alloc] init];
    result.range = checkResult.range;
    result.result = [string substringWithRange:checkResult.range];
    result.params = [self styleParams:result.result];
    result.showString = [self showString:result.result];
    result.font = self.font;
    result.tapHandler = self.tapHandler;
    
    result.attributeString = [self attributeString:result];
    
    return result;
}

- (YMPatternResults *)patternResultStringFromString:(NSString *)string
                                        checkResult:(NSTextCheckingResult *)checkResult
                                               font:(UIFont *)font
{
    YMPatternResults *result = [[YMPatternResults alloc] init];
    result.range = checkResult.range;
    result.result = [string substringWithRange:checkResult.range];
    result.params = [self styleParams:result.result];
    result.showString = [self showString:result.result];
    result.directory = self.directory;
    result.font = font ? font : self.font;
    result.tapHandler = self.tapHandler;
    
    result.attributeString = [self attributeString:result];
    
    return result;
}

- (NSAttributedString *)attributeString:(YMPatternResults *)result {
    if (YMRichPatternWithAttachement == self.patternType) {
        return [NSAttributedString attributedStringWithAttachment:[self attachementWithPatten:result]];
    } else if (YMRichPatternWithAttribute == self.patternType) {
        return [self richTextParamsParserString:result];
    }
    return [[NSAttributedString alloc] init];
}

- (NSAttributedString *)richTextParamsParserString:(YMPatternResults *)result
{
    NSMutableDictionary *attributes = [[result params] mutableCopy];
    [attributes setObject:result.result forKey:NSLinkAttributeName];
    return [[NSAttributedString alloc] initWithString:[result showString]
                                                      attributes:[result params]];
}

- (NSTextAttachment *)attachementWithPatten:(YMPatternResults *)result
{
    NSTextAttachment *attachement = [[[self attachementClass] alloc] init];
    [attachement setPatternResult:result];
    return attachement;
}


@end
