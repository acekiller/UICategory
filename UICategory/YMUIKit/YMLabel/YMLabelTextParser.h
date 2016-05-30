//
//  YMLabelTextParser.h
//  TestDemo
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMLabelParamsConfig.h"
#import "YMLabelTextPatternProtocol.h"

typedef NS_ENUM(NSUInteger,YMLabelTextParserDefaultPatternType) {
    YMLabelTextParserNone = 0,
    YMLabelTextParserWithURL = 1 << 0,
    YMLabelTextParserPhone = 1 << 1,
    YMLabelTextParserEmail = 1 << 2,
};

@interface YMLabelTextParser : NSObject

@property (nonatomic, strong) YMLabelParamsConfig *config;

@property (nonatomic, strong) NSString *text;

- (instancetype) initWithParsers:(YMLabelTextParserDefaultPatternType)type NS_DESIGNATED_INITIALIZER;

- (void) addParserPattern:(id<YMLabelTextPatternProtocol>)pattern;

- (void) removeParserPattern:(id<YMLabelTextPatternProtocol>)pattern;

- (void) removeAllParserPattern;

- (NSAttributedString *)parserText;

- (NSAttributedString *)parserTextWithPatterns:(NSArray *)patterns;

- (void)catchAttributesInIndex:(NSInteger)index completeBlock:(void(^)(NSDictionary *attributes, NSRange range))completeBlock;

@end
