//
//  HBPersonageViewController.m
//  HBPSLoanManager
//
//  Created by QC on 15-4-23.
//  Copyright (c) 2015年 YM. All rights reserved.
//
/**
 <#Description#>
 */
#import "HBPersonageViewController.h"
#import "HBCheckCaledarViewController.h"
#import "HBPersonPlanViewController.h"
@interface HBPersonageViewController ()

@end

@implementation HBPersonageViewController

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
    self.titleLabel.text = @"个人商务贷款";
}
- (IBAction)companyPlan:(id)sender {
    HBPersonPlanViewController *personPlan = [[HBPersonPlanViewController alloc] init];
    [self   pushViewController:personPlan animated:YES];
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
    [self setTabbarViewHide:@"YES"];
}
@end
