//
//  HBPersonageCarController.m
//  HBPSLoanManager
//
//  Created by QC on 15-4-23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPersonageCarController.h"
#import "HBCheckCaledarViewController.h"
#import "HBPersonageCarPlanController.h"
@interface HBPersonageCarController ()

@end

@implementation HBPersonageCarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"个人经营性车辆按揭贷款";
    self.tableViewArr = @[@[@"个人经营性车辆按揭贷款检查计划",@"HBPersonageCarPlanController"],
//  @[@"个人经营性车辆按揭贷款抽查计划",@"HBPersonageCarPlanController"],
  @[@"个人经营性车辆按揭贷款检查日历",@"HBCheckCaledarViewController"]];
    [self.tableView reloadData];
}
- (IBAction)companyPlan:(id)sender {
    HBPersonageCarPlanController *personageCarPlan = [[HBPersonageCarPlanController alloc] init];
    [self   pushViewController:personageCarPlan animated:YES];
}
//日历
- (IBAction)checkCalendar:(id)sender {
    HBCheckCaledarViewController *vc = [[HBCheckCaledarViewController alloc] init];
    
    [self pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:YES];
}
@end
