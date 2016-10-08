//
//  BarChartViewController.h
//  ChartsDemo
//
//  Created by Daniel Cohen Gindi on 17/3/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

/**
 导入Charts 框架步骤：
 1， 将Charts文件夹复制到新项目目录下，将Charts。xcodeproj脱到新项目中
 2， 将新项目中 BuildSettings 中把 defines module 设为 YES 把 product module 设置为项目工程的名字。
 3， 新建一个.swift文件 并确定桥接
 4， 在项目的 general -> Embedded binaries中添加Charts.frameWorks包
 5， 在需要用到的 .m文件中导入 imoprt"项目名-Swift。h"
 6,  imoprt“项目名-Swift。h” 点进去后再适当的位置添加 @import Charts
 */

#import <UIKit/UIKit.h>
#import "DemoBaseViewController.h"
#import <Charts/Charts.h>

@interface BarChartViewController : DemoBaseViewController

@end
