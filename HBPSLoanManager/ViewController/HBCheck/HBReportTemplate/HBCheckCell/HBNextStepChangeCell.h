//
//  HBNextStepChangeCell.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/18.
//  Copyright (c) 2015年 YM. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "HBBaseViewController.h"
/**
 此cell为选择按钮样式
 
 
 needAdd 为需要刷新视图时 选中的按钮下标

 cell.needAdd = 1;
 当cell中的按钮被点击 且 当前按钮的下标为1时 出发刷新方法

 */

typedef NS_ENUM(NSUInteger, CheckButtonTag) {
    firstBtnTag = 0,
    secondBtnTag,
    thirdBtnTag
};

@interface HBNextStepChangeCell : UITableViewCell



@property (nonatomic,strong) NSArray *contentArray;
@property (strong, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (strong, nonatomic) IBOutlet UIView *fristView;
@property (strong, nonatomic) IBOutlet UIView *secondView;

@property (strong, nonatomic) IBOutlet UIView *thirdView;

@property (strong, nonatomic) IBOutlet UILabel *firstLabel;
@property (strong, nonatomic) IBOutlet UIButton *firstBtn;

@property (strong, nonatomic) IBOutlet UIButton *secondBtn;
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet UIButton *thirdBtn;
@property (strong, nonatomic) IBOutlet UILabel *thirdLabel;

@property (weak,nonatomic) HBBaseViewController *vc;

@property (nonatomic,copy) NSString *keyString;
@property (nonatomic,copy) NSString *valueString;

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) NSInteger needAdd;


- (void)ConfigCellWithTitle:(NSString *)titleString itemArray:(NSArray *)itemArray;

- (void)setSelectIndex:(NSInteger)selectIndex;




@end
