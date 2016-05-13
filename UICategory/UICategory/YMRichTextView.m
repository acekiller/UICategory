//
//  YMRichTextView.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMRichTextView.h"
#import <CoreText/CoreText.h>
#import "YMImageAttachement.h"
#import "YMOtherAttachement.h"
//#import "Swizzling.h"

@interface YMRichTextView ()
@property (nonatomic, strong) NSMutableAttributedString *multAttributedString;
@end

@implementation YMRichTextView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"layoutManager : %@",self.layoutManager);
        NSLog(@"textContainer : %@",self.textContainer);
        NSLog(@"textStorage.layoutManagers : %@",self.textStorage.layoutManagers);
    }
    return self;
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
    self.attributedText = attributedString;
    self.selectedRange = NSMakeRange(self.selectedRange.location + 1, self.selectedRange.length);
}

@end
