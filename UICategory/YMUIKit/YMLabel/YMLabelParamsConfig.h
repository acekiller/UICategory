//
//  YMLabelParamsConfig.h
//  UICategory
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YMLabelParamsConfig : NSObject

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *linkTextColor;

- (NSMutableDictionary *)attributedStringAttributes;

- (NSMutableDictionary *)attachementRenderAttributes:(NSTextAttachment *)attachement;

- (NSMutableDictionary *)linkAttributes;

@end
