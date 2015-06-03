
//
//  NSUserDefaults+Setting.m
//  veryWallen
//
//  Created by qiuqiu's imac on 14/12/22.
//  Copyright (c) 2014年 qiuqiu's imac. All rights reserved.
//

#import "NSUserDefaults+Setting.h"
#import "NSString+encrypt.h"

#define settingKey @"settingKey"




@implementation NSUserDefaults (Setting)


+(void)changeUserDefalutSetting:(NSString*)key andValue:(NSString*)value
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NSUserDefaults acquireDcitionary]];
    if (!dic) {
        dic=[NSMutableDictionary dictionary];
    }
    [dic setObject:value forKey:key];
    
    NSMutableDictionary *dicKey = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:settingKey]];
    
    if (!dicKey) {
        dicKey = [NSMutableDictionary dictionary];
    }
    if ([HBUserModel getUserId]) {
        [dicKey setValue:dic forKey:[HBUserModel getUserId]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dicKey forKey:settingKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(void)changeUserDefalutTimerOrNumber:(NSString*)key andValue:(NSString*)value
{
    NSMutableDictionary *dicKey = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:settingKey]];
    if (!dicKey) {
        dicKey = [NSMutableDictionary dictionary];
    }
    [dicKey setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:dicKey forKey:settingKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSDictionary*)acquireDcitionary
{
    if ([HBUserModel getUserId]) {
        return [[NSUserDefaults standardUserDefaults] dictionaryForKey:settingKey][[HBUserModel getUserId]];
    }
    return @{};
}

+(NSDictionary*)acquireTimerOrNumberDictionary
{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:settingKey];
}
//#pragma mark -------------设定消息推送开启提醒计数
//
//NSString * const pushRecordNumber = @"pushRecordNumbder";
//+(void)detectionPushMessage
//{
//    if ([TestSystemService showLocationAlertWithService:SystemServicePushMessage byShowAlert:NO]) {
//        [NSUserDefaults  changePushRecordNumberByNumber:0];
//        return;
//    }else{
//        NSInteger number = [NSUserDefaults  acquirePushRecordNumber];
//        if (number>=messagePushNumber) {
//            [TestSystemService showLocationAlertWithService:SystemServicePushMessage byShowAlert:YES];
//            [NSUserDefaults changePushRecordNumberByNumber:0];
//        }else{
//            [NSUserDefaults changePushRecordNumberByNumber:++number];
//        }
//    }
//}
//
//+(void)changePushRecordNumberByNumber:(long)number
//{
//    [NSUserDefaults changeUserDefalutTimerOrNumber:pushRecordNumber andValue:[NSString stringWithFormat:@"%ld",number]];
//}
//
//
//
//
//
//+(NSInteger)acquirePushRecordNumber
//{
//    
//    return [[[NSUserDefaults standardUserDefaults] dictionaryForKey:settingKey][pushRecordNumber] integerValue];
//}

#pragma mark --------------设定判定是否设定手势密码

NSString * const judgeGestureBool = @"judgeGestureBool";

+(BOOL)acquireGestureBool
{
    NSString *string =[NSUserDefaults acquireDcitionary][judgeGestureBool];
    if (string) {
        return [string isEqualToString:@"YES"];
    }
    return NO;
}

+(void)changeGestureBool:(BOOL)gesture
{
    [NSUserDefaults changeUserDefalutSetting:judgeGestureBool andValue:[NSString stringWithFormat:@"%@",gesture?@"YES":@"NO"]];
}


#pragma mark ------------关于手势解锁失败次数记录

NSString *const gestureRecordWrongNumber = @"gestureRecordWrongNumber";

+(BOOL)judgeGestureRecordWrongNumber
{
    NSNumber *cureentNum = [NSUserDefaults acquireGestureRecordWrongNumber];
    if (!cureentNum||[cureentNum integerValue]<gestureWrongNumber ) {
        return NO;
    }
    return YES;
}

+(NSNumber*)acquireGestureRecordWrongNumber
{
    return @([[NSUserDefaults acquireDcitionary][gestureRecordWrongNumber] integerValue]);
}

+(void)changeGestureRecordWrongNumber:(NSNumber*)number
{
    [NSUserDefaults changeUserDefalutSetting:gestureRecordWrongNumber andValue:[number stringValue]];
}

#pragma mark -----------设定跳入后台记录时间

NSString *const goToBackGroundTimer = @"goToBackGroundTimer";

+(BOOL)judgeBackGroundTimer:(BOOL)hasGesture
{
    NSTimeInterval timer = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval lastTimer = [NSUserDefaults acquireBackGroundTimer];
    
//    NSLog(@"long=%d,date=%@,lastTimer=%@",(hasGesture?loginGoBackTimerByGesture:loginGoBackTimerOutGesture),[NSDate dateWithTimeIntervalSince1970:timer],[NSDate dateWithTimeIntervalSince1970:lastTimer]);
    //判断时间是否存在，如果不存在，那么版本不是最新，返回退出登录
    if (!lastTimer) {
        return YES;
    }
    if (lastTimer) {
        return (lastTimer+(hasGesture?loginGoBackTimerByGesture:loginGoBackTimerOutGesture))<timer;
    }
    return NO;
}

+(NSTimeInterval)acquireBackGroundTimer
{
    return [[NSUserDefaults acquireTimerOrNumberDictionary][goToBackGroundTimer] doubleValue];
}

+(void)changeBackGroundtimerByTimer:(NSTimeInterval)timer
{
    
    [NSUserDefaults changeUserDefalutTimerOrNumber:goToBackGroundTimer andValue:[NSString stringWithFormat:@"%f",timer]];
}

+(void)goBackTimerMakeZero
{
    [NSUserDefaults changeBackGroundtimerByTimer:1.f];
}

+(void)goBackTimerMakeCurrentDate
{
    [NSUserDefaults changeBackGroundtimerByTimer:[[NSDate date] timeIntervalSince1970]];
}

#pragma mark ------------设定手势密码相关

NSString *const gesturePassword = @"gesturePassword";


+(BOOL)judgeGesturePasswordBy:(NSString*)password
{
    NSString *string = [password sha1_base64];
    NSString *pas = [NSUserDefaults acquiregesturePassword];
    if (!pas||!string) {
        return NO;
    }
    return [string isEqualToString:pas];
}


+(NSString*)acquiregesturePassword
{
    return [NSUserDefaults acquireDcitionary][gesturePassword];
}

+(void)changeGesturePasswordByPassword:(NSString*)password
{
    [NSUserDefaults changeUserDefalutSetting:gesturePassword andValue:[password sha1_base64]];
}

#pragma mark -----------关闭手势的事情

+(void)deleteGesturePassword
{
//    NSMutableDictionary *dicKey = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:settingKey]];
//    if ([UserBase currentUserBase].telephone) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:settingKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [self changeGestureBool:NO];

//    }
}


//#pragma mark ---------设定是否获取余额的状态
//
//NSString *const needBlanceState = @"blanceState";
//
//+(BOOL)getNeedBlanceState
//{
//    id state = [[NSUserDefaults standardUserDefaults]valueForKey:needBlanceState];
//    if (state) {
//        return [state boolValue];
//    }
//    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:needBlanceState];
//    return YES;
//}
//
//+(void)setNeedBlanceState:(BOOL)state
//{
//    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:state] forKey:needBlanceState];
//}


@end
