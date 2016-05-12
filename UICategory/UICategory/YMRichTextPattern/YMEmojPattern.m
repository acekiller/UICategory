//
//  YMEmojPattern.m
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMEmojPattern.h"
#import "YMEmojAttachement.h"

@implementation YMEmojPattern

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.regular = @"(\\[[a-zA-Z0-9]{0,}[\u4E00-\u9FA5]{0,}\\])";
    }
    return self;
}

- (Class)attachementClass
{
    return [YMEmojAttachement class];
}

- (NSString *)formatResourceAdjustString:(NSString *)result
{
    NSMutableString *emojName = [result mutableCopy];
    [emojName replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
    [emojName replaceCharactersInRange:NSMakeRange([emojName length] - 2, 1) withString:@""];
    return emojName;
}

@end
