//
//  HBDefaultConfigerData.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBDefaultConfigerData.h"

#import "HBIntroduceViewController.h"
#import "HBUserViewController.h"
#import "HBCheckViewController.h"
#import "HBPlanViewController.h"

@implementation HBDefaultConfigerData

+(NSArray *)getTabbarImageDefult
{
    NSMutableDictionary *imgDic0 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic0 setObject:[UIImage imageNamed:@"dh-icon"] forKey:@"Default"];
    [imgDic0 setObject:[UIImage imageNamed:@"dh-icon"] forKey:@"Highlighted"];
    [imgDic0 setObject:[UIImage imageNamed:@"dh-icon-hover"] forKey:@"Seleted"];

    
    
    
    NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic1 setObject:[UIImage imageNamed:@"dh-icon1"] forKey:@"Default"];
    [imgDic1 setObject:[UIImage imageNamed:@"dh-icon1"] forKey:@"Highlighted"];
    [imgDic1 setObject:[UIImage imageNamed:@"dh-icon1-hover"] forKey:@"Seleted"];
   
    
    NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic2 setObject:[UIImage imageNamed:@"dh-icon2"] forKey:@"Default"];
    [imgDic2 setObject:[UIImage imageNamed:@"dh-icon2"] forKey:@"Highlighted"];
    [imgDic2 setObject:[UIImage imageNamed:@"dh-icon2-hover"] forKey:@"Seleted"];
 

    
    NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic3 setObject:[UIImage imageNamed:@"dh-icon3"] forKey:@"Default"];
    [imgDic3 setObject:[UIImage imageNamed:@"dh-icon3"] forKey:@"Highlighted"];
    [imgDic3 setObject:[UIImage imageNamed:@"dh-icon3-hover"] forKey:@"Seleted"];

    
    NSArray *imgArr = [NSArray arrayWithObjects:imgDic0,imgDic1,imgDic2,imgDic3,nil];
    return imgArr;
}


+(NSArray *)getTabbarControl
{
    HBPlanViewController *vc1 = [[HBPlanViewController alloc] init];
    HBCheckViewController *vc2 = [[HBCheckViewController alloc] init];
    HBIntroduceViewController *vc3 = [[HBIntroduceViewController alloc] init];
    HBUserViewController *vc4 = [[HBUserViewController alloc] init];
    UINavigationController *nav1 =[[UINavigationController alloc] initWithRootViewController:vc1];
    nav1.title = @"计划";
    UINavigationController *nav2 =[[UINavigationController alloc] initWithRootViewController:vc2];
    nav2.title = @"检查";
    UINavigationController *nav3 =[[UINavigationController alloc] initWithRootViewController:vc3];
    nav3.title = @"业务介绍";
    UINavigationController *nav4 =[[UINavigationController alloc] initWithRootViewController:vc4];
    nav4.title = @"我的信息";
    NSArray *mControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4,nil];
    return mControllers;
}

+ (NSArray *)getTitleArray{
    NSArray *titleArray = @[@"计划",@"检查",@"业务介绍",@"我的信息"];
    return titleArray;
}


@end
