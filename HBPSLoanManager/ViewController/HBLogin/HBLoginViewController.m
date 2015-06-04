//
//  HBLoginViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBLoginViewController.h"
#import "HBDefaultConfigerData.h"
#import "NSString+encrypt.h"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "NSString+Encrypt3DESandBase64.h"
#import "ER3DESEncrypt.h"

@interface HBLoginViewController ()<UITextFieldDelegate>
{
    CGPoint centPoint;
}
@end

@implementation HBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self littleAdjust];
    centPoint = self.contentView.center;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)littleAdjust{
    [HBUserModel clearUserInfo];
    self.mBaseNavigationBarView.hidden = YES;
//    [self.hbBGImageView setImage:[UIImage imageNamed:@"Default-568"]];
    [self.hbBGImageView setContentMode:(UIViewContentModeScaleToFill)];
    
    self.userNameTextField.backgroundColor = [UIColor whiteColor];
    self.userNameTextField.alpha = 0.7;
    self.userNameTextField.layer.cornerRadius = 5;
    self.userNameTextField.delegate = self;
    self.userNameTextField.layer.masksToBounds = YES;
    self.userNameTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.userNameTextField.layer.borderWidth = 1;
    
    UIImageView *userNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 40, 20)];
    userNameImageView.contentMode = UIViewContentModeScaleAspectFit;

    [userNameImageView setImage:[UIImage imageNamed:@"userName"]];
    [self.userNameTextField setLeftView:userNameImageView];
    [self.userNameTextField setLeftViewMode:(UITextFieldViewModeAlways)];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"kuserName"];
    if (userName) {
        self.userNameTextField.text = userName;
    }
    
    
    self.passwdTextField.backgroundColor = [UIColor whiteColor];
    self.passwdTextField.alpha = 0.7;
    self.passwdTextField.layer.cornerRadius = 5;
    self.passwdTextField.delegate = self;
    self.passwdTextField.layer.masksToBounds = YES;
    self.passwdTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.passwdTextField.layer.borderWidth = 1;
    [self.passwdTextField setSecureTextEntry:YES ];
    UIImageView *passwdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 40, 20)];
    passwdImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [passwdImageView setImage:[UIImage imageNamed:@"passWord"]];
    [self.passwdTextField setLeftView:passwdImageView];
    [self.passwdTextField setLeftViewMode:(UITextFieldViewModeAlways)];
    if (PAT_) {
        //密码
//        self.passwdTextField.text  = @"7B52009B64FD0A2A49E6D8A939753077792B0554";
        if ([kBaseURL isEqualToString:@"https://180.168.123.215:8089/p2pInterface/"]) {
            self.userNameTextField.text = @"manager1";
            self.passwdTextField.text  = @"q111111";
        }else{
            self.userNameTextField.text = @"ceshi1";
            self.passwdTextField.text  = @"1qaz!2WSX";
        }

    }
    
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
    
    self.resetButton.layer.cornerRadius = 5;
    self.resetButton.layer.masksToBounds = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBordHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBordShow:) name:UIKeyboardWillShowNotification object:nil];

}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];

}

- (IBAction)loginClick:(id)sender {
    [self.view endEditing:YES];
    NSMutableDictionary *dic = [self markParams];
    if (dic == nil) {
        return;
    }

    if (PAT_) {
        [HBRequest RequestDataJointStr:kLoginURL parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
            
            
            [self handleDataFromNet:receiveJSON];
            
        } failBlock:nil];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"medbri" forKey:@"userId"];
        
        [self handleDataFromNet:nil];

    }
}

- (void)handleDataFromNet:(NSDictionary *)resultJson{
    [self saveUserInfo];
    //保存用户信息
    [HBUserModel saveUserModel:resultJson];
    [self bulitTabbarController];
}



- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic;
    if ([self verify]) {
        NSString *userName = self.userNameTextField.text;
        userName = [userName stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *pw = self.passwdTextField.text;
        pw = [pw stringByReplacingOccurrencesOfString:@" " withString:@""];
        //手机唯一标识
        NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
        //密码
        pw = [[pw sha1] uppercaseString];
        dic = [NSMutableDictionary dictionary];
        [dic setObject:pw forKey:@"userPwd"];
        [dic setObject:userName forKey:@"userId"];
        [dic setObject:identifierForVendor forKey:@"identifier"];
    }
    return dic;
}

//验证数据有效性
- (Boolean)verify{
    
    NSString *userName = self.userNameTextField.text;
    userName = [userName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *pw = self.passwdTextField.text;
    pw = [pw stringByReplacingOccurrencesOfString:@" " withString:@""];

    
    if (userName.length > 0 && pw.length >0) {
        return YES;
    }else{
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"请将信息填写完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
        return NO;
    }
}


- (void)bulitTabbarController{

//    ViewController *tabbarController = [[ViewController alloc] init];
//    
//    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarController;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.userNameTextField) {
        [self.passwdTextField becomeFirstResponder];
    }else{
        [textField endEditing:YES];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)saveUserInfo{
    if (self.userNameTextField.text) {
        [[NSUserDefaults standardUserDefaults] setObject:self.userNameTextField.text forKey:@"kuserName"];
    }
}

//重置
- (IBAction)reset:(id)sender {
    self.userNameTextField.text = @"";
    self.passwdTextField.text = @"";
}

- (void)keyBordShow:(NSNotification *)notifitcation{
    
    //计算键盘弹出的高度
//    int y = [[notifitcation.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey ] CGRectValue].size.height;
//    //执行动画
//    CGPoint p = centPoint;
//    p.y -= y/2;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.contentView.center = CGPointMake(kSCREEN_WIDTH/2, p.y);
//    }];
}
- (IBAction)forgotPassword:(UIButton *)sender {
}





#pragma  mark 键盘消失

- (void)keyBordHide:(NSNotificationCenter *)notifitcation{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.center = self.view.center;
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
