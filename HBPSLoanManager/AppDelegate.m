//
//  AppDelegate.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "AppDelegate.h"
#import "HBLoginViewController.h"
#import "BMKMapView.h"
#import "HBUserModel.h"
#import "MobClick.h"
#import "NSUserDefaults+Setting.h"
#import "DefaultLockViewController.h"
#import <PgySDK/PgyManager.h>
//手机端异常信息请求
void uncaughtExceptionHandler(NSException *exception)
{
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    
//    NSString *strName = [[UIDevice currentDevice] name];//e.g. "My iPhone"手机名称
    
    //系统版本号
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    strSysVersion = [strSysVersion stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];//获取当前的APP版本号
    appVersion = [appVersion stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    //解密获取手机号码
    NSLog(@" exceptionInfo - exceptionInfo - exceptionInfo - exceptionInfo - exceptionInfo");
    NSLog(@"%@",exceptionInfo);
    NSLog(@" exceptionInfo - exceptionInfo - exceptionInfo - exceptionInfo - exceptionInfo");
}


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [MobClick startWithAppkey:UMENG_APPKEY];
//    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:REALTIME channelId:nil];
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGY_APP_ID];
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    [[PgyManager sharedPgyManager] checkUpdate];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HBLoginViewController *root = [[HBLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    
    
    //百度地图相关配置
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"UEz7X8pY9vhslqt68gZ8yGDP"  generalDelegate:nil];//  WxVQsZyEH14hCkACsNzNqjGD
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作

}
/**
 *  判断用户是否登录
 */
- (void)isLogin
{
    //判断是否登录，不登陆也就不用管啦
    if ([HBUserModel getUserId]) {
        [self judgeGesPassWord];
    }else {
        [self logoutWithTimeout];
    }
    [NSUserDefaults goBackTimerMakeCurrentDate];
}

-(void)judgeGesPassWord
{
    if ([HBUserModel getUserId])
    {
        //这里涉及到是否开启密码锁的问题
        if ([NSUserDefaults acquireGestureBool])
        {
            //判断手势密码错误次数，
            if (![NSUserDefaults judgeGestureRecordWrongNumber])
            {
                //判断记录的时间问题，如果超时，那么推出，没超过，不用管
                if ([NSUserDefaults judgeBackGroundTimer:YES])
                {
                    if (!_window.rootViewController.presentedViewController)
                    {
                        [_window.rootViewController presentViewController:[[DefaultLockViewController alloc]init] animated:YES completion:nil];
                    }
                    [NSUserDefaults changeGestureRecordWrongNumber:@0];
                }
            }else{
                [self deleteUserInfo];
                [self loginAction];
            }
        }else{
            //这里是需要判断在没有设定手势密码的情况下是否超时，不超时不需处理
            if ([NSUserDefaults judgeBackGroundTimer:NO]) {
                //超时，退出重新登录
                [self deleteUserInfo];
                [self loginAction];
            }
            [NSUserDefaults changeGestureRecordWrongNumber:@0];
        }
    }else{
        [self loginAction];
    }
}




-(void)logoutWithTimeout
{
    if ([NSUserDefaults judgeBackGroundTimer:NO]) {
        //超时，退出重新登录
        [self deleteUserInfo];
        [self loginAction];
    }else{
        if (![HBUserModel getUserId]) {
            [self loginAction];
        }
    }
}
-(void)deleteUserInfo
{
    
}
-(void)loginAction
{
    
}
- (void)applicationWillTerminate:(UIApplication *)application {

    
}

@end
