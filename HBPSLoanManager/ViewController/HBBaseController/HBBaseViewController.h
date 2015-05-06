//
//  HBBaseViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZipTool.h"

@interface HBBaseViewController : UIViewController<UINavigationControllerDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *mBaseNavigationBarView;
@property (nonatomic, strong) UIImageView *mBaseNavigationBarBg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *homeButton;

@property (nonatomic, strong) UITableView *baseTableView;


//设置tabbar显示与隐藏
- (void)setTabbarViewHide:(BOOL)isHide;
//push到下级界面的方法
- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated;

//初始化tableview
- (void)initBaseTableView;

//返回按钮的点击
- (void)backBtnEvents:(id)sender;

//显示alterView
- (void)showAlterView:(NSString *)titleString;

//---刷新视图
- (void)refreshView:(NSMutableDictionary *)dic;
@end
