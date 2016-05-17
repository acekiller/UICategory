//
//  YMLabelTextParser.m
//  TestDemo
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMLabelTextParser.h"
#import <CoreText/CoreText.h>
#import "YMLabelParamsConfig.h"
#import "YMLabelAttributeString.h"
#import "NSRegularExpression+YMRTPattern.h"

@interface YMLabelTextParser ()
@property (nonatomic, strong) NSMutableArray *linkRanges;
@property (nonatomic, strong) NSAttributedString *attributedText;

- (NSArray *) getAttributedStringsWithText:(NSString *)text pattern:(id<YMLabelTextPatternProtocol>)pattern;

@end

@implementation YMLabelTextParser
{
    NSMutableArray *defaultPatterns;
}

- (instancetype) initWithParsers:(YMLabelTextParserDefaultPatternType)type
{
    self = [super init];
    if (self) {
        self.linkRanges = [[NSMutableArray alloc] init];
        _config = [[YMLabelParamsConfig alloc] init];
        defaultPatterns = [[NSMutableArray alloc] init];
        [self loadDefaultParsers:type];
    }
    return self;
}

- (instancetype) init
{
    return [self initWithParsers:YMLabelTextParserNone];
}

- (void) loadDefaultParsers:(YMLabelTextParserDefaultPatternType)type
{
}

- (void) addParserPattern:(id)pattern
{
    if (pattern == nil) {
        return;
    }
    [defaultPatterns addObject:pattern];
}

- (void) removeParserPattern:(id)pattern
{
    if (pattern == nil) {
        return;
    }
    [defaultPatterns removeObject:pattern];
}

- (void) removeAllParserPattern
{
    [defaultPatterns removeAllObjects];
}

- (NSAttributedString *)parserText
{
    return [self parserTextWithPatterns:defaultPatterns];
}

- (NSAttributedString *)parserTextWithPatterns:(NSArray *)patterns
{
    if (self.text == nil) {
        return nil;
    }
    [self.linkRanges removeAllObjects];
    NSMutableAttributedString * content = [[NSMutableAttributedString alloc] initWithString:self.text
                                                                                 attributes:[self.config attributedStringAttributes]];
    
    NSArray *patternResults = [[self getlabelAttributeStrings:self.text patterns:patterns] sortedArrayUsingComparator:^NSComparisonResult(YMLabelAttributeString *obj1, YMLabelAttributeString *obj2) {
        return (obj1.range.location > obj2.range.location) ? NSOrderedAscending : NSOrderedDescending;
    }];
    
    for (YMLabelAttributeString *ymStr in patternResults) {
        [content replaceCharactersInRange:ymStr.range withAttributedString:ymStr.attributeString];
    }
    
    self.attributedText = content;
    return content;
}

- (NSArray *)getlabelAttributeStrings:(NSString *)text patterns:(NSArray *)patterns
{
    NSMutableArray *attrStrArr = [[NSMutableArray alloc] init];
    
    for (id <YMLabelTextPatternProtocol> pattern in patterns) {
        [attrStrArr addObjectsFromArray:[self getAttributedStringsWithText:text pattern:pattern]];
    }
    
    return attrStrArr;
}

- (void)setText:(NSString *)text
{
    _text = text;
}

- (void)catchAttributesInIndex:(NSInteger)index
                 completeBlock:(void (^)(NSDictionary *, NSRange))completeBlock
{
    if (self.attributedText == nil || self.attributedText.length - 1 < index) {
        return;
    }
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length)
                                            options:NSAttributedStringEnumerationReverse
                                         usingBlock:^(NSDictionary *attributes, NSRange range, BOOL * _Nonnull stop) {
                                             if (NSLocationInRange(index, range)) {
                                                 completeBlock(attributes,range);
                                                 *stop = YES;
                                             }
                                         }];
    
}

- (NSArray *) getAttributedStringsWithText:(NSString *)text pattern:(id<YMLabelTextPatternProtocol>)pattern
{
    
    NSRegularExpression *rex = [NSRegularExpression regularExpressionWithPattern:[pattern regex]
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
    NSArray *matchResults = [rex matchesResults:text];
    NSMutableArray *rexFilterResult = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *result in matchResults) {
        YMLabelAttributeString *filter = [[YMLabelAttributeString alloc] init];
        filter.range = result.range;
        filter.isAttachement = [pattern isAttachement];
        NSString *regexResult = [text substringWithRange:filter.range];
        if (filter.isAttachement) {
            filter.attributeString = [self attachementAttributeString:[pattern parserShowOrResourceString:regexResult] attributes:[pattern parserAttributes:regexResult]];
        } else {
            filter.attributeString = [self attributedTextString:[pattern parserShowOrResourceString:regexResult] attributes:[pattern parserAttributes:regexResult]];
        }
        [rexFilterResult addObject:filter];
    }
    return rexFilterResult;
}

- (NSAttributedString *)attachementAttributeString:(NSString *)imageName attributes:(NSDictionary *)attributes
{
    NSTextAttachment *attachement = [[NSTextAttachment alloc] init];
    attachement.image = [UIImage imageNamed:imageName];
    unichar ch = 0xFFFC;
    NSMutableDictionary *mult_attr = [[NSMutableDictionary alloc] initWithDictionary:[self.config attachementRenderAttributes:attachement]];
    if (attributes) {
        [mult_attr addEntriesFromDictionary:attributes];
    }
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]
                                              initWithString:[NSString stringWithCharacters:&ch length:1]
                                              attributes:mult_attr];
    
    return attrString;
}

- (NSAttributedString *)attributedTextString:(NSString *)string attributes:(NSDictionary *)attributes
{
    NSMutableDictionary *mult_attr = [[NSMutableDictionary alloc] initWithDictionary:[self.config linkAttributes]];
    if (attributes) {
        [mult_attr addEntriesFromDictionary:attributes];
    }
    
    NSAttributedString *link = [[NSAttributedString alloc] initWithString:string
                                                               attributes:mult_attr];
    return link;
}


@end
