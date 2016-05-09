//
//  Swizzling.h
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

extern void swizzleSelector(Class clazz, SEL orgSel, SEL swizzingSel);
