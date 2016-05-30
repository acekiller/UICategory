//
//  YMURLPattern.m
//  UICategory
//
//  Created by fengxijun on 5/13/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMURLPattern.h"

@implementation YMURLPattern

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.regular = @"[a-zA-z]+://[^\\s]*";
        self.patternType = YMRichPatternWithAttribute;
    }
    return self;
}

- (NSDictionary *)styleParams:(NSString *)result
{
    return @{
             NSForegroundColorAttributeName : [UIColor blueColor],
             NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
             @"url" : [result copy],
             };
}

- (NSString *)showString:(NSString *)result
{
    return result;
}

@end
