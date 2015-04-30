//
//  NLSecurityManager.m
//  iPhoneCommon
//
//  Created by Nono on 12-6-4.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLSecurityManager.h"

@implementation NLSecurityManager

//3des加解密，
//plaintext:需要被加解密的数据
//encryptOrDecrypt：加密还是解密
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else //加密
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    
    //DESKEY:为3des的key
     const void *vkey = (const void *) [DESKEY UTF8String];
   // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
   //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                        kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey, 
                       kCCKeySize3DES,
                       nil, 
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    if (ccStatus == kCCSuccess){ NSLog(@"SUCCESS");}
    else if (ccStatus == kCCParamError){ return @"PARAM ERROR";}
    else if (ccStatus == kCCBufferTooSmall) {return @"BUFFER TOO SMALL";}
    else if (ccStatus == kCCMemoryFailure){ return @"MEMORY FAILURE";}
    else if (ccStatus == kCCAlignmentError) {return @"ALIGNMENT";}
    else if (ccStatus == kCCDecodeError) {return @"DECODE ERROR";}
    else if (ccStatus == kCCUnimplemented) {return @"UNIMPLEMENTED"; }
            
    NSString *result;
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                length:(NSUInteger)movedBytes] 
                                        encoding:NSUTF8StringEncoding] ;
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    free(bufferPtr);
   
    return result;
    
}

@end
