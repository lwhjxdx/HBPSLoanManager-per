//
//  HBCheckViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseSearchTableViewController.h"

@interface HBCheckViewController : HBBaseSearchTableViewController
@property(nonatomic,strong)NSArray *tableViewArr;
@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,assign)BOOL isShowMap;
@end
