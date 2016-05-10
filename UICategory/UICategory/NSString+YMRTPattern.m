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
    NSRegularExpression *rex = [NSRegularExpression regularExpressionWithPattern:[pattern regular] options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matchResults = [rex matchesResults:self];
    NSMutableArray *rexFilterResult = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *result in matchResults) {
        YMPatternResults *filter = [[YMPatternResults alloc] init];
        filter.range = result.range;
        filter.result = [self substringWithRange:result.range];
        NSLog(@"%@ : %@",NSStringFromRange(filter.range), filter.result);
        [rexFilterResult addObject:filter];
    }
    return rexFilterResult;
}

- (NSMutableAttributedString *)mutableAttributedStringWithAllRegisterPattern
{
    return [self mutableAttributedStringWithPattens:[self registerPatterns]];
}

- (NSMutableAttributedString *)mutableAttributedStringWithPattens:(NSArray *)richTextMarkMaps
{
    NSMutableString *str = [[NSMutableString alloc] initWithString:self];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
    for (id<YMRichMapMarkProtocol> pattern in richTextMarkMaps) {
        NSArray *patternResults = [str patternResultWithPattern:pattern];
        for (NSInteger i = [patternResults count] - 1; i >= 0; i--) {
            YMPatternResults *result = patternResults[i];
            if ([pattern patternType] == YMRichPatternWithAttachement) {
                [attr replaceCharactersInRange:[result range] withString:@""];
                [attr insertAttributedString:[NSAttributedString attributedStringWithAttachment:[pattern attachementWithPattenResult:result]] atIndex:result.range.location];
            }
        }
    }
    return attr;
}

@end
