//
//  NSRegularExpression+YMRTPattern.m
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "NSRegularExpression+YMRTPattern.h"

@implementation NSRegularExpression (YMRTPattern)

- (NSArray *)matchesResults:(NSString *)string
{
    NSArray *results = [self matchesInString:string options:NSMatchingWithTransparentBounds range:NSMakeRange(0, [string length])];
    
    return results;
}

@end
