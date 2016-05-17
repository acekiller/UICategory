//
//  YMImageAttachement.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMImageAttachement.h"

@interface YMImageAttachement ()
@property (nonatomic, assign) CGSize size;
@end

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
    NSDictionary *dic = [result params];
    self.size = CGSizeMake([dic[@"width"] floatValue], [dic[@"height"] floatValue]);
}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        return CGRectMake(0.f, 0.f, 15.f, 15.f);
    }
    return CGRectMake(0.f, 0.f, self.size.width, self.size.height);
}

@end
