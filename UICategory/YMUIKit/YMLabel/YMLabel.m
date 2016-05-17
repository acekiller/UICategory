//
//  YMRichTextLabel.m
//  TestDemo
//
//  Created by fengxijun on 5/16/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMLabel.h"
#import <CoreText/CoreText.h>
#import "YMAttachementsRender.h"
#import "YMLabelTextParser.h"

@interface YMLabel ()

@end

@implementation YMLabel
{
    CTFrameRef _frame;
    YMLabelTextParser *textParser;
    YMAttachementsRender *attachementsRender;
}

#pragma mark initialize Method

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype) init
{
    return [self initWithFrame:CGRectZero];
}

- (void) setUp
{
    textParser = [[YMLabelTextParser alloc] init];
    attachementsRender = [[YMAttachementsRender alloc] init];
    
    self.font = [UIFont systemFontOfSize:15.f];
    self.textColor = [UIColor blackColor];
    self.lineBreakMode = NSLineBreakByTruncatingTail;
}

#pragma mark Property Set & Get Method
- (void) setText:(NSString *)text
{
    _text = text;
    NSAttributedString *attrStr = [textParser parserText:text];
    [self setAttributedText:attrStr];
}

- (void) setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    [self setNeedsDisplay];
}

- (void) setFont:(UIFont *)font
{
    textParser.font = font;
}

- (UIFont *)font
{
    return textParser.font;
}

- (void)setTextColor:(UIColor *)textColor
{
    textParser.textColor = textColor;
}

- (UIColor *)textColor
{
    return textParser.textColor;
}

- (void)setLineBreakModel:(NSLineBreakMode)lineBreakModel
{
    [textParser.paragraphStyle setLineBreakMode:lineBreakModel];
}

- (NSLineBreakMode)lineBreakModel {
    return textParser.paragraphStyle.lineBreakMode;
}

- (void)setLineFragmentPadding:(CGFloat)lineFragmentPadding
{
    [textParser.paragraphStyle setLineSpacing:lineFragmentPadding];;
}

- (CGFloat)lineFragmentPadding
{
    return textParser.paragraphStyle.lineSpacing;
}

- (void)setTextContainerInsets:(UIEdgeInsets)textContainerInsets
{
    _textContainerInsets = textContainerInsets;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat) cornerRadius
{
    return self.layer.cornerRadius;
}

- (void) setEmojiTextMapper:(NSDictionary *)emojiTextMapper
{
    [textParser setEmojiTextMapper:emojiTextMapper];
}

- (void) setHyperlinkMapper:(NSDictionary *)hyperlinkMapper
{
    [textParser setHyperlinkMapper:hyperlinkMapper];
}

#pragma --DrawRect Method

- (void)drawRect: (CGRect)rect
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    if (self.attributedText == nil || [self.attributedText length] <= 0) {
        return;
    }
    if (_frame) {
        CFRelease(_frame);
    }
    //获取图形上下文并且翻转坐标系
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextConcatCTM(ctx, CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height));
    //创建CTFramesetterRef和CTFrameRef变量
    NSAttributedString *content = self.attributedText;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    CGMutablePathRef paths = CGPathCreateMutable();
    CGPathAddRect(paths, NULL, CGRectMake(self.textContainerInsets.left, self.textContainerInsets.top, self.bounds.size.width - (self.textContainerInsets.left + self.textContainerInsets.right), self.bounds.size.height - (self.textContainerInsets.top + self.textContainerInsets.bottom)));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, content.length), paths, NULL);
    
    _frame = frame;
    
    CTFrameDraw(_frame, ctx);
    //遍历文本行以及CTRunRef，将表情文本对应的表情图片绘制到图形上下文
    
    
    [attachementsRender renderAttachementsToContext:ctx toLabel:self frame:frame];
    
    CFRelease(paths);
//    CFRelease(frame);
    CFRelease(framesetter);
}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    CGPoint touchPoint = [touches.anyObject locationInView: self];
//    CFArrayRef lines = CTFrameGetLines(_frame);
//    CGPoint origins[CFArrayGetCount(lines)];
//    
//    for (int idx = 0; idx < CFArrayGetCount(lines); idx++) {
//        CGPoint origin = origins[idx];
//        CGPathRef path = CTFrameGetPath(_frame);
//        CGRect rect = CGPathGetBoundingBox(path);
//        
//        //将坐标点更改为左上角坐标系原点的坐标
//        CGFloat y = rect.origin.y + rect.size.height - origin.y;
//        
////        if (touchPoint.y == origin.x && touchPoint.x == range.location && index <= range.location + range.length) {
////            NSLog(@"点击了图片链接：%@", _textTouchMapper[textRange]);
////            break;
////        }
//    }
//}

- (void)touchesEnded: (NSSet*)touches withEvent: (UIEvent *)event
{
    CGPoint touchPoint = [touches.anyObject locationInView: self];
//    CFArrayRef lines = CTFrameGetLines(_frame);
//    CGPoint origins[CFArrayGetCount(lines)];
//    CTFrameGetLineOrigins(_frame, CFRangeMake(0, 0), origins);
//    CTLineRef line = NULL;
//    CGPoint lineOrigin = CGPointZero;
//    //查找点击坐标所在的文本行
//    for (int idx = 0; idx < CFArrayGetCount(lines); idx++) {
//        CGPoint origin = origins[idx];
//        CGPathRef path = CTFrameGetPath(_frame);
//        CGRect rect = CGPathGetBoundingBox(path);
//        //转换点击坐标
//        CGFloat y = rect.origin.y + rect.size.height - origin.y;
//        if (touchPoint.y = origin.x && touchPoint.x = range.location && index <= range.location + range.length) {
////            if ([_delegate respondsToSelector: @selector(textView:didSelectedHyperlink:)]) {
////                [_delegate textView: self didSelectedHyperlink: self.textTouchMapper[textRange]];
////            }
//            NSLog(@"url tap");
//            return;
//        }
//    }
    
    //判断是否点击表情
    NSTextAttachment *attachement = [attachementsRender getAttachementWithPoint:touchPoint];
    if (attachement && self.delegate != nil && [self.delegate respondsToSelector:@selector(ymLabel:shouldInteractWithTextAttachment:inRange:)]) {
        [self.delegate ymLabel:self shouldInteractWithTextAttachment:attachement inRange:NSMakeRange(0, 0)];
        return;
    }
    
    CFArrayRef lines = CTFrameGetLines(_frame);
    CGPoint origins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(_frame, CFRangeMake(0, 0), origins);
//    CTLineRef line = NULL;
//    CGPoint lineOrigin = CGPointZero;
    
    //查找点击坐标所在的文本行
    for (int idx = 0; idx < CFArrayGetCount(lines); idx++) {
        CGPoint origin = origins[idx];
        CGPathRef path = CTFrameGetPath(_frame);
        CGRect rect = CGPathGetBoundingBox(path);
        //转换点击坐标

        
        CGFloat y = rect.origin.y + rect.size.height - origin.y;
//        if (touchPoint.y = origin.x && touchPoint.x = range.location && index <= range.location + range.length) {
////            if ([_delegate respondsToSelector: @selector(textView:didSelectedHyperlink:)]) {
////                [_delegate textView: self didSelectedHyperlink: self.textTouchMapper[textRange]];
////            }
//            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(ymLabel:shouldInteractWithStringAttributes:inRange:)]) {
//                [self.delegate ymLabel:self shouldInteractWithStringAttributes:nil inRange:NSMakeRange(0, 0)];
//            }
//            break;
//        }
    }
}

@end
