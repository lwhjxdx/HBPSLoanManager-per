//
//  NLSecurityManager.h
//  iPhoneCommon
//
//  Created by Nono on 12-6-4.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h" 
#import <CommonCrypto/CommonCryptor.h>

#define MD5KEY @"65541919"
#define DESKEY @"jifencai123spdb321qAzWsX"
@interface NLSecurityManager : NSObject

//3des加解密
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

@end
