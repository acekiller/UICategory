//
//  YMImageAttachement.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMImageAttachement.h"

@implementation YMImageAttachement

- (instancetype) initWithFilePath:(NSString *)filepath
{
    return [self initWithImage:[UIImage imageWithContentsOfFile:filepath]];
}

- (instancetype) initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.image = image;
    }
    return self;
}

- (void)setPatternResult:(YMPatternResults *)result
{
    self.image = [UIImage imageNamed:@"emoji_102"];
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
