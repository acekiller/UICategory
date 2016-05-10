//
//  YMRichMapMarkProtocol.h
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMPatternResults.h"
#import "YMRTHead.h"
#import <UIKit/NSTextAttachment.h>

@protocol YMRichMapMarkProtocol <NSObject>

@property (nonatomic, strong) NSString *regular;

@property (nonatomic, assign) YMRichPatternType patternType;

#pragma mark --Attribute Metthod

- (NSDictionary *)showStringattributedParams:(YMPatternResults *)result;

- (NSString *)showString:(YMPatternResults *)result;

#pragma mark --Attachement Method
- (Class)attachementClass;

- (NSTextAttachment *)attachementWithPattenResult:(YMPatternResults *)result;

@end
