//
//  UILabel+ContentEdgetInsets.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "UILabel+ContentEdgetInsets.h"
#import <CoreText/CoreText.h>
#import "Swizzling.h"
#import "NSString+YMRTPattern.h"

////CTRun的回调，销毁内存的回调
//void RunDelegateDeallocCallback( void* refCon ){
//    
//}

@implementation UILabel (ContentEdgetInsets)

#pragma mark --Property set & get Methods

- (void)setTextContentEdgeInsets:(UIEdgeInsets)textContentEdgeInsets
{
    objc_setAssociatedObject(self, "textContentEdgeInsets", NSStringFromUIEdgeInsets(textContentEdgeInsets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}

- (UIEdgeInsets)textContentEdgeInsets
{
    return UIEdgeInsetsFromString(objc_getAssociatedObject(self, "textContentEdgeInsets"));
}

@end
