//
//  YMLabelTextParser.h
//  TestDemo
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,YMLabelTextParserDefaultPatternType) {
    YMLabelTextParserNone = 0,
    YMLabelTextParserWithURL = 1 << 0,
    YMLabelTextParserPhone = 1 << 1,
    YMLabelTextParserEmail = 1 << 2,
};

@interface YMLabelTextParser : NSObject

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *font;

/*!
 *  @brief 文本-超链接映射
 */
@property (nonatomic, strong) NSDictionary * hyperlinkMapper;
/*!
 *  @brief 文本-表情映射
 */
@property (nonatomic, strong) NSDictionary * emojiTextMapper;

- (instancetype) initWithParsers:(YMLabelTextParserDefaultPatternType)type NS_DESIGNATED_INITIALIZER;

- (void) addParserPattern:(id)pattern;

- (void) removeParserPattern:(id)pattern;

- (void) removeAllParserPattern;

- (NSAttributedString *)parserText:(NSString *)text;

- (NSAttributedString *)parserText:(NSString *)text withParserPatterns:(NSArray *)patterns;

@end
