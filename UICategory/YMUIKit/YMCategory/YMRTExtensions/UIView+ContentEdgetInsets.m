//
//  UIView+ContentEdgetInsets.m
//  UICategory
//
//  Created by fengxijun on 5/12/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "UIView+ContentEdgetInsets.h"

@implementation UIView (ContentEdgetInsets)

#pragma mark --Property set & get Methods
- (void) setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat) cornerRadius
{
    return self.layer.cornerRadius;
}

@end
