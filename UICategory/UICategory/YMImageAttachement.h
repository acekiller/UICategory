//
//  YMImageAttachement.h
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMImageAttachement : NSTextAttachment

- (instancetype) initWithFilePath:(NSString *)filepath;

- (instancetype) initWithImage:(UIImage *)image;

- (instancetype) initWithData:(NSData *)contentData ofType:(NSString *)uti NS_UNAVAILABLE;

@end
