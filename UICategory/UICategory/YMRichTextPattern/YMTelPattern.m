//
//  YMTelPattern.m
//  UICategory
//
//  Created by fengxijun on 5/13/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMTelPattern.h"

@implementation YMTelPattern

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.regular = @"[0\\d]{3}-\\d{8}|[0\\d]{4}-\\d{7,8}";
        self.patternType = YMRichPatternWithAttribute;
    }
    return self;
}

- (Class)styleParamsParserClass
{
    return [NSAttributedString class];
}

- (NSDictionary *)styleParams:(NSString *)result
{
    return @{
             NSForegroundColorAttributeName : [UIColor blueColor],
             NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
             @"tel" : [result copy],
             };
}

- (NSString *)showString:(NSString *)result
{
    return result;
}

@end
