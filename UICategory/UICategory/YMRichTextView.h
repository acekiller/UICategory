//
//  YMRichTextView.h
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMRichTextView : UITextView

- (void)insertAttachementWithPath:(NSString *)filepath range:(NSRange)range;

- (void)insertAttachementToSelectedRangeWithPath:(NSString *)filepath;

- (void)addAttachementWithPath:(NSString *)filepath;

- (void)insertImageToSelectedRange:(UIImage *)image;

- (void)addImage:(UIImage *)image;

- (void)addSeprateLine;

@end
