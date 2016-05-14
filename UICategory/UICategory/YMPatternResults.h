//
//  YMPatternResults.h
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol YMRichMapMarkProtocol;

@interface YMPatternResults : NSObject
/**
 *  匹配到的数据在原始数据中的位置
 */
@property (nonatomic, assign) NSRange range;

/**
 *  从原始数据中匹配得到的数据匹配到的数据
 */
@property (nonatomic, strong) NSString *result;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, copy) void(^tapHandler)(NSDictionary *attributes);

/**
 *  从匹配到的数据解析出来的配置参数。用于设置到NSAttributedString对象的参数。数据的解析由YMRichMapMarkProtocol协议中的- (NSDictionary *)styleParams:(NSString *)result;方法来实现。
 */
@property (nonatomic, strong) NSDictionary *params;

//@property (nonatomic, strong) NSString *formatUseName;

@property (nonatomic, strong) NSString *showString;

@property (nonatomic, strong) NSAttributedString *attributeString;

@end
