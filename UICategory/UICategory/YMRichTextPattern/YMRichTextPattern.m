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

- (NSString *)formatResourceAdjustString:(NSString *)result
{
    return @"";
}

@end
