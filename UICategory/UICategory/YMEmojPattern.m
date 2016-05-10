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

@end
