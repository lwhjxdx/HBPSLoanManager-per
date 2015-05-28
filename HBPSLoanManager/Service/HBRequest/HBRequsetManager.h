//
//  HBRequsetManager.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBRequsetManager : NSObject

@property (nonatomic,assign) NSInteger maxCount;
+ (instancetype)shareManager;
/**
 *  添加请求到队列中
 *
 *  @param connection 请求链接和数据
 */
- (void)addRequestToQueue:(NSURLConnection *)connection;
/**
 *  取消队列中的请求
 *
 *  @param connection 取消请求的链接和数据
 */
- (void)cancelRequestToQueue:(NSURLConnection *)connection;
/**
 *  移除链接
 *
 *  @param connection 移除的链接
 */
- (void)removeConnection:(NSURLConnection *)connection;
/**
 *  判断队列中是否有请求
 *
 *  @return 返回是否有请求
 */
- (Boolean)hasConnection;
/**
 *  移除所有链接
 *
 *  @param connection 移除的链接
 */
- (void)removeAllKindConnection:(NSURLConnection *)connection;



@end
