//
//  YMPatternResults.h
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/NSTextAttachment.h>
@protocol YMRichMapMarkProtocol;

@interface YMPatternResults : NSObject

- (instancetype) initWithString:string checkResult:(NSTextCheckingResult *)checkResult pattern:(id<YMRichMapMarkProtocol>)pattern;

@property (nonatomic, assign) NSRange range;

@property (nonatomic, strong) NSString *result;

@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, strong) NSString *formatUseName;

@property (nonatomic, strong) NSAttributedString *attributeString;

@end
