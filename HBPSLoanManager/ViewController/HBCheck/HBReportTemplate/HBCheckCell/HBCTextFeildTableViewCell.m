//
//  HBCTextFeildTableViewCell.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/19.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCTextFeildTableViewCell.h"

@implementation HBCTextFeildTableViewCell

//设置infoTextField代理
- (void)awakeFromNib {
    self.infoTextField.delegate = self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.valueString = textField.text;
    return YES;
}

//设置最大长度
- (void)setTextLength:(NSNumber *)textLength{
    _maxTextLength = [textLength integerValue];
}


//限制最多长度
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

//设置textField的输入方式
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //如果是 风险信息   走特殊流程
    if ([self.keyString isEqualToString:@"riskInputInfo"]) {
        [self handleRiskInputInfo];
        return NO;
    }
    [self setKeyboardType:textField];
    return YES;
}


//金额类的输入为数字键盘 其他的为普通键盘
- (void)setKeyboardType:(UITextField *)textField{
    if ([self.keyString isEqualToString:@"bankLoadAmt"]|| //银行借款
        [self.keyString isEqualToString:@"bankDeposit"]||//银行账户存款
        [self.keyString isEqualToString:@"affirmValue"]||//抵押物评估价值
        [self.keyString isEqualToString:@"stockValue"]|| //存货价值
        [self.keyString isEqualToString:@"materialsValue"]||//原材料价值
        [self.keyString isEqualToString:@"accountReceive"]||//应收账款
        [self.keyString isEqualToString:@"loadAmt"]|| //贷款金额
        [self.keyString isEqualToString:@"loadDate"]||//放款日期
        [self.keyString isEqualToString:@"endDate"]||//贷款期限
        [self.keyString isEqualToString:@"stockPrevBalance"]||//上期检查(或调 查)时点余额
        [self.keyString isEqualToString:@"receBalance"]||//应收账款当前余额
        [self.keyString isEqualToString:@"lentBalance"]||//银行借款当前贷款余额
        [self.keyString isEqualToString:@"lentPrevBalance"]||//银行借款上期余额
        [self.keyString isEqualToString:@"sales"]|| //销售情况销售额
        [self.keyString isEqualToString:@"cash"] //现金流情况
        ) {
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }else{
        textField.keyboardType = UIKeyboardTypeDefault;
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.valueString = textField.text;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//设置value文本
- (void)setValueText:(NSString *)value{
    self.valueString = value;
    self.infoTextField.text = value;
}

- (void)handleRiskInputInfo{
    
    pickerView = [[MyCustomPickerView alloc] initWithFrame:CGRectZero];
    pickerView.contentArray = [NSMutableArray arrayWithObjects:
                               @"关联企业较多（关联企业超过3家）",
                               @"对外担保多（对外担保对象超过3家）",
                               @"授信银行多（授信银行超过3家）",
                               @"资产负债率高（加工制造类客户高于70%、批发零售类客户高于80%、其他类客户高于75%）",
                               @"新增授信金额高（我行授信后，新增他行授信金额高于我行授信金额2倍）",
                               @"盲目扩张或多元化投资",
                               @"征信记录较差或出现恶化",
                               @"股东关系破裂",
                               @"贷款挪用",
                               @"存在法律纠纷",
                               @"应收账款回收困难",
                               @"出现经营风险（如销售不畅、收入明显下降等）",
                               @"出现财务风险（如无法按时偿还负债的利息或本金）",
                               @"出现第二还款来源风险",
                               @"外部声誉恶化",
                               @"其他",
                               nil];
    [pickerView pickerDataWithCancelBtnBlock:^(UIButton *btn) {
        
    } withDoneBtnBlock:^(NSInteger index, id receiveData) {
        [self setValueText:receiveData];
    } withChangedEventBlock:^(NSInteger i) {
        
    }];
    [pickerView showInView:[UIApplication sharedApplication].keyWindow];
}


@end
