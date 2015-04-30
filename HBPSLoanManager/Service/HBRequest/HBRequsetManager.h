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

- (void)addRequestToQueue:(NSURLConnection *)connection;

- (void)cancelRequestToQueue:(NSURLConnection *)connection;

- (void)removeConnection:(NSURLConnection *)connection;

- (Boolean)hasConnection;

- (void)removeAllKindConnection:(NSURLConnection *)connection;



@end
