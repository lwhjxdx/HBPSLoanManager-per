//
//  HBAlterPWViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBAlterPWViewController.h"
#import "NSString+encrypt.h"
@interface HBAlterPWViewController ()<UITextFieldDelegate>
{
    Boolean isShowSecret;
}
@end

@implementation HBAlterPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    isShowSecret = YES;
    self.titleLabel.text = @"密码修改";
    [self littleAdjust];
}

- (void)littleAdjust{
    
    self.mBaseNavigationBarView.hidden = NO;
    [self addLeftImageViewToTextFeild:self.oldPWTextField];
    [self addLeftImageViewToTextFeild:self.userNewPWTextField];
    [self addLeftImageViewToTextFeild:self.userNewSurePWTextField];
    self.resetClicked.layer.cornerRadius = 5;
    self.resetClicked.layer.masksToBounds = YES;
}

//添加左图片 到 textField
- (void)addLeftImageViewToTextFeild:(UITextField *)textField{

    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.delegate = self;
    UIImageView *userNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 60, 20)];
    userNameImageView.contentMode = UIViewContentModeScaleAspectFit;
    [userNameImageView setImage:[UIImage imageNamed:@"wdzl-icon5"]];
    [textField setLeftView:userNameImageView];
    [textField setLeftViewMode:(UITextFieldViewModeAlways)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.oldPWTextField) {
        [self.userNewPWTextField becomeFirstResponder];
    }else if(textField == self.userNewPWTextField) {
        [self.userNewSurePWTextField becomeFirstResponder];
    }else if(textField == self.userNewSurePWTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



//验证数据有效性
- (Boolean)verify{
    if (self.userNewSurePWTextField.text.length > 0 && self.userNewPWTextField.text.length >0&& self.oldPWTextField.text.length >0) {
        if ([self.userNewSurePWTextField.text isEqualToString:self.userNewPWTextField.text] ) {
            if ([self.oldPWTextField.text isEqualToString:self.userNewPWTextField.text]) {
                UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"新密码和旧密码一样" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [al show];
            }else{
                return YES;
            }
        }else{
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"两次输入密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
        }
    }else{
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"请将信息填写完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }
    return NO;
}



- (IBAction)showPWClicked:(id)sender {
    isShowSecret = !isShowSecret;
    UIButton *btn = (UIButton *)sender;
    if (isShowSecret) {
        [btn setImage:[UIImage imageNamed:@"checked"] forState:(UIControlStateNormal)];

        [self.oldPWTextField  setSecureTextEntry:NO];
        [self.userNewPWTextField  setSecureTextEntry:NO];
        [self.userNewSurePWTextField  setSecureTextEntry:NO];
    }else{
        [btn setImage:[UIImage imageNamed:@"unChecked"] forState:(UIControlStateNormal)];

        [self.oldPWTextField  setSecureTextEntry:YES];
        [self.userNewPWTextField  setSecureTextEntry:YES];
        [self.userNewSurePWTextField  setSecureTextEntry:YES];
    }
}

- (IBAction)alterPWClicked:(id)sender {
    [self requestFromNetWorking];
}

//从网络请求数据 修改密码
- (void)requestFromNetWorking{
    NSMutableDictionary *dic = [self markParams];
    if (!dic) {
        return;
    }
    [HBRequest RequestDataJointStr:kModifyPwdURL parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self handleData:receiveJSON];
    } failBlock:^(NSError *error) {
        
    }];
    
}
//配置密码修改参数
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic;
    if ([self verify]) {
        dic = [NSMutableDictionary dictionary];
        [dic setObject:[[self.oldPWTextField.text sha1] uppercaseString] forKey:@"oldPwd"];
        [dic setObject:[[self.userNewPWTextField.text sha1] uppercaseString]forKey:@"newPwd"];
    }
    return dic;
}

//处理数据 修改密码成功
- (void)handleData:(NSDictionary *)jsonDic{
    
    if (jsonDic) {
        [self showAlterView:jsonDic[@"respMsg"]];
        [self.navigationController popToRootViewControllerAnimated:YES];    }
    
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setTabbarViewHide:@"YES"];
}
@end
