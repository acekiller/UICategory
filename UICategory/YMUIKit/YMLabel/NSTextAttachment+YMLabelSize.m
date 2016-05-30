//
//  NSTextAttachment+YMLabelSize.m
//  UICategory
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "NSTextAttachment+YMLabelSize.h"
#import <objc/runtime.h>

@implementation NSTextAttachment (YMLabelSize)

- (CGSize) attachemtSizeLimited
{
    return [objc_getAssociatedObject(self, "attachemtSizeLimited") CGSizeValue];
}

- (void)setAttachemtSizeLimited:(CGSize)size
{
    objc_setAssociatedObject(self, "attachemtSizeLimited", [NSValue valueWithCGSize:size], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)size
{
    return [self fixSizeWithSize:self.image.size limitedSize:[self attachemtSizeLimited]];
}

- (CGSize)fixSizeWithSize:(CGSize)size limitedSize:(CGSize)limitedSize
{
    return size;
}

@end
