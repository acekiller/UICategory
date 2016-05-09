//
//  YMImageAttachement.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMImageAttachement.h"

@implementation YMImageAttachement

- (instancetype) initWithFilePath:(NSString *)filepath
{
    return [self initWithImage:[UIImage imageWithContentsOfFile:filepath]];
}

- (instancetype) initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.image = image;
    }
    return self;
}

@end
