//
//  HBPSCheckManager.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/6/1.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPSCheckManager.h"
@interface HBPSCheckManager()
@property(nonatomic,strong)NSDictionary *visonInfo;
@property(nonatomic,assign)BOOL isStstus;
@end
@implementation HBPSCheckManager
+(HBPSCheckManager*)sharManager
{
    static HBPSCheckManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HBPSCheckManager alloc]init];
    });
    return _sharedClient;
}
-(void)checkUpdateWithSelfAlertWithStatus:(BOOL)isStatus
{
    self.isStstus = isStatus;
    [[PgyManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateReturnId:)];
}
-(void)updateReturnId:(id)dic
{
    if (!dic||[dic[@"versionName"] isEqualToString:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]) {
        if (_isStstus) {
            [SVProgressHUD showSuccessWithStatus:@"当前版本为最新版本，无需更新"];
        }
    }else{
        self.visonInfo = dic;
        if (_isStstus) {
            [SVProgressHUD dismiss];
            [SVProgressHUD popActivity];
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"版本更新" message:@"当前版本低于最新版本，现在就去更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_visonInfo[@"appUrl"]]];
    }
}
@end
