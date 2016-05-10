//
//  UILabel+ContentEdgetInsets.h
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMRichMapMarkProtocol.h"

@interface UILabel (ContentEdgetInsets)

@property (nonatomic, assign) UIEdgeInsets textContentEdgeInsets;

@property (nonatomic, assign) CGFloat cornerRadius;

- (void)addPattern:(id<YMRichMapMarkProtocol>)pattern;

@end
