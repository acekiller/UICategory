//
//  YMPatternResults.m
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMPatternResults.h"
#import "NSTextAttachment+YMRTPattern.h"
#import "YMRichMapMarkProtocol.h"

@interface YMPatternResults ()
@property (nonatomic, strong) NSString *showString;
@end

@implementation YMPatternResults

- (instancetype) initWithString:string checkResult:(NSTextCheckingResult *)checkResult pattern:(id<YMRichMapMarkProtocol>)pattern
{
    self = [super init];
    if (self) {
        self.range = checkResult.range;
        self.result = [string substringWithRange:checkResult.range];
        self.params = [pattern styleParams:self.result];
        self.showString = [pattern showString:self.result];
        self.formatUseName = [pattern formatResourceAdjustString:self.formatUseName];
        self.attributeString = [self attributeString:pattern];
    }
    return self;
}

- (NSAttributedString *)attributeString:(id<YMRichMapMarkProtocol>)pattern {
    if (YMRichPatternWithAttachement == pattern.patternType) {
        return [NSAttributedString attributedStringWithAttachment:[self attachementWithPatten:pattern]];
    } else if (YMRichTextPatternWithAttribute == pattern.patternType) {
        return [self richTextParamsParserString:pattern];
    }
    return [[NSAttributedString alloc] init];
}

- (NSAttributedString *)richTextParamsParserString:(id<YMRichMapMarkProtocol>)pattern
{
    return [[[pattern styleParamsParserClass] alloc] initWithString:[self showString] attributes:[self params]];
}

- (NSTextAttachment *)attachementWithPatten:(id<YMRichMapMarkProtocol>)pattern
{
    NSTextAttachment *attachement = [[[pattern attachementClass] alloc] init];
    [attachement setPatternResult:self];
    return attachement;
}

@end