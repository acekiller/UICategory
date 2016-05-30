//
//  YMLabelParamsConfig.m
//  UICategory
//
//  Created by fengxijun on 5/17/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMLabelParamsConfig.h"
#import <CoreText/CoreText.h>
#import "NSTextAttachment+YMLabelSize.h"

void RunDelegateDeallocCallback(void * refCon)
{
}

CGFloat RunDelegateGetAscentCallback(void * refCon)
{
    NSTextAttachment *attachement = (__bridge NSTextAttachment *)refCon;
    return attachement.size.height;
}
CGFloat RunDelegateGetDescentCallback(void * refCon)
{
    //    NSTextAttachment *attachement = (__bridge NSTextAttachment *)refCon;
    return 0;
}
CGFloat RunDelegateGetWidthCallback(void * refCon)
{
    NSTextAttachment *attachement = (__bridge NSTextAttachment *)refCon;
    return attachement.size.width;
}

@implementation YMLabelParamsConfig

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.textColor = [UIColor blackColor];
        self.linkTextColor = [UIColor blueColor];
        self.font = [UIFont systemFontOfSize:15.f];
        self.paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    }
    return self;
}

- (NSMutableDictionary *)attributedStringAttributes
{
    NSMutableDictionary *attributes = [@{NSForegroundColorAttributeName : self.textColor,
                                         NSFontAttributeName : self.font,
                                         NSParagraphStyleAttributeName : self.paragraphStyle
                                         } mutableCopy];
    
    return attributes;
}

- (NSMutableDictionary *)attachementRenderAttributes:(NSTextAttachment *)attachement
{
    NSMutableDictionary *mutDict = [self attributedStringAttributes];
    [mutDict removeObjectForKey:NSFontAttributeName];
    [mutDict setObject:attachement forKey:NSStringFromClass(NSTextAttachment.class)];
    
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = RunDelegateDeallocCallback;
    imageCallbacks.getWidth = RunDelegateGetWidthCallback;
    imageCallbacks.getAscent = RunDelegateGetAscentCallback;
    imageCallbacks.getDescent = RunDelegateGetDescentCallback;
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)attachement);
    
    [mutDict setObject:(__bridge id)runDelegate forKey:(NSString *)kCTRunDelegateAttributeName];
    
    CFRelease(runDelegate);
    
    return mutDict;
}

- (NSMutableDictionary *)linkAttributes
{
    NSMutableDictionary *attributes = [@{NSForegroundColorAttributeName : self.linkTextColor,
                                         NSFontAttributeName : self.font,
                                         NSParagraphStyleAttributeName : self.paragraphStyle,
                                         NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                         } mutableCopy];
    
    return attributes;
}

@end
