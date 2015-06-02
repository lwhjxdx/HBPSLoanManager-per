//
//  HBRequest.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

typedef void (^FinishBlock)(NSDictionary * receiveJSON);
typedef void (^FailBlock)(NSError *error,NSDictionary * receiveJSON);


@interface HBRequest : NSObject<NSURLConnectionDelegate>

@property (nonatomic ,strong) FinishBlock finishLoadingBlock;
@property (nonatomic ,strong) FailBlock failWithErrorBlock;
@property (nonatomic ,strong) NSMutableData *receiveData;

/**
 *  向后台请求数据，包含加载界面，加载结束后会自动关闭加载active界面
 *
 *  @param str          链接后缀
 *  @param parameterDic 发送给后台的键值对
 *  @param finshedBlock 请求成功返回代码块
 *  @param failBlock    请求失败返回代码块
 */
+(void)RequestDataJointStr:(NSString *)str
                         parameterDic:(NSMutableDictionary *)parameterDic
                      successfulBlock:(FinishBlock )finshedBlock
                            failBlock:(FailBlock )failBlock;

/**
 *  向后台请求数据，不包含加载界面，自己手动添加svHub或者MMBHub,加载结束后会自动关闭加载active界面
 *
 *  @param str          链接后缀
 *  @param parameterDic 发送给后台的键值对
 *  @param finshedBlock 请求成功返回代码块
 *  @param failBlock    请求失败返回代码块
 */
+(void)RequestDataNoWaittingJointStr:(NSString *)str
                        parameterDic:(NSMutableDictionary *)parameterDic
                     successfulBlock:(FinishBlock )finshedBlock
                           failBlock:(FailBlock )failBlock;

/**
 *  向后台发送数据请求，加载结束后会自动关闭加载active界面
 *
 *  @param str          链接后缀
 *  @param parameterDic 发送给后台的键值对
 *  @param finshedBlock 请求成功返回代码块
 *  @param failBlock    请求失败返回代码块
 */
+(void)uploadHeader:(NSString *)url withParams:(NSDictionary *)params
    successfulBlock:(FinishBlock )finshedBlock
          failBlock:(FailBlock )failBlock
        isNoSession:(BOOL)noSession;
@end
