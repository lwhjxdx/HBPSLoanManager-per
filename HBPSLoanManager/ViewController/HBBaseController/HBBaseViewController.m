//
//  HBBaseViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"
@interface HBBaseViewController ()
{
    UIAlertView *al;
}
@end

@implementation HBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigationBarView];
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);

}


//加载 导航条（系统导航条隐藏）
-(void)loadNavigationBarView{
    if (DSystemVersion>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//来解决UINavigationBar透明的问题
    }
    self.navigationController.navigationBarHidden = YES;
    self.mBaseNavigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH,kTopBarHeight)];
    self.mBaseNavigationBarView.backgroundColor = [UIColor clearColor];
    self.mBaseNavigationBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;//UIViewAutoresizingFlexibleWidth:自动调整view的宽度，保证左边距和右边距不变
    self.mBaseNavigationBarView.autoresizesSubviews = YES;
    [self.view addSubview:self.mBaseNavigationBarView];
    
    
    UIImageView *mBaseNavigationBar = [[UIImageView alloc]initWithFrame:self.mBaseNavigationBarView.bounds];
    mBaseNavigationBar.backgroundColor = kColorWithRGB(247, 247, 247);
    
    [mBaseNavigationBar setImage:nil];
    
    [self.mBaseNavigationBarView addSubview:mBaseNavigationBar];
    CGRect rect = mBaseNavigationBar.bounds;
    rect.size.height -=20;
    rect.origin.y +=10;


    //Title头信息
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-240)/2,FromStatusBarHeight+5, 240, 35)];
    label.font=[UIFont systemFontOfSize:20];
    label.numberOfLines = 1;
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment=NSTextAlignmentCenter;
    label.text = @"";
    self.titleLabel = label;
    [self.mBaseNavigationBarView addSubview:self.titleLabel];
    
    //返回按钮
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10,FromStatusBarHeight+5,60,30);
    button.showsTouchWhenHighlighted = YES;
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 30)];
    [button addTarget:self action:@selector(backBtnEvents:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton = button;
    button.hidden =YES;
    [self.mBaseNavigationBarView addSubview:self.backButton];
    
    UIButton* homebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    homebutton.showsTouchWhenHighlighted = YES;//showsTouchWhenHighlighted 按钮按下会发光
    homebutton.frame = CGRectMake(kSCREEN_WIDTH-44,FromStatusBarHeight, 44, 44);
    [homebutton addTarget:self action:@selector(homeBtnEvents:) forControlEvents:UIControlEventTouchUpInside];
    [homebutton setImage:[UIImage imageNamed:@"icon_preson"] forState:UIControlStateNormal];
    homebutton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.homeButton=homebutton;
    self.homeButton.hidden =YES;
    [self.mBaseNavigationBarView addSubview:self.homeButton];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight-1, kSCREEN_WIDTH, 1)];
    [lineView setBackgroundColor:RGBACOLOR(197, 197, 197, 1)];
    [self.mBaseNavigationBarView addSubview:lineView];
}


-(void)backBtnEvents:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)homeBtnEvents:(id)sender{
}


- (void)setTabbarViewHide:(NSString *)isHide{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationTabbarHide     object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:isHide,@"isHide", nil]];
}



- (void)initBaseTableView
{
    _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kTopBarHeight ,kSCREEN_WIDTH ,kSCREEN_HEIGHT - kTopBarHeight) style:UITableViewStyleGrouped];
    _baseTableView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    _baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _baseTableView.showsVerticalScrollIndicator = NO;
    _baseTableView.tableHeaderView = [[UIView alloc] init];
    _baseTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_baseTableView];
    
    if (DSystemVersion >= 7.0)
        //分割线的位置不带偏移
        _baseTableView.separatorInset = UIEdgeInsetsZero;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.view bringSubviewToFront:self.mBaseNavigationBarView];

}


//push 到下级界面   使用此方法
- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated{
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:animated];
}

//保证当前页面只有一个弹框
- (void)showAlterView:(NSString *)titleString{
    if (al.visible == NO) {
     al = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:titleString  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [al show];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshView:(NSMutableDictionary *)dic{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end