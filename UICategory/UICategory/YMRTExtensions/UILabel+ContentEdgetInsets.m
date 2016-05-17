//
//  UILabel+ContentEdgetInsets.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "UILabel+ContentEdgetInsets.h"
#import <objc/runtime.h>

@implementation UILabel (ContentEdgetInsets)

#pragma mark --Property set & get Methods

- (void)setTextContentEdgeInsets:(UIEdgeInsets)textContentEdgeInsets
{
    objc_setAssociatedObject(self, "textContentEdgeInsets", NSStringFromUIEdgeInsets(textContentEdgeInsets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}

- (UIEdgeInsets)textContentEdgeInsets
{
    return UIEdgeInsetsFromString(objc_getAssociatedObject(self, "textContentEdgeInsets"));
}

@end
