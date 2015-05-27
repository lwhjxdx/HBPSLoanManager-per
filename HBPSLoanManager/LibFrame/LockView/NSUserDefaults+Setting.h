//
//  NSUserDefaults+Setting.h
//  veryWallen
//
//  Created by qiuqiu's imac on 14/12/22.
//  Copyright (c) 2014年 qiuqiu's imac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define messagePushNumber               9
#define loginGoBackTimerByGesture      (1*60)
#define loginGoBackTimerOutGesture     (10*60)
#define gestureWrongNumber              5



@interface NSUserDefaults (Setting)

extern  NSString * const pushRecordNumber;
extern  NSString * const goToBackGroundTimer;
extern  NSString * const gestureRecordWrongNumber;
extern  NSString * const judgeGestureBool ;




+(void)changeUserDefalutSetting:(NSString*)key andValue:(NSString*)value;

#pragma mark  设定手势密码是否开启
/**
 *  返回手势密码是否开启
 *
 *  @return 返回是否开启
 */
+(BOOL)acquireGestureBool;
/**
 *  设定手势密码开启
 *
 *  @param gesture 设定手势密码开启
 */
+(void)changeGestureBool:(BOOL)gesture;

#pragma mark  设定手势解锁界面相关
/**
 *  判断上次转入后台的时间在有手势密码的基础上
 *
 *  @return 返回是否超过规定时间，用来处理是否退出手势密码界面
 */
+(BOOL)judgeBackGroundTimer:(BOOL)hasGesture;

/**
 *  设定时间，设定当前或置零
 */
+(void)goBackTimerMakeCurrentDate;
+(void)goBackTimerMakeZero;

#pragma mark 设定手势错误次数相关
/**
 *  判断记录的手势密码错误次数
 *
 *  @return  是否达到错误的最大值
 */
+(BOOL)judgeGestureRecordWrongNumber;
/**
 *  设定手势输入错误的记录次数
 *
 *  @param number 次数
 */
+(void)changeGestureRecordWrongNumber:(NSNumber*)number;
/**
 *  获取手势输入错误的记录次数
 *
 *  @return 次数
 */
+(NSNumber*)acquireGestureRecordWrongNumber;

#pragma mark 设定手势密码
/**
 *  判断手势密码
 *
 *  @param password 输入的密码
 *
 *  @return 返回是否有
 */
+(BOOL)judgeGesturePasswordBy:(NSString*)password;
/**
 *  提取手势密码
 *
 *  @return 手势密码
 */
+(NSString*)acquiregesturePassword;

/**
 *  改变手势密码
 *
 *  @param password 密码
 */
+(void)changeGesturePasswordByPassword:(NSString*)password;

#pragma mark ------------关闭手势删除内容

+(void)deleteGesturePassword;


@end
