//
//  Encrypt.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/13.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encrypt : NSObject

+ (NSString*)encrypt:(NSString*)plainText ;

+ (NSString*)decrypt:(NSString*)encryptText ;




@end
