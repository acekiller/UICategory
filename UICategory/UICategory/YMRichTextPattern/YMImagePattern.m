//
//  YMImagePattern.m
//  UICategory
//
//  Created by fengxijun on 5/12/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMImagePattern.h"
#import "YMImageAttachement.h"

@implementation YMImagePattern

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.regular = @"(<image [\\S\\s]+>)";
        self.patternType = YMRichPatternWithAttachement;
    }
    return self;
}

- (Class)attachementClass
{
    return [YMImageAttachement class];
}

@end
