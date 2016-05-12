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

- (NSDictionary *)styleParams:(NSString *)result;

- (NSString *)showString:(NSString *)result;

- (NSString *)formatResourceAdjustString:(NSString *)result;

#pragma mark --Attachement Method
/**
 *  YMRichPatternWithAttachement    类型数据解析类
 */
- (Class)attachementClass;

/**
 *  YMRichTextPatternWithAttribute 类型数据解析参数
 */
- (Class)styleParamsParserClass;

@end
