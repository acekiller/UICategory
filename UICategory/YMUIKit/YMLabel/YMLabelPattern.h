//
//  YMLabelPattern.h
//  UICategory
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMLabelTextPatternProtocol.h"

@interface YMLabelPattern : NSObject
<
    YMLabelTextPatternProtocol
>

- (instancetype)initWithRegex:(NSString *)regex isAttachement:(BOOL)isAttachement NS_DESIGNATED_INITIALIZER;

@end
