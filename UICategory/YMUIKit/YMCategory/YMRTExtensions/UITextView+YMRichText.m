//
//  UITextView+YMRichText.m
//  UICategory
//
//  Created by fengxijun on 5/11/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "UITextView+YMRichText.h"
#import <objc/runtime.h>
#import "YMImageAttachement.h"
#import "YMOtherAttachement.h"
#import "NSString+YMRTPattern.h"
#import "Swizzling.h"

@implementation UITextView (YMRichText)

+ (void) load
{
    static dispatch_once_t swizzing_once;
    dispatch_once(&swizzing_once, ^{
        swizzleSelector(self, @selector(setAttributedText:), @selector(swizzing_setAttributedText:));
    });
}

- (void)insertAttachementWithPath:(NSString *)filepath range:(NSRange)range
{
    YMOtherAttachement *attachement = [[YMOtherAttachement alloc] initWithFilePath:filepath];
    NSAttributedString *attachementString = [NSAttributedString attributedStringWithAttachment:attachement];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString insertAttributedString:attachementString
                                     atIndex:self.attributedText.length];
    
    self.attributedText = attributedString;
    self.selectedRange = NSMakeRange(range.location + 1, 0);
}

- (void)insertAttachementToSelectedRangeWithPath:(NSString *)filepath
{
    [self insertAttachementWithPath:filepath range:self.selectedRange];
}

- (void)addAttachementWithPath:(NSString *)filepath
{
    YMOtherAttachement *attachement = [[YMOtherAttachement alloc] initWithFilePath:filepath];
    NSAttributedString *attachementString = [NSAttributedString attributedStringWithAttachment:attachement];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString insertAttributedString:attachementString
                                     atIndex:self.attributedText.length];
    
    self.attributedText = attributedString;
    self.selectedRange = NSMakeRange(self.selectedRange.location + 1, self.selectedRange.length);
}

- (void)addSeprateLine
{
}

- (void)insertImageToSelectedRange:(UIImage *)image
{
    YMImageAttachement *attachement = [[YMImageAttachement alloc] initWithImage:image];
    NSAttributedString *attachementString = [NSAttributedString attributedStringWithAttachment:attachement];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString insertAttributedString:attachementString
                                     atIndex:self.selectedRange.location];
    self.attributedText = attributedString;
    self.selectedRange = NSMakeRange(self.selectedRange.location + 1, self.selectedRange.length);
}

- (void)addImage:(UIImage *)image
{
    YMImageAttachement *attachement = [[YMImageAttachement alloc] initWithImage:image];
    NSAttributedString *attachementString = [NSAttributedString attributedStringWithAttachment:attachement];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString insertAttributedString:attachementString
                                     atIndex:self.attributedText.length];
    [self.textStorage setAttributedString:attributedString];
    self.selectedRange = NSMakeRange(self.selectedRange.location + 1, self.selectedRange.length);
}


#pragma ----
#pragma mark --Draw Methods

//- (void)swizzing_setText:(NSString *)text
//{
//    [self swizzing_setText:text];
//    [self setAttributedText:[[NSAttributedString alloc] initWithString:text]];
//}

- (void)swizzing_setAttributedText:(NSAttributedString *)attributedText
{
    return [self swizzing_setAttributedText:[self getAttributeWithAttributeString:attributedText]];
}

#pragma mark --Draw Methods

- (NSMutableAttributedString *)getAttributeWithAttributeString:(NSAttributedString *)attrStr
{
    return [attrStr.string mutableAttributedStringWithPattens:[self patterns] font:self.font];
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
