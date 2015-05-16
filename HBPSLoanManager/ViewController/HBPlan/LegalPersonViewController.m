//
//  LegalPersonViewController.m
//  HBPSLoanManager
//
//  Created by QC on 15-4-23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "LegalPersonViewController.h"
#import "HBCheckCaledarViewController.h"
#import "HBCompanyPlanViewController.h"
@interface LegalPersonViewController ()

@end

@implementation LegalPersonViewController

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
    self.tableViewArr = @[@[@"小企业法人授信业务检查计划",@"HBCompanyPlanViewController"],
//  @[@"小企业法人授信业务抽查计划",@"HBPersonageViewController"],
//  @[@"小企业法人授信业务检查日历",@"HBCheckCaledarViewController"]
                          ];
    [self.tableView reloadData];
    self.titleLabel.text = @"小企业法人授信业务";
}
//小企业法人授信业务检查计划
- (IBAction)companyPlan:(id)sender {
    HBCompanyPlanViewController *companyPlan = [[HBCompanyPlanViewController alloc] init];
    [self   pushViewController:companyPlan animated:YES];
}
//检查日历
- (IBAction)checkCalendar:(id)sender {
    HBCheckCaledarViewController *vc = [[HBCheckCaledarViewController alloc] init];
    
    [self pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:YES];
}
@end
