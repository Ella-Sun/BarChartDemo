//
//  SwizzleMethod+NSObject.h
//  图像安全
//
//  Created by huangkexuan on 16/5/31.
//  Copyright © 2016年 Cloud Funds Management. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwizzleMethod : NSObject

+ (void)swizzleMethods:(Class)fromClass ToClass:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel;

@end
