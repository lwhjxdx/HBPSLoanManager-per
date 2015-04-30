//
//  HBUserViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"

@interface HBUserViewController : HBBaseViewController


@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)nameClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *subTempView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


- (IBAction)loginOutClick:(id)sender;

@end
