//
//  NSString+YMRTPattern.h
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMPatternResults;
@protocol YMRichMapMarkProtocol;

@interface NSString (YMRTPattern)

+ (void)registerPatternParserModel:(id<YMRichMapMarkProtocol>)model;

- (NSArray <id<YMRichMapMarkProtocol>> *)registerPatterns;

- (NSArray <YMPatternResults *>* )patternResultWithPattern:(id<YMRichMapMarkProtocol>)pattern;

- (NSMutableAttributedString *)mutableAttributedStringWithAllRegisterPattern;

- (NSMutableAttributedString *)mutableAttributedStringWithPattens:(NSArray *)richTextMarkMaps;

- (NSMutableAttributedString *)mutableAttributedStringWithPattens:(NSArray *)richTextMarkMaps font:(UIFont *)font;

@end
