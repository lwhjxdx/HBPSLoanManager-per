//
//  HBCheckViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckViewController.h"
#import "LoanLegalPerson/LoanLegalViewController.h"
#import "LoanPersonage/LoanPersonageController.h"
#import "LoanPersonageCar/LoanPersonageCarController.h"
#import "HBSignInController.h"
@interface HBCheckViewController ()

@end

@implementation HBCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"贷后检查报告";
}
- (IBAction)LegalPersonInfoSearch:(id)sender {
    [self pushQiandaoVC:NSClassFromString(@"LoanLegalViewController")];
//    LoanLegalViewController *loanLegaVC = [[LoanLegalViewController alloc] init];
//    [self pushViewController:loanLegaVC animated:YES];
}
- (IBAction)PersonageSearch:(id)sender {
    [self pushQiandaoVC:NSClassFromString(@"LoanPersonageController")];

    LoanPersonageController *loanPersonageVC = [[LoanPersonageController alloc] init];
//    [self pushViewController:loanPersonageVC animated:YES];
}
- (IBAction)PersonageCarSearch:(id)sender {
    [self pushQiandaoVC:NSClassFromString(@"LoanPersonageCarController")];
//
//    LoanPersonageCarController *loanPersonageCarVC = [[LoanPersonageCarController alloc] init];
//    [self pushViewController:loanPersonageCarVC animated:YES];
}
/**
 *  推向签到页面
 *
 *  @param class 签到下一个页面的class，不支持该界面向下一个界面传值，如需传值请想办法
 */
-(void)pushQiandaoVC:(Class)class
{
    HBSignInController *qiandaoVC = [[HBSignInController alloc]init];
    qiandaoVC.isShowNextItem = YES;
    qiandaoVC.classString = class;
    [self.navigationController pushViewController:qiandaoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//dueNum //借据编号
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:@"NO"];
}

@end
