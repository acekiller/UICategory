//
//  UILabel+YMRichText.m
//  UICategory
//
//  Created by fantasy on 16/5/17.
//  Copyright © 2016年 goappbox. All rights reserved.
//

#import "UILabel+YMRichText.h"
#import <CoreText/CoreText.h>
#import "Swizzling.h"
#import "NSString+YMRTPattern.h"

@implementation UILabel (YMRichText)

+ (void) load
{
    static dispatch_once_t swizzing_rich_text_once;
    dispatch_once(&swizzing_rich_text_once, ^{
        swizzleSelector(self, @selector(sizeThatFits:), @selector(sizzing_sizeThatFits:));
        swizzleSelector(self, @selector(drawTextInRect:), @selector(swizzing_drawTextInRect:));
        swizzleSelector(self, @selector(setText:), @selector(swizzing_setText:));
        swizzleSelector(self, @selector(setAttributedText:), @selector(swizzing_setAttributedText:));
    });
}

#pragma mark --Draw Methods
- (void)swizzing_drawTextInRect:(CGRect)rect
{
    [self swizzing_drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textContentEdgeInsets)];
}

- (void)swizzing_setText:(NSString *)text
{
    [self swizzing_setText:text];
    [self setAttributedText:[[NSAttributedString alloc] initWithString:text]];
}

- (void)swizzing_setAttributedText:(NSAttributedString *)attributedText
{
    
    return [self swizzing_setAttributedText:[self getAttributeWithString]];
}

- (CGSize)sizzing_sizeThatFits:(CGSize)size
{
    size.width = size.width - (self.textContentEdgeInsets.left + self.textContentEdgeInsets.right);
    CGSize fixedSize = [self sizzing_sizeThatFits:size];
    fixedSize.height += (self.textContentEdgeInsets.top + self.textContentEdgeInsets.bottom);
    fixedSize.width += (self.textContentEdgeInsets.left + self.textContentEdgeInsets.right);
    return fixedSize;
}

- (NSMutableAttributedString *)getAttributeWithString
{
    return [self.text mutableAttributedStringWithPattens:[self patterns] font:self.font];
}

- (void)addPattern:(id<YMRichMapMarkProtocol>)pattern
{
    [[self patterns] addObject:pattern];
}

- (NSMutableArray *)patterns
{
    NSMutableArray *patterns = objc_getAssociatedObject(self, _cmd);
    if (patterns == nil) {
        patterns = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, _cmd, patterns, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return patterns;
}

@end
