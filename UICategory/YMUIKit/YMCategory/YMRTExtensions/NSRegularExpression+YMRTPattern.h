//
//  NSRegularExpression+YMRTPattern.h
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSRegularExpression (YMRTPattern)
- (NSArray *)matchesResults:(NSString *)string;
@end
