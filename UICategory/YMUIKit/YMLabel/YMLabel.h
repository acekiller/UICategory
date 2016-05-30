//
//  YMRichTextLabel.h
//  TestDemo
//
//  Created by fengxijun on 5/16/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMLabelTextPatternProtocol.h"

@class YMLabel;

@protocol YMLabelDelegate <NSObject>

- (void) ymLabel:(YMLabel *)label shouldInteractWithStringAttributes:(NSDictionary *)attributes inRange:(NSRange)characterRange;

- (void) ymLabel:(YMLabel *)label shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange attributes:(NSDictionary *)attributes;

@end

@interface YMLabel : UIView

@property (nonatomic, assign) id <YMLabelDelegate> delegate;

@property (nonatomic, assign) UIEdgeInsets          textContainerInsets;

@property (nonatomic, assign) CGFloat               lineFragmentPadding;

@property (nonatomic, assign) NSLineBreakMode       lineBreakMode;

@property (nonatomic, strong) UIColor               *textColor;

@property (nonatomic, strong) UIFont                *font;

@property (nonatomic, strong) NSString              *text;

@property (nonatomic, strong) NSAttributedString    *attributedText;

@property (nonatomic, assign) CGFloat               cornerRadius;

@property(nonatomic, strong) UIColor                *shadowColor;     // default is nil (no shadow)
@property(nonatomic, assign) CGSize                 shadowOffset;    // default is CGSizeMake(0, -1) -- a top shadow
@property(nonatomic, assign) NSTextAlignment        textAlignment;   // default is NSTextAlignmentLeft

@property(nonatomic, assign) NSInteger              numberOfLines;

@property (nonatomic, assign) NSInteger             maxNumberOflines;

- (void)addPattern:(id<YMLabelTextPatternProtocol>)pattern;

@end
