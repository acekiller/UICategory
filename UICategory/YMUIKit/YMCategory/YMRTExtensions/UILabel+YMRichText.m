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

- (CGRect)attr:(NSAttributedString *)attr
{
    return [attr boundingRectWithSize:UIEdgeInsetsInsetRect(self.bounds, self.textContentEdgeInsets).size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    return [attr drawWithRect:UIEdgeInsetsInsetRect(self.bounds, self.textContentEdgeInsets) options:NSStringDrawingUsesFontLeading context:nil];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    CGPoint pos    = [touch locationInView:self];
//    CGPoint offset = CGPointMake(self.textContentEdgeInsets.left, self.textContentEdgeInsets.top);
//    CGSize sizeLimited = CGSizeMake(self.frame.size.width - (self.textContentEdgeInsets.left + self.textContentEdgeInsets.right), self.frame.size.height - (self.textContentEdgeInsets.top + self.textContentEdgeInsets.bottom));
//    - (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(nullable NSStringDrawingContext *)context NS_AVAILABLE(10_11, 6_0);
    
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length)
                                            options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                         usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
                                             NSAttributedString *attrStr = [self.attributedText attributedSubstringFromRange:NSMakeRange(0, range.location + range.length)];
                                             CGRect rect = [self attr:attrStr];
                                             
                                             rect.origin = CGPointMake(self.textContentEdgeInsets.left, self.textContentEdgeInsets.top);
                                             
                                             if (CGRectContainsPoint(rect, pos)) {
                                                 NSLog(@"range : %@", NSStringFromRange(range));
                                                 *stop = YES;
                                             }
                                             
                                         }];
    
    
//    int sizes[self.attributedText.length];
//    for ( int i=0; i<self.text.length; i++ )
//    {
//        char letter         = [self.text characterAtIndex:i];
//        NSString *letterStr = [NSString stringWithFormat:@"%c", letter];
////        [self.attributedText attributedSubstringFromRange:<#(NSRange)#>];
//        [self.attributedText size];
//        CGSize letterSize   = [letterStr sizeWithFont:self.font];
//        sizes[i]            = letterSize.width;
//    }
//    
//    int sum = 0;
//    for ( int i=0; i<self.text.length; i++)
//    {
//        sum += sizes[i];
//        if ( sum >= pos.x )
//        {
////            [ _delegate didLetterFound:[ self.text characterAtIndex:i] ];
//            NSLog(<#NSString * _Nonnull format, ...#>)
//            return;
//        }
//    }
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [[touches allObjects] objectAtIndex:0];
//    CGPoint pos    = [touch locationInView:self];
//    
//    int sizes[self.text.length];
//    for ( int i=0; i<self .text.length; i++ )
//    {
//        char letter         = [self.text characterAtIndex:i];
//        NSString *letterStr = [NSString stringWithFormat:@"%c", letter];
//        
//        CGSize letterSize   = [letterStr sizeWithFont:self.font];
//        sizes[i]            = letterSize.width;
//    }
//    
//    int sum = 0;
//    for ( int i=0; i<self.text.length; i++)
//    {
//        sum += sizes[i];
//        if ( sum >= pos.x )
//        {
//            [ _delegate didLetterFound:[ self.text characterAtIndex:i] ];
//            return;
//        }
//    }
//}

@end
