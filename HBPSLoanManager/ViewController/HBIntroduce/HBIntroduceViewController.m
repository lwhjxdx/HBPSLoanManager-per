//
//  HBIntroduceViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBIntroduceViewController.h"

@interface HBIntroduceViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation HBIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"业务介绍";
//    self.myWebView.backgroundColor = [UIColor whiteColor];
    NSLog(@"kSCREEN_WIDTH===%f",kSCREEN_WIDTH);
    self.myWebView.frame = CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT - 64 -44);
    NSURL *url = [NSURL URLWithString:@"http://180.168.123.215:8090/p2pInterface/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
