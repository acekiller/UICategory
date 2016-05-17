//
//  YMImagePattern.m
//  UICategory
//
//  Created by fengxijun on 5/12/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMImagePattern.h"
#import "YMImageAttachement.h"

@implementation YMImagePattern

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.regular = @"(<image [\\S\\s ]+>)";
        self.patternType = YMRichPatternWithAttachement;
    }
    return self;
}

- (Class)attachementClass
{
    return [YMImageAttachement class];
}

- (NSString *)showString:(NSString *)result
{
    NSDictionary *dic = [self params:[self replacePatternPrefixAndSubfix:result]];
    return [dic valueForKey:@"name"];
}

- (NSDictionary *)params:(NSString *)soruce {
    NSArray *array = [soruce componentsSeparatedByString:@" "];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSString *value in array) {
        NSArray *tmp_arr = [value componentsSeparatedByString:@":"];
        [result setObject:[tmp_arr lastObject] forKey:tmp_arr.firstObject];
    }
    return result;
}

- (NSDictionary *)styleParams:(NSString *)result
{
    return [self params:[self replacePatternPrefixAndSubfix:result]];
}

- (NSString *)replacePatternPrefixAndSubfix:(NSString *)string
{
    NSMutableString *multString = [string mutableCopy];
    [multString replaceCharactersInRange:NSMakeRange(0, 7) withString:@""];
    [multString replaceCharactersInRange:NSMakeRange([multString length] - 1, 1) withString:@""];
    return multString;
}

@end
