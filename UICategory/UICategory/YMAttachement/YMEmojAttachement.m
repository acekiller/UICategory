//
//  YMEmojAttachement.m
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMEmojAttachement.h"

@implementation YMEmojAttachement

- (void)setPatternResult:(YMPatternResults *)result
{
    self.image = [UIImage imageNamed:result.showString];
}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer
                      proposedLineFragment:(CGRect)lineFrag
                             glyphPosition:(CGPoint)position
                            characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0.f, 0.f, 15.f, 15.f);
}

@end
