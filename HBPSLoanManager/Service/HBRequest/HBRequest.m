//
//  HBRequest.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBRequest.h"
#import "MyMD5.h"
#import "MBProgressHUD.h"
#import "ER3DESEncrypt.h"
#import "NSString+encrypt.h"
#import "Encrypt.h"
#import "HBRequsetManager.h"
#define ENCODE_KEY @"!*'();:@&=+$,/?%#[]"

#define  BOUNDARY @"#####"


@implementation HBRequest

+(void)RequestDataJointStr:(NSString *)str
              parameterDic:(NSMutableDictionary *)parameterDic
           successfulBlock:(FinishBlock )finshedBlock
                 failBlock:(FailBlock )failBlock
{
    
//    NSLog(@"RequestDataJointStr ---->\n %@",parameterDic);
    
    HBRequest *networkRequest = [[HBRequest alloc]init];
    networkRequest.finishLoadingBlock = finshedBlock;
    networkRequest.failWithErrorBlock = failBlock;
    
    NSString *HBURL = [NSString stringWithFormat:@"%@%@",kBaseURL,str];
  
 
    NSString *parameterStr =  [networkRequest joinParameterDic:parameterDic];
    NSData *dataRequest = [parameterStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:HBURL]];
    request.timeoutInterval = kTIMEOUTSECOND;
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[[NSNumber numberWithInteger:[dataRequest length]] stringValue] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:dataRequest];
    
    NSURLConnection *asynConnection = [[NSURLConnection alloc] initWithRequest:request  delegate:networkRequest startImmediately:NO];
    [[HBRequsetManager shareManager] addRequestToQueue:asynConnection];
}

//上传附件的网络请求
+(void)uploadHeader:(NSString *)url withParams:(NSDictionary *)params
    successfulBlock:(FinishBlock )finshedBlock
          failBlock:(FailBlock )failBlock
        isNoSession:(BOOL)noSession{
    
    HBRequest *hbRequest = [[HBRequest alloc]init];
    hbRequest.finishLoadingBlock = finshedBlock;
    hbRequest.failWithErrorBlock = failBlock;
    
    
    NSString *HBRequestUrl = [kBaseURL stringByAppendingFormat:@"/%@",url];
    HBRequestUrl = [HBRequestUrl stringByAppendingString:[NSString stringWithFormat:@"?uploadType=%@",[params objectForKey:@"uploadType"]]];
    
    NSMutableURLRequest *myRequest = [ [NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:HBRequestUrl] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setValue:[@"multipart/form-data; boundary=" stringByAppendingString:BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    for(NSString *key in params) {
        id content = [params objectForKey:key];
        if ([content isKindOfClass:[NSString class]] || [content isKindOfClass:[NSNumber class]]) {
            NSString *param = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",BOUNDARY,key,content,nil];
            [body appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
        }else if ([content isKindOfClass:[NSData class]]) {
            
            //将该数据添加到 请求体中
            NSData *file = (NSData *)content;
            NSString *param;
            if ([[params objectForKey:@"uploadType"] isEqualToString:@"1"]) {
                param = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\";filename=\"x%d%d.jpg\"\r\nContent-Type: application/octet-stream\r\n\r\n",BOUNDARY,key,arc4random()%1000,arc4random()%1000,nil];
            }else{
                param  = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\";filename=\"x%d%d.zip\"\r\nContent-Type: application/octet-stream\r\n\r\n",BOUNDARY,key,arc4random()%1000,arc4random()%1000,nil];
            }
            [body appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:file];
            
//            NSLog(@"<<<<<<<file>>>>>>> %dk",file.length/1024);
            
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    NSString *endString = [NSString stringWithFormat:@"--%@",BOUNDARY];
    [body appendData:[endString dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequest setHTTPBody:body];
    NSURLConnection *asynConnection = [[NSURLConnection alloc] initWithRequest:myRequest  delegate:hbRequest startImmediately:NO];
    
    [[HBRequsetManager shareManager] addRequestToQueue:asynConnection];
}



#pragma mark - connectionDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
//    NSLog(@"response ---->\n %@",response);

    
    if (!self.receiveData) {
        self.receiveData = [[NSMutableData alloc]init];
    } else {
        [self.receiveData setLength:0];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [[HBRequsetManager shareManager] removeConnection:connection];
    
    NSDictionary *resultDic = [self decryptDataFromeNetWorking:self.receiveData];
//    NSLog(@"connectionDidFinishLoading --->\n connection %@ resultDic--------->\n %@",connection,resultDic);
    
    if (![[resultDic objectForKey:@"respCode"] isEqualToString:@"0000"]) {
        [SVProgressHUD showErrorWithStatus:resultDic[@"respMsg"]?resultDic[@"respMsg"]:@"数据异常"];
        if (self.failWithErrorBlock) {
            self.failWithErrorBlock(nil);
        }
//
//        if ([resultDic objectForKey:@"respMsg"]) {
//            
//            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:[resultDic objectForKey:@"respMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [al show];
//        }
    }
    else{
        if (self.finishLoadingBlock) {
            self.finishLoadingBlock(resultDic);
        }
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.receiveData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    NSLog(@" connection : ----->\n %@   didFailWithError----->\n %@",connection,error);

    if (self.failWithErrorBlock) {
        self.failWithErrorBlock(error);
    }
    
    [[HBRequsetManager shareManager] removeAllKindConnection: connection];
    [SVProgressHUD showErrorWithStatus:@"网络请求失败"];

}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString: NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
    }
}

#pragma mark - 数据处理
//dictionary 转 json
-(NSString *)cStrWithDic:(NSMutableDictionary *)dictionary
{
    NSMutableDictionary *tempDictionary = dictionary;
    if (tempDictionary == nil) {
        tempDictionary = [NSMutableDictionary dictionary];
    }
//我贼，网络请求写这个闹哪样
//    if ([HBUserModel getUserId]) {
//        [tempDictionary setObject:[HBUserModel getUserId] forKey:@"userId"];
//    }
//    
//    if (!PAT_) {
//        [tempDictionary setObject:@"161" forKey:@"userId"];
//    }
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:tempDictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    NSString *string = [[NSString alloc] initWithData:json
                                             encoding:NSUTF8StringEncoding];
    return string;
}

//拼接参数
-(NSString *)joinParameterDic:(NSMutableDictionary *)parameter {
    NSString *jsonStr = [self cStrWithDic:parameter];
    NSString *dataString = [NSString stringWithFormat:@"data=%@",jsonStr];
    return dataString;
}


//解密网络请求数据
- (NSDictionary *)decryptDataFromeNetWorking:(id)jsonData{
     NSString *result = [[NSString alloc] initWithData:jsonData  encoding:NSUTF8StringEncoding];
    NSDictionary *resultDic = [HBRequest dictionaryWithJsonString:result];
    return resultDic;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        return nil;
    }
    return dic;
}

//encodeing
-(NSString *)encodeURL:(NSString *)dString{
    
    NSString *escapeUrlString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)dString, NULL, (CFStringRef)ENCODE_KEY, kCFStringEncodingUTF8 ));
    
    escapeUrlString = [escapeUrlString stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
    
    return escapeUrlString;
}





@end
