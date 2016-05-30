//
//  UILabel+YMRichText.h
//  UICategory
//
//  Created by fantasy on 16/5/17.
//  Copyright © 2016年 goappbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+ContentEdgetInsets.h"
#import "YMRichMapMarkProtocol.h"

@interface UILabel (YMRichText)

- (void)addPattern:(id<YMRichMapMarkProtocol>)pattern;

@end
