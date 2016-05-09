//
//  UILabel+ContentEdgetInsets.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "UILabel+ContentEdgetInsets.h"
#import "Swizzling.h"

@implementation UILabel (ContentEdgetInsets)

+ (void) load
{
    static dispatch_once_t swizzing_once;
    dispatch_once(&swizzing_once, ^{
        swizzleSelector(self, @selector(sizeThatFits:), @selector(sizzing_sizeThatFits:));
        swizzleSelector(self, @selector(drawTextInRect:), @selector(swizzing_drawTextInRect:));
    });
}

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

#pragma mark --Draw Methods
- (void)swizzing_drawTextInRect:(CGRect)rect
{
    [self swizzing_drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textContentEdgeInsets)];
}

- (CGSize)sizzing_sizeThatFits:(CGSize)size
{
    size.width = size.width - (self.textContentEdgeInsets.left + self.textContentEdgeInsets.right);
    CGSize fixedSize = [self sizzing_sizeThatFits:size];
    fixedSize.height += (self.textContentEdgeInsets.top + self.textContentEdgeInsets.bottom);
    fixedSize.width += (self.textContentEdgeInsets.left + self.textContentEdgeInsets.right);
    return fixedSize;
}

@end
