//
//  YMAtPattern.m
//  UICategory
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMAtPattern.h"

@implementation YMAtPattern

- (instancetype) init
{
    self = [super initWithRegex:@"(\\[@[a-zA-Z0-9\u4E00-\u9FA5_]{0,}\\])" isAttachement:NO];
    if (self) {
        //
    }
    return self;
}

- (NSString *)parserShowOrResourceString:(NSString *)regexResult
{
    NSMutableString *emojName = [regexResult mutableCopy];
    [emojName replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
    [emojName replaceCharactersInRange:NSMakeRange([emojName length] - 1, 1) withString:@""];
    return emojName;
}

- (NSDictionary *)parserAttributes:(NSString *)regexResult
{
    return @{};
}

@end
