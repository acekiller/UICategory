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
    self.image = [UIImage imageNamed:@"emoji_02"];
}

//- (UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex
//{
//    return [UIImage imageNamed:@"service_head"];
//}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0.f, 0.f, 15.f, 15.f);
}

@end
