//
//  HBCheckNextDelegate.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HBCheckNextDelegate <NSObject>

- (void)getNextData:(NSMutableDict)dataDic;

@end
