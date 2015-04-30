//
//  MyPickerViewForTf.h
//  SPDBCreditCardCenter
//
//  Created by newtouch on 14-8-20.
//  Copyright (c) 2014年 qiaoqiao.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelBtnBlcok)(UIButton *);
typedef void(^DoneBtnBlock)(NSInteger , id receiveData);
typedef void(^ChangedEventBlock)(NSInteger);

@interface MyPickerViewForTf : UIView

@property (nonatomic, strong) CancelBtnBlcok cancelBlock;
@property (nonatomic, strong) DoneBtnBlock doneBlock;
@property (nonatomic, strong) ChangedEventBlock changedBlock;

@property (nonatomic, strong) NSMutableArray *contentArray;
@end
