//
//  Swizzling.m
//  UICategory
//
//  Created by fengxijun on 5/9/16.
//  Copyright © 2016 goappbox. All rights reserved.
//

#import "Swizzling.h"

void swizzleSelector(Class clazz, SEL orgSel, SEL swizzingSel)
{
    Method org_method = class_getInstanceMethod(clazz, orgSel);
    Method swizzing_method = class_getInstanceMethod(clazz, swizzingSel);
    if (class_addMethod(clazz, orgSel, method_getImplementation(swizzing_method), method_getTypeEncoding(org_method))) {
        class_replaceMethod(clazz, swizzingSel, method_getImplementation(org_method), method_getTypeEncoding(org_method));
    } else {
        method_exchangeImplementations(org_method, swizzing_method);
    }
}

void swizzleSelctorToNewIMP(Class clazz, SEL orgSel, IMP swizzingIMP)
{
    Method org_method = class_getInstanceMethod(clazz, orgSel);
//    IMP origIMP = method_getImplementation(org_method);
    
    if (class_addMethod(clazz, orgSel, swizzingIMP, method_getTypeEncoding(org_method))) {
        method_setImplementation(org_method, swizzingIMP);
    }
}
