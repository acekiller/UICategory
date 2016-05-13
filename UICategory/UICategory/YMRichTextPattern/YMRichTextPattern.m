//
//  YMRichTextPattern.m
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMRichTextPattern.h"
#import <UIKit/NSTextAttachment.h>
#import "NSTextAttachment+YMRTPattern.h"
#import "NSString+YMRTPattern.h"

@implementation YMRichTextPattern

@synthesize regular=_regular,patternType=_patternType;

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

- (Class)styleParamsParserClass
{
    return [NSAttributedString class];
}

- (YMPatternResults *)patternResultStringFromString:(NSString *)string
                                        checkResult:(NSTextCheckingResult *)checkResult
{
    YMPatternResults *result = [[YMPatternResults alloc] init];
    result.range = checkResult.range;
    result.result = [string substringWithRange:checkResult.range];
    result.params = [self styleParams:result.result];
    result.showString = [self showString:result.result];
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
    return [[[self styleParamsParserClass] alloc] initWithString:[result showString]
                                                      attributes:[result params]];
}

- (NSTextAttachment *)attachementWithPatten:(YMPatternResults *)result
{
    NSTextAttachment *attachement = [[[self attachementClass] alloc] init];
    [attachement setPatternResult:result];
    return attachement;
}


@end
