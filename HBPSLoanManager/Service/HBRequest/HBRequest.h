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
typedef void (^FailBlock)(NSError *error);


@interface HBRequest : NSObject<NSURLConnectionDelegate>

@property (nonatomic ,strong) FinishBlock finishLoadingBlock;
@property (nonatomic ,strong) FailBlock failWithErrorBlock;
@property (nonatomic ,strong) NSMutableData *receiveData;


+(void)RequestDataJointStr:(NSString *)str
                         parameterDic:(NSMutableDictionary *)parameterDic
                      successfulBlock:(FinishBlock )finshedBlock
                            failBlock:(FailBlock )failBlock;


+(void)uploadHeader:(NSString *)url withParams:(NSDictionary *)params
    successfulBlock:(FinishBlock )finshedBlock
          failBlock:(FailBlock )failBlock
        isNoSession:(BOOL)noSession;
@end
