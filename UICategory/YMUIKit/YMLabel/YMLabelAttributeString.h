//
//  YMLabelAttributeString.h
//  UICategory
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMLabelAttributeString : NSObject
@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) NSAttributedString *attributeString;
@property (nonatomic, assign) BOOL isAttachement;
@end
