//
//  HBCTextFeildTableViewCell.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/19.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyCustomPickerView.h"
/**
 所有的cell 都有 keyString valueString
 keyString 为需要提交对应字段的key
 valueString 为对应的值
 
 例如：
 cell.keyString = @"name";
 cell.valueString = @"张三";
 
 setValueText 就是设置cell的值

 */
@interface HBCTextFeildTableViewCell : UITableViewCell<UITextFieldDelegate>

{
    NSInteger _maxTextLength;
    MyCustomPickerView *pickerView;
}
@property (weak, nonatomic) IBOutlet UITextField *infoTextField;

@property (nonatomic,copy) NSString *keyString;
@property (nonatomic,copy) NSString *valueString;

- (void)setTextLength:(NSNumber *)textLength;

- (void)setValueText:(NSString *)value;


@end
