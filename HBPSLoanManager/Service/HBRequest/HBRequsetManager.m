//
//  HBRequsetManager.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBRequsetManager.h"
#import "MBProgressHUD.h"



@implementation HBRequsetManager

static HBRequsetManager *manager = nil;
static NSMutableArray *_queue ;
static NSInteger *_currentCount;
static NSMutableArray *_currentConArray;
+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HBRequsetManager alloc] init];
        _queue = [NSMutableArray array];
        _currentConArray = [NSMutableArray array];
        manager.maxCount = 2;
        _currentCount = 0;
    });
    return manager;
}



- (void)addRequestToQueue:(NSURLConnection *)connection{
    if (_queue) {
        [_queue addObject:connection];
    }
    [self startConnection];
}

- (void)cancelRequestToQueue:(NSURLConnection *)connection{
    [connection cancel];
    [self removeConnection:connection];
}

- (void)removeConnection:(NSURLConnection *)connection{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    if ([_currentConArray containsObject:connection]) {
        [_currentConArray removeObject:connection];
        if (_currentConArray.count == 0) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }
    if ([_queue containsObject:connection]) {
        [_queue removeObject:connection];
    }
    [self startConnection];
}

//是否还有连接
- (Boolean)hasConnection{
    if (_queue.count == 0) {
        return NO;
    }
    return YES;
}


- (void)startConnection{
    for (int i = 0; i<_queue.count; i++) {
        NSURLConnection *connection = _queue[i];
        if (_currentConArray.count <_maxCount && ![_currentConArray containsObject:connection]) {
            [_currentConArray addObject:connection];
            [connection start];
//            [SVProgressHUD showWithStatus:@"正在加载"];
            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            
            NSLog(@"_currentConArray connection %@",connection);
        }else{
            break;
        }
    }
}

- (void)removeAllKindConnection:(NSURLConnection *)connection{
    
    NSURL *url = [connection.currentRequest URL];
    
    NSLog(@"removeAllKindConnection   URL %@",url);
    NSInteger count  = _queue.count;
    
    
    
    for (NSInteger i = count-1 ; i>= 0; i--) {
        NSURLConnection *con = _queue[i];
        
        
        if ([[con.currentRequest URL] isEqual:url]) {
            [_queue removeObject:con];
        }
        
        
        if ([_currentConArray containsObject:con]) {
            [con cancel];
            [_currentConArray removeObject:con];
        }
    }
    if (_currentConArray.count == 0) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    [self startConnection];
}

@end
