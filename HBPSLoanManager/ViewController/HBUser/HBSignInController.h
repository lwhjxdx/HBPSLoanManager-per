//
//  HBSignInController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/14.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"

//签到页面


@interface HBSignInController : HBBaseViewController
@property(nonatomic, assign)BOOL isShowNextItem;
@property(nonatomic,strong)Class classString;
@property(nonatomic,strong)NSMutableDictionary *pushNextDic;
@end
