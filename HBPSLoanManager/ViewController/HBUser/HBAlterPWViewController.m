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
@property (weak, nonatomic) IBOutlet UIView *textSuperView;

@end

@implementation HBAlterPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"密码修改";
    [self littleAdjust];
    [self.homeButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.homeButton.frame = CGRectMake(kSCREEN_WIDTH-60,FromStatusBarHeight, 60, 44);
    self.homeButton.hidden = NO;
    [self.homeButton setImage:nil forState:UIControlStateNormal];
//    [self.homeButton addTarget:self action:@selector(alterPWClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mBaseNavigationBarView addSubview:self.homeButton];
    
}
-(void)homeBtnEvents:(id)sender
{
    [self alterPWClicked:sender];
}
- (void)littleAdjust{
    
    self.mBaseNavigationBarView.hidden = NO;
    _textSuperView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.6f].CGColor;
    _textSuperView.layer.borderWidth = 0.5f;
    _textSuperView.layer.masksToBounds = YES;
    _userNewSurePWTextField.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.6f].CGColor;
    _userNewSurePWTextField.layer.borderWidth = 0.5f;
    
    [self addLeftImageViewToTextFeild:self.oldPWTextField withLeftString:@"原 密 码"];
    [self addLeftImageViewToTextFeild:self.userNewSurePWTextField withLeftString:@"新 密 码"];
    [self addLeftImageViewToTextFeild:self.userNewPWTextField withLeftString:@"确认密码"];
    self.resetClicked.layer.cornerRadius = 5;
    self.resetClicked.layer.masksToBounds = YES;
}

//添加左图片 到 textField
- (void)addLeftImageViewToTextFeild:(UITextField *)textField withLeftString:(NSString*)leftString{

//    textField.backgroundColor = [UIColor whiteColor];
////    textField.layer.cornerRadius = [leftString isEqualToString:@"新密码"]?0:5;
//    textField.layer.masksToBounds = YES;
//    textField.layer.borderColor = [UIColor grayColor].CGColor;
//    textField.layer.borderWidth = 1;
    textField.delegate = self;
    UILabel *userNameImageView = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
    userNameImageView.textAlignment = NSTextAlignmentCenter;
    userNameImageView.contentMode = UIViewContentModeScaleAspectFit;
    userNameImageView.text = leftString;
//    [userNameImageView setImage:[UIImage imageNamed:@"wdzl-icon5"]];
    [textField setLeftView:userNameImageView];
    [textField setLeftViewMode:(UITextFieldViewModeAlways)];
    [textField setClearButtonMode:UITextFieldViewModeAlways];
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

//判断输入字符是否是符合规则的密码
- (BOOL) validatePassword:(NSString *)passWord
{
    //    NSString *passWordRegex = @"^[a-zA-Z0-9]{1,8}+$";
    //    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    //    return [passWordPredicate evaluateWithObject:passWord];
    /**
     *  添加判断用户密码
     */
    BOOL isRigth;
    NSString *allPwdRegex = @"^(?![a-zA-z]+$)(?!\\d+$)(?![!@#$%^&*]+$)[a-zA-Z\\d!!@#$%^&*.]{6,18}$";
    NSPredicate *emailRegexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",allPwdRegex];
    isRigth = [emailRegexPredicate evaluateWithObject:passWord];
//    NSString *passWordRegex = @"^[a-zA-Z]{6,18}+$";
//    NSString *passWordRegex1 = @"^[0-9]{6,18}+$";
//    
//    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
//    NSPredicate *passWordPredicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex1];
//    BOOL first = ![passWordPredicate1 evaluateWithObject:passWord];
//    BOOL secend = ![passWordPredicate evaluateWithObject:passWord];
    return isRigth;
}

//验证数据有效性
- (Boolean)verify{

    if (![self validatePassword:self.userNewPWTextField.text]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"新密码长度不低于6位 不得大于18位,不能为纯数字 纯字母,不能是中文字符等非常用字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
        return NO;
    }
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
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.oldPWTextField  setSecureTextEntry:NO];
        [self.userNewPWTextField  setSecureTextEntry:NO];
        [self.userNewSurePWTextField  setSecureTextEntry:NO];
    }else{
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
        [dic setObject:[HBUserModel getUserName] forKey:@"userId"];
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
    [self setTabbarViewHide:YES];
}
@end
