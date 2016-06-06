//
//  SwizzleMethod+NSObject.m
//  图像安全
//
//  Created by huangkexuan on 16/5/31.
//  Copyright © 2016年 Cloud Funds Management. All rights reserved.
//

#import "SwizzleMethod+NSObject.h"
#import <objc/runtime.h>

@implementation SwizzleMethod

+ (void)swizzleMethods:(Class)fromClass ToClass:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //case1: 替换实例方法
        Class selfClass = fromClass;
        //case2: 替换类方法
        Class toClass = class;
        
        //源方法的SEL和Method
        //        SEL oriSEL = @selector(viewWillAppear:);
        Method oriMethod = class_getInstanceMethod(selfClass, origSel);
        
        //交换方法的SEL和Method
        //        SEL cusSEL = @selector(customViewWillApper:);
        Method cusMethod = class_getInstanceMethod(toClass, swizSel);
        
        //        //先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
        BOOL addSucc = class_addMethod(selfClass, origSel, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            //添加成功：将源方法的实现替换到交换方法的实现
            //            class_replaceMethod(selfClass, swizSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即可
            method_exchangeImplementations(oriMethod, cusMethod);
        }

    });
}

@end
