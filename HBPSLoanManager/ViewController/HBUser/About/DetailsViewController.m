//
//  DetailsViewController.m
//  Home
//
//  Created by apple on 15/4/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIColor+ChangeWithString.h"
@interface DetailsViewController ()
{

    UITextView* textview;

}
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorFromHexString:@"#eaeaea"];
    self.titleLabel.text =@"版本说明";
    self.backButton.hidden = NO;
    
    NSString *string=@"当前版本如下";
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, kValueTopBarHeight + 29, kSCREEN_WIDTH, 15)];
    lable.text=string;
    
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont boldSystemFontOfSize:15.f];
    [self.view addSubview:lable];
    textview=[[UITextView alloc]init];
    textview.editable = NO;
    textview.layer.borderWidth=0.5f;
    textview.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f].CGColor;
    textview.layer.masksToBounds = YES;
    textview.font =[UIFont systemFontOfSize:14];
    textview.text = _versionInfoString;
    textview.frame = CGRectMake(10, lable.frame.origin.y + 20, kSCREEN_WIDTH - 20, kSCREEN_HEIGHT - lable.frame.origin.y - 50);
    [self.view addSubview:textview];
    [self gettinginfomation];
}
-(void)gettinginfomation
{
    
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
