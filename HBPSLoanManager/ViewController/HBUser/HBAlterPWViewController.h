//
//  HBAlterPWViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"

//修改密码页面
@interface HBAlterPWViewController : HBBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPWTextField;


@property (weak, nonatomic) IBOutlet UITextField *userNewPWTextField;

@property (weak, nonatomic) IBOutlet UITextField *userNewSurePWTextField;



@property (weak, nonatomic) IBOutlet UIButton *resetClicked;

- (IBAction)showPWClicked:(id)sender;




@end
