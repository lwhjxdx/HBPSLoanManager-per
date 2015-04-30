//
//  BaseSlideTabBarViewController.h
//  BaseSlideTabBarViewController
//
//  Created by YM on 14-12-10.
//  Copyright (c) 2014年 YM. All rights reserved.
//


/**
 
 用法
 RootViewController *root = [[RootViewController alloc] initWithControllers:vcArray UseGesture:YES];//UseGesture:YES 开启手势
 root.offSetGesture = 100;//设置手势滑动需要切换时的手势偏移量
 root.cutAnimation = NO;//开启 手势滑动 切换动画
 
 */



#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define kWidth ([UIScreen mainScreen].bounds.size.width)

@interface BaseSlideTabBarViewController  : UITabBarController<UIGestureRecognizerDelegate,UITabBarControllerDelegate,UITabBarDelegate>
@property (nonatomic,strong) NSArray *controllers;
//是否开启手势滑动
@property (nonatomic,assign) BOOL useGesture;
//是否开启页面切换动画
@property (nonatomic,assign) BOOL cutAnimation;
//手势偏移量 默认1/3屏幕宽度
@property (nonatomic,assign) NSInteger offSetGesture;

- (id)initWithControllers:(NSArray *)vcArray   UseGesture:(BOOL)use;


@end
