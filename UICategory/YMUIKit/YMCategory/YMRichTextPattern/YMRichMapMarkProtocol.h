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
#import <UIKit/UIKit.h>

@protocol YMRichTextConfigProtocol;

@protocol YMRichMapMarkProtocol <NSObject>

@property (nonatomic, strong) NSString *regular;

@property (nonatomic, assign) YMRichPatternType patternType;

@property (nonatomic, assign) id <YMRichTextConfigProtocol> delegate;

@property (nonatomic, strong) NSString *directory;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, copy) void(^tapHandler)(NSDictionary *attributes);

- (instancetype) initWithFont:(UIFont *)font
                     delegate:(id <YMRichTextConfigProtocol>)delegate;

- (instancetype) initWithFont:(UIFont *)font;

- (instancetype) initWithDelegate:(id <YMRichTextConfigProtocol>)delegate;

- (instancetype) initWithResourceDiretory:(NSString *)directory font:(UIFont *)font delegate:(id<YMRichTextConfigProtocol>)delegate;

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

- (YMPatternResults *)patternResultStringFromString:(NSString *)string
                                        checkResult:(NSTextCheckingResult *)checkResult
                                               font:(UIFont *)font;

#pragma mark --Attachement Method
/**
 *  YMRichPatternWithAttachement    类型数据解析类
 */
- (Class)attachementClass;

@end

@protocol YMRichTextConfigProtocol <NSObject>

@end