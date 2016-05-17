//
//  YMLabelPattern.m
//  UICategory
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMLabelPattern.h"

@implementation YMLabelPattern

@synthesize regex=_regex,isAttachement=_isAttachement;

- (instancetype)initWithRegex:(NSString *)regex isAttachement:(BOOL)isAttachement {
    self = [super init];
    if (self) {
        self.regex = (regex != nil && [regex isKindOfClass:[NSString class]]) ? regex : @"";
        self.isAttachement = isAttachement;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithRegex:@"" isAttachement:NO];
}

- (NSString *)parserShowOrResourceString:(NSString *)regexResult {
    return regexResult;
}

- (NSDictionary *)parserAttributes:(NSString *)regexResult {
    return @{};
}

@end
