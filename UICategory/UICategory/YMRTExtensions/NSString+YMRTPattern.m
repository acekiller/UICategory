//
//  NSString+YMRTPattern.m
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "NSString+YMRTPattern.h"
#import "YMRichMapMarkProtocol.h"
#import "NSRegularExpression+YMRTPattern.h"

@implementation NSString (YMRTPattern)

static NSMutableArray *patternModels;

+ (void) load
{
    static dispatch_once_t pattern_once;
    dispatch_once(&pattern_once, ^{
        [self loadDefaultPattern];
    });
}

+ (void)loadDefaultPattern
{
    if (patternModels == nil) {
        patternModels = [[NSMutableArray alloc] init];
    }
}

+ (void)registerPatternParserModel:(id<YMRichMapMarkProtocol>)model
{
    [patternModels addObject:model];
}

- (NSArray *)registerPatterns {
    return patternModels;
}

- (NSArray <YMPatternResults *>* )patternResultWithPattern:(id<YMRichMapMarkProtocol>)pattern
{
    return [self patternResultWithPattern:pattern font:nil];
}

- (NSArray <YMPatternResults *>* )patternResultWithPattern:(id<YMRichMapMarkProtocol>)pattern font:(UIFont *)font
{
    NSRegularExpression *rex = [NSRegularExpression regularExpressionWithPattern:[pattern regular]
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
    NSArray *matchResults = [rex matchesResults:self];
    NSMutableArray *rexFilterResult = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *result in matchResults) {
        YMPatternResults *filter = [pattern patternResultStringFromString:self
                                                              checkResult:result
                                                                     font:font];
        [rexFilterResult addObject:filter];
    }
    return rexFilterResult;
}

- (NSArray <YMPatternResults *>* )patternResultWithPatterns:(NSArray <id<YMRichMapMarkProtocol>> *)patterns {
    return [self patternResultWithPatterns:patterns font:nil];
}

- (NSArray <YMPatternResults *>* )patternResultWithPatterns:(NSArray <id<YMRichMapMarkProtocol>> *)patterns font:(UIFont *)font {
    NSMutableArray *patternResults = [[NSMutableArray alloc] init];
    for (id<YMRichMapMarkProtocol> pattern in patterns) {
        [patternResults addObjectsFromArray:[self patternResultWithPattern:pattern font:font]];
    }
    
    return patternResults;
}

- (NSMutableAttributedString *)mutableAttributedStringWithAllRegisterPattern
{
    return [self mutableAttributedStringWithPattens:[self registerPatterns]];
}

- (NSMutableAttributedString *)mutableAttributedStringWithPattens:(NSArray *)richTextMarkMaps
{
    return [self mutableAttributedStringWithPattens:richTextMarkMaps font:nil];
}

- (NSMutableAttributedString *)mutableAttributedStringWithPattens:(NSArray *)richTextMarkMaps font:(UIFont *)font
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:self];
    
    NSArray *patternResults = [[str patternResultWithPatterns:richTextMarkMaps font:font] sortedArrayUsingComparator:^NSComparisonResult(YMPatternResults *obj1, YMPatternResults *obj2) {
        return (obj1.range.location < obj2.range.location) ? NSOrderedAscending : NSOrderedDescending;
    }];
    
    for (NSInteger i = [patternResults count] - 1; i >= 0; i--) {
        YMPatternResults *result = patternResults[i];
        NSAttributedString *attrStr = result.attributeString;
        if (!attrStr) {
            continue;
        }
        [attr replaceCharactersInRange:[result range]
                  withAttributedString:result.attributeString];
    }
    return attr;
}

@end
