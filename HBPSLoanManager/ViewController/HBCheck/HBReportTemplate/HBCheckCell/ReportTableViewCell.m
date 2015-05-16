//
//  ReportTableViewCell.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/18.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "ReportTableViewCell.h"
#import "MyCustomPickerView.h"
#import "SVProgressHUD.h"


@implementation ReportTableViewCell

- (void)awakeFromNib {
    self.infoTextfield.delegate  = self;
    self.baseView.layer.cornerRadius = 5;
    self.baseView.layer.masksToBounds = YES;
    self.baseView.layer.borderColor = [UIColor grayColor].CGColor;
    self.baseView.layer.borderWidth = 1;
}

//当样式为 点击出现pickerView时  点击事件
- (IBAction)selectChange:(id)sender {
    self.baseView.backgroundColor = [UIColor grayColor];
    if (self.changeArray == nil) {
        return;
    }
    MyCustomPickerView *pic = [[MyCustomPickerView alloc] initWithFrame:CGRectZero];
    pic.contentArray =  [NSMutableArray arrayWithArray: self.changeArray];
    [pic pickerDataWithCancelBtnBlock:^(UIButton *btn) {
        //点击取消按钮  背景恢复白色
         self.baseView.backgroundColor = [UIColor whiteColor];
        
    } withDoneBtnBlock:^(NSInteger index, id receiveData) {
        self.baseView.backgroundColor = [UIColor whiteColor];
        //点击确认 把cell显示的文字显示为pickerView中的item value值为对应的下标
        
        NSString *itemStr = (NSString *)receiveData;
        [self setTextString:itemStr];
        if (self.keyString) {
            self.valueString = [NSString stringWithFormat:@"%ld",(long)index ] ;
        }
        
        if (self.subKeyString !=nil && [itemStr rangeOfString:@"其"].length>0 ) {
            [self showAlterWithMessage:itemStr];
        }else{
            self.subValueString  = nil;
        }
    } withChangedEventBlock:^(NSInteger index) {
       

    }];
    if (_vc) {
        [pic showInView:_vc.view];
    }
}

- (void)showAlterWithMessage:(NSString *)message{
    st = [[STAlertView alloc] initWithTitle:self.hbTitleLabel.text message:message textFieldHint:@"" textFieldValue:self.subValueString cancelButtonTitle:@"取消" otherButtonTitles:@"确定" cancelButtonBlock:^{
        
    } otherButtonBlock:^(NSString *str) {
        if (self.subKeyString) {
            self.subValueString = str;
        }
    }];
    
    st.alertView.delegate = st;

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//显示样式为textfieldView
- (void)showTextField{
    
    self.textfieldView.hidden = NO;
    self.labelView.hidden = YES;
    
    if ([self.keyString isEqualToString:@"accountReceive"]
        ||[self.keyString isEqualToString:@"address"]
        ||[self.keyString isEqualToString: @"affirmValue"]
        ||[self.keyString isEqualToString:@"assetName"]
        ||[self.keyString isEqualToString:@"bankDeposit"]
        ||[self.keyString isEqualToString:@"bankLoadAmt"]
        ||[self.keyString isEqualToString:@"bondedRate"]
        ||[self.keyString isEqualToString: @"busiScope"]
        ||[self.keyString isEqualToString:@"conNo"]
        ||[self.keyString isEqualToString:@"creditExtensionAmt"]
        ||[self.keyString isEqualToString:@"creditExtensionBalance"]
        ||[self.keyString isEqualToString:@"creditExtensionPeriod"]
        ||[self.keyString isEqualToString:@"creditProductCd"]
        ||[self.keyString isEqualToString:@"custId"]
        ||[self.keyString isEqualToString:@"custName"]
        ||[self.keyString isEqualToString:@"evaMechanism"]
        ||[self.keyString isEqualToString:@"iouId"]
        ||[self.keyString isEqualToString:@"legalPerson"]
        ||[self.keyString isEqualToString:@"loadAmt"]
        ||[self.keyString isEqualToString:@"loadDate"]
        ||[self.keyString isEqualToString:@"endDate"]
        ||[self.keyString isEqualToString:@"loanPurpose"]
        ||[self.keyString isEqualToString:@"materialsValue"]
        ||[self.keyString isEqualToString:@"operationAddress"]
        ||[self.keyString isEqualToString:@"payMethod"]
        ||[self.keyString isEqualToString:@"repayAmt"]
        ||[self.keyString isEqualToString:@"repayDate"]
        ||[self.keyString isEqualToString:@"repayType"]
        ||[self.keyString isEqualToString:@"respCode"]
        ||[self.keyString isEqualToString:@"respMsg"]
        ||[self.keyString isEqualToString:@"shareholderInfo"]
        ||[self.keyString isEqualToString:@"stockValue"])
    {
         [self showTextFieldEdit:NO];
     }else{
         [self showTextFieldEdit:YES];
     }

    
    
    
    
        
}

//设置显示为textfieldView时，是否可以编辑
- (void)showTextFieldEdit:(Boolean)isEditable{
    [self.infoTextfield setEnabled:isEditable];
}

//显示样式为Label 点击出现pickerView
- (void)showLabelView{
    self.textfieldView.hidden = YES;
    self.labelView.hidden = NO;
}

//设置显示的文本
- (void)setTextString:(NSString *)textString{
    if (self.textfieldView.hidden) {
        self.labelViewLabel.text = textString;
    }else{
        self.infoTextfield.text = textString;
    }
}


//编辑开始时 设置键盘弹出的样式
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.baseView.backgroundColor = [UIColor grayColor];
    [self setKeyboardType:textField];
    return YES;
}

//设置键盘弹出的样式
- (void)setKeyboardType:(UITextField *)textField{

    if ([self.keyString isEqualToString:@"bankLoadAmt"]|| //银行借款
        [self.keyString isEqualToString:@"bankDeposit"]||//银行账户存款
        [self.keyString isEqualToString:@"affirmValue"]||//抵押物评估价值
        [self.keyString isEqualToString:@"stockValue"]|| //存货价值
        [self.keyString isEqualToString:@"materialsValue"]||//原材料价值
        [self.keyString isEqualToString:@"accountReceive"]||//应收账款
        [self.keyString isEqualToString:@"loadAmt"]|| //贷款金额
        [self.keyString isEqualToString:@"endDate"]||//贷款期限
        [self.keyString isEqualToString:@"stockPrevBalance"]||//上期检查(或调 查)时点余额
        [self.keyString isEqualToString:@"receBalance"]||//应收账款当前余额
        [self.keyString isEqualToString:@"lentBalance"]||//银行借款当前贷款余额
        [self.keyString isEqualToString:@"lentPrevBalance"]||//银行借款上期余额
        [self.keyString isEqualToString:@"sales"]|| //销售情况销售额
        [self.keyString isEqualToString:@"cash"]|| //现金流情况
        [self.keyString isEqualToString:@"evaluateValue"]||
        [self.keyString isEqualToString:@"evaluateMon"]
        ) {
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }else if([self.keyString isEqualToString:@"loadDate"]||//放款日期
             [self.keyString isEqualToString:@"evaluateDate"]||//
             [self.keyString isEqualToString:@"queryDate"]
             ){
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        textField.keyboardType = UIKeyboardTypeDefault;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    self.baseView.backgroundColor = [UIColor whiteColor];
    self.valueString = textField.text ;
    
    return YES;
}

//结束时 将结果赋值给 self.valueString
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.baseView.backgroundColor = [UIColor whiteColor];
    
    if(textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation){
        while ([textField.text hasPrefix:@"0"]) {
            textField.text = [textField.text substringFromIndex:1];
        } ;
    }
    self.valueString = textField.text ;
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField endEditing:YES];
    self.baseView.backgroundColor = [UIColor whiteColor];
    self.valueString = textField.text ;
}




- (void)setValuetext:(NSString *)value{
    if (self.textfieldView.hidden == NO) {
        self.infoTextfield.text = value;
        self.valueString = value;
//        _infoTextfield.textAlignment = NSTextAlignmentRight;
    }else{
        //设置pick里面的值
        self.labelViewLabel.text = [self.changeArray objectAtIndex:0];
        
        self.valueString = [NSString stringWithFormat:@"%d",[value intValue]];
    }
}


- (void)setTextLength:(NSNumber *)textLength{
    _maxTextLength = [textLength integerValue];
}

//设置输入的最大长度
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length == 0) {
        return YES;
    } else if(textField.text.length ==_maxTextLength ){
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat: @"当前输入长度最大为%ld",(long)_maxTextLength]];
        textField.text = [textField.text substringToIndex:_maxTextLength ];
        return NO;
    }
    return YES;
}





@end
