//
//  HBUserModel.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBUserModel.h"
#import "NSString+Encrypt3DESandBase64.h"

#define kEncryptKey @"encryptKey"

@implementation HBUserModel

static NSArray *keyArray = nil;
//保存用户信息  用户信息字段加密
+ (void)saveUserModel:(NSDictionary *)userDic{
    NSUserDefaults *userDefault  =[NSUserDefaults standardUserDefaults];
    keyArray = [userDic allKeys];
    for (NSString *keyString in keyArray) {
        NSString *valueString = [userDic objectForKey:keyString];
        NSString *entryString = [valueString encryptStringWithKey:kEncryptKey];
        [userDefault setObject:entryString forKey:keyString];
    }
    //将所有的用户信息字段 存放到 keyArray 的键中。
    [userDefault setObject:keyArray forKey:@"keyArray"];
    [userDefault synchronize];
}
+ (NSString *)getRealname{
    return  [HBUserModel getValueString:@"realname"]?[HBUserModel getValueString:@"realname"]:@"";

}
+ (NSString *)getUserName{
    return  [HBUserModel getValueString:@"username"]?[HBUserModel getValueString:@"username"]:@"";
}

+ (NSString *)getHeadImagePath{
    NSString *valueString = [HBUserModel getValueString:@"userPictureUrl"];
    //剔除 url中的\\
    valueString = [valueString stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    
    NSLog(@"getHeadImagePath %@",valueString);
    return valueString;
    
}

+ (void)setHeadImagePath:(NSString *)imagePath{
    NSUserDefaults *userDefault  =[NSUserDefaults standardUserDefaults];
    NSString *userImage = [imagePath encryptStringWithKey:kEncryptKey];
    [userDefault setObject:userImage forKey:@"userPictureUrl"];
    [userDefault synchronize];
}


+ (void)setLoactionInfo:(NSString *)location{
    NSUserDefaults *userDefault  =[NSUserDefaults standardUserDefaults];
    NSString *locationString = [location encryptStringWithKey:kEncryptKey];
    [userDefault setObject:locationString forKey:kLocationInfo];
    [userDefault synchronize];
}

+ (NSString *)getLoactionInfo{
    return [HBUserModel getValueString:kLocationInfo];
}


+ (NSString *)getUserId{
    return  [HBUserModel getValueString:@"soleid"];
}


+ (NSString *)getUserTel{
    return  [HBUserModel getValueString:@"userPhone"];
}

+ (NSString *)getUserInstitution{
    return [HBUserModel getValueString:@"userInstitution"];
}

+ (NSString *)getRoleName{
    return [HBUserModel getValueString:@"roleName"];
}
+ (NSString *)getValueString:(NSString *)keyString{
    NSUserDefaults *userDefault  =[NSUserDefaults standardUserDefaults];
    NSString *valueString = [userDefault objectForKey:keyString];
    NSString *entryString;
    if (valueString) {
       entryString = [valueString decryptStringWithKey:kEncryptKey];
    }
    return entryString;
}



+ (void)clearUserInfo{
    NSUserDefaults *userDefault  =[NSUserDefaults standardUserDefaults];
    keyArray = [userDefault objectForKey:@"keyArray"];
    if (keyArray) {
        for (NSString *key in keyArray) {
            [userDefault removeObjectForKey:key];
        }
    }
    
    if ([userDefault objectForKey:kLocationInfo]) {
        [userDefault removeObjectForKey:kLocationInfo];
    }
    [userDefault synchronize];
}


@end
