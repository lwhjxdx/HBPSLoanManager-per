//
//  HBCheckMainViewController.h
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"
typedef enum : NSUInteger {
    MainViewControllerTypeCheck,
    MainViewControllerTypePlane,
} MainViewControllerType;

@interface HBCheckMainViewController : HBBaseViewController
@property(nonatomic,assign)MainViewControllerType mainType;
@end
