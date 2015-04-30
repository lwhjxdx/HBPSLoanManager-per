//
//  HBPlanViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//  计划页面

#import "HBPlanViewController.h"

#import "HBCompanyPlanViewController.h"
#import "HBCheckCaledarViewController.h"


#import "LegalPersonViewController.h"
#import "HBPersonageViewController.h"
#import "HBPersonageCarController.h"
@interface HBPlanViewController ()
{

}
@end

@implementation HBPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"检查计划";

}

//企业用户检查计划－》小企业法人授信业务
- (IBAction)companyPlan:(id)sender {
    
//    HBCompanyPlanViewController *vc = [[HBCompanyPlanViewController alloc] init];
    LegalPersonViewController *vc = [[LegalPersonViewController alloc] init];
    [self   pushViewController:vc animated:YES];
    
}

//个人检查计划－》个人商务贷款
- (IBAction)persoonPlan:(id)sender {
    HBPersonageViewController *personageVC = [[HBPersonageViewController alloc] init];
    [self   pushViewController:personageVC animated:YES];
}

////检查日历
//- (IBAction)checkCalendar:(id)sender {
//    HBCheckCaledarViewController *vc = [[HBCheckCaledarViewController alloc] init];
//    [self pushViewController:vc animated:YES];
//}

//抽检计划－》个人经营性车辆按揭贷款
- (IBAction)randomPlan:(id)sender {
    HBPersonageCarController *personageCarVC = [[HBPersonageCarController alloc] init];
    [self   pushViewController:personageCarVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setTabbarViewHide:@"NO"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
