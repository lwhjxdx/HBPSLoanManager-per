//
//  HBUserModel.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBUserModel : NSObject


+ (void)saveUserModel:(NSDictionary *)userDic;

+ (NSString *)getUserName;

//获取头像地址
+ (NSString *)getHeadImagePath;

+ (NSString *)getUserId;

+ (NSString *)getUserTel;

+ (NSString *)getUserInstitution;

+ (NSString *)getRoleName;

+ (NSString *)getRealname;

+ (void)setHeadImagePath:(NSString *)imagePath;



/**
 用户触发定位时 
 将定位的地址信息保存本地 调用方法 setLoactionInfo:(NSString *)location;
 拍照时，拍照的水印会自动添加位置信息
 */

+ (void)setLoactionInfo:(NSString *)location;

+ (NSString *)getLoactionInfo;


//清除用户信息
+ (void)clearUserInfo;

@end
