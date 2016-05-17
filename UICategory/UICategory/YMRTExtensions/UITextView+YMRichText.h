//
//  UITextView+YMRichText.h
//  UICategory
//
//  Created by fengxijun on 5/11/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMRichMapMarkProtocol.h"

@interface UITextView (YMRichText)

- (void)insertAttachementWithPath:(NSString *)filepath range:(NSRange)range;

- (void)insertAttachementToSelectedRangeWithPath:(NSString *)filepath;

- (void)addAttachementWithPath:(NSString *)filepath;

- (void)insertImageToSelectedRange:(UIImage *)image;

- (void)addImage:(UIImage *)image;

- (void)addSeprateLine;

- (void)addPattern:(id<YMRichMapMarkProtocol>)pattern;

@end
