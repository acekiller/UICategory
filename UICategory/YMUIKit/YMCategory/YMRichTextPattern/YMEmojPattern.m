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

- (instancetype) initWithFont:(UIFont *)font
{
    self = [super initWithFont:font];
    if (self) {
        self.regular = @"(\\[[a-zA-Z0-9\u4E00-\u9FA5_]{0,}\\])";
        self.patternType = YMRichPatternWithAttachement;
    }
    return self;
}

- (instancetype) init
{
    return [self initWithFont:nil];
}

- (Class)attachementClass
{
    return [YMEmojAttachement class];
}

- (NSString *)showString:(NSString *)result
{
    NSMutableString *emojName = [result mutableCopy];
    [emojName replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
    [emojName replaceCharactersInRange:NSMakeRange([emojName length] - 1, 1) withString:@""];
    return emojName;
}

@end
