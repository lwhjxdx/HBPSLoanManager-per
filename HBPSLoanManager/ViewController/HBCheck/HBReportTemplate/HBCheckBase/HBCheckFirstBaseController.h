//
//  HBCheckFirstBaseController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/31.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckBaseViewController.h"

#define kCellHigh 60

@interface HBCheckFirstBaseController : HBCheckBaseViewController
{
    //用于存放cell的数组
    NSMutableArray *_cellArray;
}


//获取所有参数 将参数存放到 _paramDic中
- (void)getAllParams;

@end
