//
//  ReportTableViewCell.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/18.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAlertView.h"

/**
 此cell为两个样式
 一个为  输入框 样式
 一个为  点击出现pickerView 样式
 
 
 changeArray 点击出现pickerView 样式中 pickerView 中需要显示的item
 
 */
@interface ReportTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    NSInteger _maxTextLength;
    
    STAlertView *st;
}
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *hbTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *textfieldView;
@property (weak, nonatomic) IBOutlet UITextField *infoTextfield;
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet UILabel *labelViewLabel;


@property (nonatomic,copy) NSString *keyString;
@property (nonatomic,copy) NSString *valueString;
@property (nonatomic,copy) NSArray *changeArray;
@property (nonatomic,weak) UIViewController *vc;

@property (nonatomic,copy) NSString *subKeyString;
@property (nonatomic,copy) NSString *subValueString;


//设置 valueString
- (void)setValuetext:(NSString *)value;

//显示样式为TextField
- (void)showTextField;

//显示样式为TextField isEditable为是否可编辑
- (void)showTextFieldEdit:(Boolean)isEditable;

//显示样式为 点击出现pickerView 样式
- (void)showLabelView;


//设置textfield 的输入的最大长度
- (void)setTextLength:(NSNumber *)textLength;

//设置显示的text
- (void)setTextString:(NSString *)textString;


@end
