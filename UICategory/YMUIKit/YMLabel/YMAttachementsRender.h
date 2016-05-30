//
//  YMAttachementsRender.h
//  TestDemo
//
//  Created by fengxijun on 5/16/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@class YMLabel;

@interface YMAttachementsRender : NSObject

/**
 *  渲染文本Attachement对象。
 *
 *  @param context <#context description#>
 *  @param label   <#label description#>
 *  @param frame   <#frame description#>
 */
- (void)renderAttachementsToContext:(CGContextRef)context toLabel:(YMLabel *)label frame:(CTFrameRef)frame;

/**
 *  获取给定点的NSTextAttachement对象。当给定点不存在NSTextAttachement对象时反回空值。
 *
 *  @param point 要获取Attachement对象的point点
 *
 *  @return 当point点不存在NSTextAttachement对象时，返回空。
 */
- (NSTextAttachment *)getAttachementWithPoint:(CGPoint)point;

@end
