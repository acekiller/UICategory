//
//  YMOtherAttachement.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "YMOtherAttachement.h"

@implementation YMOtherAttachement

- (instancetype) initWithFilePath:(NSString *)filepath
{
    self = [super initWithData:[NSData dataWithContentsOfFile:filepath] ofType:nil];
    if (self) {
        self.image = [UIImage imageNamed:@"service_head"];
    }
    return self;
}

@end
