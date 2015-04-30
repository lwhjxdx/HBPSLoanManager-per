//
//  NSString+encrypt.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encrypt)


- (NSString*) sha1;


-(NSString *) md5;


- (NSString *) sha1_base64;


- (NSString *) md5_base64;


- (NSString *) base64;

@end
