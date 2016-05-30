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
}

#pragma mark Property Set & Get Method
- (void) setText:(NSString *)text
{
    _text = text;
    textParser.text = text;
    NSAttributedString *attrStr = [textParser parserText];
    [self setAttributedText:attrStr];
}

- (void) setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    [self setNeedsDisplay];
}

- (void) setFont:(UIFont *)font
{
    textParser.config.font = font;
}

- (UIFont *)font
{
    return textParser.config.font;
}

- (void)setTextColor:(UIColor *)textColor
{
    textParser.config.textColor = textColor;
}

- (UIColor *)textColor
{
    return textParser.config.textColor;
}

- (void)setLineBreakModel:(NSLineBreakMode)lineBreakModel
{
    [textParser.config.paragraphStyle setLineBreakMode:lineBreakModel];
}

- (NSLineBreakMode)lineBreakModel {
    return textParser.config.paragraphStyle.lineBreakMode;
}

- (void)setLineFragmentPadding:(CGFloat)lineFragmentPadding
{
    [textParser.config.paragraphStyle setLineSpacing:lineFragmentPadding];;
}

- (CGFloat)lineFragmentPadding
{
    return textParser.config.paragraphStyle.lineSpacing;
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

#pragma mark -
- (void)addPattern:(id<YMLabelTextPatternProtocol>)pattern
{
    [textParser addParserPattern:pattern];
}

#pragma --DrawRect Method

- (void)drawRect: (CGRect)rect
{
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
    
    [attachementsRender renderAttachementsToContext:ctx toLabel:self frame:frame];
    
    CFRelease(paths);
//    CFRelease(frame);
    CFRelease(framesetter);
}

- (void)touchesEnded: (NSSet*)touches withEvent: (UIEvent *)event
{
    CGPoint touchPoint = [touches.anyObject locationInView: self];
    
    if ([self filterAttachemtWithPoint:touchPoint]) {
        return;
    }
    
    [self filterTouchAttributedText:touchPoint frame:_frame];
}

- (BOOL)filterAttachemtWithPoint:(CGPoint)point
{
    //判断是否点击表情
    NSTextAttachment *attachement = [attachementsRender getAttachementWithPoint:point];
    if (!attachement) {
        return NO;
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(ymLabel:shouldInteractWithTextAttachment:inRange:attributes:)]) {
        [self.delegate ymLabel:self shouldInteractWithTextAttachment:attachement inRange:NSMakeRange(0, 0) attributes:nil];
    }
    
    return YES;
}

- (void)filterTouchAttributedText:(CGPoint)point frame:(CTFrameRef)frame {
    CTFrameRef textFrame = frame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) return;
    
    CFIndex count = CFArrayGetCount(lines);
    
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    // 翻转坐标系
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.0f, -1.0f);
    
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        linePoint.x = linePoint.x + self.textContainerInsets.left;
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        // 获得每一行的rect信息
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        if (CGRectContainsPoint(rect, point)) {
            // 将点击的坐标转化为相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect) - self.textContainerInsets.left, CGRectGetMinY(rect) + self.lineFragmentPadding);
            // 获取当前点击坐标对应的字符串偏移量
            CFIndex idx = CTLineGetStringIndexForPosition(line, relativePoint);
            // 判断偏移量是否在链接列表中
            [self catchAttributesInIndex:idx];
            break;
        }
    }
}

- (CGRect)getLineBounds:(CTLineRef)line
                  point:(CGPoint)point {
    CGFloat ascent = 0.0f, descent = 0.0f, leading = 0.0f;
    CGFloat width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y, width, height);
}

- (void)catchAttributesInIndex:(NSInteger)index
{
    __weak typeof(self) weakSelf = self;
    [textParser catchAttributesInIndex:index
                         completeBlock:^(NSDictionary *attributes, NSRange range) {
                             __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([strongSelf.delegate respondsToSelector:@selector(ymLabel:shouldInteractWithStringAttributes:
                                                              inRange:)]) {
            [strongSelf.delegate ymLabel:strongSelf shouldInteractWithStringAttributes:attributes
                                 inRange:range];
        }
    }];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (self.attributedText == nil) {
        return CGSizeMake(self.textContainerInsets.left + self.textContainerInsets.right, self.textContainerInsets.top + self.textContainerInsets.bottom);
    }
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    CGMutablePathRef paths = CGPathCreateMutable();
    
    CGPathAddRect(paths, NULL, CGRectMake(self.textContainerInsets.left, self.textContainerInsets.top, size.width - (self.textContainerInsets.left + self.textContainerInsets.right), size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, self.attributedText.length), paths, NULL);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    if (!lines)
        return CGSizeMake(self.textContainerInsets.left + self.textContainerInsets.right, self.textContainerInsets.top + self.textContainerInsets.bottom);
    
    CFIndex count = CFArrayGetCount(lines);
    
    CGPoint origins[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    // 翻转坐标系
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.0f, -1.0f);
    
    CGPoint linePoint = origins[count - 1];
    
    linePoint.x = linePoint.x + self.textContainerInsets.left;
    
    CTLineRef line = CFArrayGetValueAtIndex(lines, count - 1);
    // 获得每一行的rect信息
    CGRect flippedRect = [self getLineBounds:line point:linePoint];
    CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
    
    return CGSizeMake(self.frame.size.width, rect.origin.y + self.textContainerInsets.bottom);
}

@end
