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

/**
 *  用于从匹配到的数据中解析NSAttributedString对象的参数。
 *
 */
- (NSDictionary *)styleParams:(NSString *)result;

/**
 *  用于从匹配到的数据中解析出用于显示或获取到显示模型的数据。
 *
 */
- (NSString *)showString:(NSString *)result;

- (YMPatternResults *)patternResultStringFromString:(NSString *)string
                                        checkResult:(NSTextCheckingResult *)checkResult;

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
