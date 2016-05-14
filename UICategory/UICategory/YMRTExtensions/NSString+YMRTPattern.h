//
//  NSString+YMRTPattern.h
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YMPatternResults;
@protocol YMRichMapMarkProtocol;

@interface NSString (YMRTPattern)

+ (void)registerPatternParserModel:(id<YMRichMapMarkProtocol>)model;

- (NSArray <id<YMRichMapMarkProtocol>> *)registerPatterns;

- (NSArray <YMPatternResults *>* )patternResultWithPattern:(id<YMRichMapMarkProtocol>)pattern;

- (NSMutableAttributedString *)mutableAttributedStringWithAllRegisterPattern;

- (NSMutableAttributedString *)mutableAttributedStringWithPattens:(NSArray *)richTextMarkMaps;

@end
