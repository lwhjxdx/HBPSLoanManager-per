//
//  HBPSCheckManager.h
//  HBPSLoanManager
//
//  Created by MC700 on 15/6/1.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <PgySDK/PgyManager.h>

@interface HBPSCheckManager : PgyManager
+(HBPSCheckManager*)sharManager;
-(void)checkUpdateWithSelfAlertWithStatus:(BOOL)isStatus;
@end
