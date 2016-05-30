//
//  YMLabelTextPatternProtocol.h
//  UICategory
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YMLabelAttributeString.h"

@protocol YMLabelTextPatternProtocol <NSObject>

@property (nonatomic, strong) NSString *regex;

@property (nonatomic, assign) BOOL isAttachement;

- (NSString *)parserShowOrResourceString:(NSString *)regexResult;

- (NSDictionary *)parserAttributes:(NSString *)regexResult;

- (CGSize) maxSizeLimited;

@end
