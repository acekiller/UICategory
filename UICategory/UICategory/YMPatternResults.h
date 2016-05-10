//
//  YMPatternResults.h
//  UICategory
//
//  Created by fengxijun on 5/10/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import "YMPatternResults.h"
#import "YMRTHead.h"

@interface YMPatternResults : NSObject
@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSDictionary *params;
@end

//@interface YMAttributedPatternResults : YMPatternResults
//@property (nonatomic, strong) NSString *showText;
//@property (nonatomic, strong) NSString *tapUseText;
//@end
//
//@interface YMAttachementPatternResults : YMPatternResults
//@property (nonatomic, strong) UIImage *image;
//@property (nonatomic, strong) NSString *filepath;
//@property (nonatomic, strong) NSString *url;
//@property (nonatomic, strong, readonly) UIImage *showIcon;
//@property (nonatomic, strong) Class attachementClazzName;
//
//- (void)setIcon:(UIImage *)icon;
//
//@end
