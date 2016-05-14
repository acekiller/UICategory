//
//  YMRichTextPattern.h
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMRichMapMarkProtocol.h"

@interface YMRichTextPattern : NSObject
<
    YMRichMapMarkProtocol
>

- (instancetype) initWithFont:(UIFont *)font
                     delegate:(id<YMRichTextConfigProtocol>)delegate NS_DESIGNATED_INITIALIZER;

@end
