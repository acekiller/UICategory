//
//  YMAttachementsRender.m
//  TestDemo
//
//  Created by fengxijun on 5/16/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMAttachementsRender.h"
#import <CoreText/CoreText.h>
#import "YMLabel.h"

@interface YMAttachementsRender ()
@property (nonatomic, strong) NSMutableDictionary *renderAttachmentMaps;
@end

@implementation YMAttachementsRender

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.renderAttachmentMaps = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)renderAttachementsToContext:(CGContextRef)context toLabel:(YMLabel *)label frame:(CTFrameRef)frame
{
    [self.renderAttachmentMaps removeAllObjects];
    
    //遍历文本行以及CTRunRef，将表情文本对应的表情图片绘制到图形上下文
    
    CFArrayRef lines = CTFrameGetLines(frame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
    
    for (int idx = 0; idx < CFArrayGetCount(lines); idx++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, idx);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        //遍历字符组
        for (int index = 0; index < CFArrayGetCount(runs); index++) {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[idx];
            CTRunRef run = CFArrayGetValueAtIndex(runs, index);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, NULL);
            runRect = CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            //查找表情文本替换表情视图
            NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);
            NSTextAttachment *attachement = attributes[NSStringFromClass(NSTextAttachment.class)];
            if (attachement) {
                CGRect imageDrawRect;
                CGFloat imageSize = ceil(runRect.size.height);
                imageDrawRect.size = CGSizeMake(imageSize, imageSize);
                imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x + label.textContainerInsets.left;
                imageDrawRect.origin.y = lineOrigin.y + label.textContainerInsets.top;
                CGContextDrawImage(context, imageDrawRect, attachement.image.CGImage);
//                [self delayShowRect:imageDrawRect context:context image:attachement.image];
                
                imageDrawRect.origin.y = label.frame.size.height - imageDrawRect.origin.y - imageDrawRect.size.height;
                self.renderAttachmentMaps[NSStringFromCGRect(imageDrawRect)] = attachement;
            }
        }
    }
}

-(void)delayShowRect:(CGRect)imageDrawRect context:(CGContextRef)ctx image:(UIImage *)image
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3000.f), dispatch_get_main_queue(), ^{
        CGContextDrawImage(ctx, imageDrawRect, image.CGImage);
    });
}

- (NSTextAttachment *)getAttachementWithPoint:(CGPoint)point
{
    for (NSString * rectString in self.renderAttachmentMaps) {
        CGRect textRect = CGRectFromString(rectString);
        if (CGRectContainsPoint(textRect, point)) {
            return self.renderAttachmentMaps[rectString];
        }
    }
    return nil;
}

@end
