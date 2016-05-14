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
    self.image = [UIImage imageNamed:result.showString];
}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0.f, 0.f, 30.f, 30.f);
}

@end
