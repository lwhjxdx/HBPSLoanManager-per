//
//  HBCFirstViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/18.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckFirstBaseController.h"

@interface HBCFirstViewController : HBCheckFirstBaseController

/**
 摆放原则
 
 一类的cell摆放一块
 
 */
@property (nonatomic,copy) NSMutableDictionary *customerDicWithFirst;
@end
