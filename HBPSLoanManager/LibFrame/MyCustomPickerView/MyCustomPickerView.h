//
//  MyCustonPickerView.h
//  MyCustomActionSheetDemo
//
//  Created by newtouch on 14-8-1.
//  Copyright (c) 2014年 qiaoqiao.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelBtnBlcok)(UIButton *);
typedef void(^DoneBtnBlock)(NSInteger , id receiveData);
typedef void(^ChangedEventBlock)(NSInteger);

@interface MyCustomPickerView : UIView

@property (nonatomic, strong) CancelBtnBlcok cancelBlock;
@property (nonatomic, strong) DoneBtnBlock doneBlock;
@property (nonatomic, strong) ChangedEventBlock changedBlock;

@property NSMutableArray *contentArray;
-(void)pickerDataWithCancelBtnBlock:(CancelBtnBlcok )cancleBlock withDoneBtnBlock:(DoneBtnBlock )doneBlock withChangedEventBlock:(ChangedEventBlock )changedBlock;
-(void)showInView:(UIView *)view;
@end
