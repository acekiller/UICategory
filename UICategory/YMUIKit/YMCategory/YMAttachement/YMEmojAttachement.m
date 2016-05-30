//
//  YMEmojAttachement.m
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMEmojAttachement.h"

@interface YMEmojAttachement ()
@property (nonatomic, copy) UIFont *font;
@end

@implementation YMEmojAttachement

- (void)setPatternResult:(YMPatternResults *)result
{
    if (result.directory) {
        self.image = [UIImage imageWithContentsOfFile:[[result directory] stringByAppendingPathComponent:result.showString]];
    } else {
        self.image = [UIImage imageNamed:result.showString];
    }
    self.font = result.font;
}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer
                      proposedLineFragment:(CGRect)lineFrag
                             glyphPosition:(CGPoint)position
                            characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0.f, 0.f, self.font.pointSize, self.font.pointSize);
}

@end
