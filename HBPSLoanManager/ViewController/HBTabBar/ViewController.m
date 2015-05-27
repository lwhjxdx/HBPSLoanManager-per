//
//  ViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "ViewController.h"
#import "HBDefaultConfigerData.h"

@interface ViewController ()
//{
//    NSMutableArray *viewArrays;
//    NSArray *_imageArray;
//    NSArray *_titleArray;
//    NSArray *_controllerArray;
//    Boolean isFirstAppear;
//}
//@property(strong, nonatomic) UIView *selectIndex;
@end

@implementation ViewController
-(instancetype)init
{
    if (self=[super init]) {
        self.viewControllers = [HBDefaultConfigerData getTabbarControl];
        NSArray *imageArr = [HBDefaultConfigerData getTabbarImageDefult];
        for (UINavigationController *navController in self.viewControllers) {
//            navController.tabBarItem.image = imageArr[[self.viewControllers indexOfObject:navController]][@"Default"];
            navController.tabBarItem.image = imageArr[[self.viewControllers indexOfObject:navController]][@"Seleted"];
//            [navController.tabBarItem settitl]
        }
        self.tabBar.tintColor = [UIColor colorWithRed:0.086 green:0.337 blue:0.192 alpha:1.000];
        UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.tabBar insertSubview:bgView atIndex:0];
        self.tabBar.opaque = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-kTabbarHight, kSCREEN_WIDTH, kTabbarHight)];
//    self.tabbarView.backgroundColor = kColorWithRGB(247,247,247);
//    self.view.backgroundColor = [UIColor clearColor];
//    [self.view addSubview: self.tabbarView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTabbarHide:) name:kNSNotificationTabbarHide object:nil];
}

//- (void)setImageView:(NSArray *)imageArray titleArray:(NSArray *)titleArray viewControllers:(NSArray *)viewControllerArray{
//    _imageArray = imageArray;
//    _titleArray = titleArray;
//    _controllerArray = viewControllerArray;
//}
//
////- (void)viewWillAppear:(BOOL)animated{
////    [super viewWillAppear:animated];
////    if (isFirstAppear) {
////        [self setViewControllers:_controllerArray];
////        [self initTabbarWithImage:_imageArray titleArray:_titleArray];
////        isFirstAppear = NO;
////    }
////}
//
//- (void)initTabbarWithImage:(NSArray *)imageArray titleArray:(NSArray *)titleArray
//{
//    viewArrays = [[NSMutableArray alloc] init];
//    UIView *view;
//    UIImageView *imageView ;
//    UILabel *lab;
//    CGFloat width = kSCREEN_WIDTH/[imageArray count];
//    CGFloat high = kTabbarHight;
//    for (int i = 0; i< [imageArray count]; i++) {
//        view = [[UIView alloc] initWithFrame:CGRectMake(i*width, 0, width, high)];
//        imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, width, high-25)];
//        imageView.image =  [[imageArray objectAtIndex:i] objectForKey:@"Default"];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//        [view addSubview:imageView];
//        
//        lab = [[UILabel alloc] initWithFrame:CGRectMake(0,  high-15, width, 12)];
//        lab.text = [titleArray objectAtIndex:i];
//        [lab setFont:[UIFont systemFontOfSize:13]];
//        [lab setTextColor:RGBACOLOR(127, 127, 127, 1)];
//        lab.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:lab];
//        
//        view.tag = i;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndexClicked:)];
//        [view addGestureRecognizer:tap];
//        [viewArrays addObject:view];
//        [self.tabbarView addSubview:view];
//        
//        if (i == 0) {
//            self.selectIndex = view;
//             imageView.image =  [[imageArray objectAtIndex:i] objectForKey:@"Seleted"];
//            [lab setTextColor:[UIColor colorWithRed:0.086 green:0.337 blue:0.192 alpha:1.000]];
//        }
//    }
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 0.5)];
//    [lineView setBackgroundColor:RGBACOLOR(197, 197, 197, 1)];
//    [self.tabbarView addSubview:lineView];
//}
//
////模拟tabbar选中效果
//- (void)selectIndexClicked:(UIGestureRecognizer *)tap{
//    UIView *view = tap.view;
//    if (_selectIndex == view) {
//        return;
//    }
//    for (UIView *tempImageView in [_selectIndex subviews]) {
//        if ([tempImageView isKindOfClass:[UIImageView class]]) {
//            ((UIImageView *)tempImageView).image = [_imageArray[_selectIndex.tag] objectForKey:@"Default"];
//        }
//        if ([tempImageView isKindOfClass:[UILabel class]]) {
//            UILabel *lable = (UILabel*)tempImageView;
//            [lable setTextColor:RGBACOLOR(127, 127, 127, 1)];
//        }
//    }
//
//    self.selectIndex = view;
//    for (UIView *tempImageView in [_selectIndex subviews]) {
//        if ([tempImageView isKindOfClass:[UIImageView class]]) {
//            ((UIImageView *)tempImageView).image = [_imageArray[_selectIndex.tag] objectForKey:@"Seleted"];
//        }
//        if ([tempImageView isKindOfClass:[UILabel class]]) {
//            UILabel *lable = (UILabel*)tempImageView;
//            [lable setTextColor:[UIColor colorWithRed:0.086 green:0.337 blue:0.192 alpha:1.000]];
//        }
//    }
//    [UIView animateWithDuration:0.1 animations:^{
//        _selectIndex.layer.transform = CATransform3DMakeRotation(0.2, 0, 0, 1);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 animations:^{
//            _selectIndex.layer.transform = CATransform3DMakeRotation(-0, 0, 0, 1);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.1 animations:^{
//                _selectIndex.layer.transform = CATransform3DMakeRotation(-0.2, 0, 0, 1);
//            } completion:^(BOOL finished) {
//                _selectIndex.layer.transform = CATransform3DMakeRotation(-0, 0, 0, 1);
//            }];
//        }];
//    }];
//
////    for (int i = 0; i < viewArrays.count; i ++){
////        UIView *indexView = viewArrays[i];
////        if ([view isEqual:indexView]) {
////            [UIView animateWithDuration:0.1 animations:^{
////                indexView.layer.transform = CATransform3DMakeRotation(0.2, 0, 0, 1);
////            } completion:^(BOOL finished) {
////                [UIView animateWithDuration:0.1 animations:^{
////                    indexView.layer.transform = CATransform3DMakeRotation(-0, 0, 0, 1);
////                } completion:^(BOOL finished) {
////                    [UIView animateWithDuration:0.1 animations:^{
////                        indexView.layer.transform = CATransform3DMakeRotation(-0.2, 0, 0, 1);
////                    } completion:^(BOOL finished) {
////                        indexView.layer.transform = CATransform3DMakeRotation(-0, 0, 0, 1);
////                    }];
////                }];
////            }];
////            
////            for (UIView *tempImageView in [indexView subviews]) {
////                if ([tempImageView isKindOfClass:[UIImageView class]]) {
////                    ((UIImageView *)tempImageView).image = [_imageArray[i] objectForKey:@"Seleted"];
////                }
////                if ([tempImageView isKindOfClass:[UILabel class]]) {
////                    UILabel *lable = (UILabel*)tempImageView;
////                    [lable setTextColor:[UIColor colorWithRed:0.086 green:0.337 blue:0.192 alpha:1.000]];
////                }
////            }
////        }else{
////            for (UIView *tempImageView in [indexView subviews]) {
////                if ([tempImageView isKindOfClass:[UIImageView class]]) {
////                    ((UIImageView *)tempImageView).image = [_imageArray[i] objectForKey:@"Default"];
////                }
////                if ([tempImageView isKindOfClass:[UILabel class]]) {
////                    UILabel *lable = (UILabel*)tempImageView;
////                    [lable setTextColor:RGBACOLOR(127, 127, 127, 1)];
////                }
////            }
////        }
////    }
//    [self setSelectedIndex:view.tag];
//}
//
//
////通过通知 隐藏 显示 底部Tabbar
//- (void)setTabbarHide:(NSNotification *)notification {
//    NSDictionary * userInfo = [notification userInfo];
//    
//    if ([[userInfo valueForKey:@"isHide"] boolValue]) {
//            self.tabbarView.hidden = YES;
//    }else{
//        self.tabbarView.hidden = NO;
//            self.tabbarView.alpha = 1;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
