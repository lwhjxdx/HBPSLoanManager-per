//
//  HBRepeatListViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"
#import "HBType.h"
@interface HBRepeatListViewController : HBBaseViewController

@property (nonatomic,copy) NSMutableDictionary *customerDic;
@property (nonatomic,assign)CheckType checkType;

@end
