//
//  ZipTool.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/22.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "ZipTool.h"
#import "ZipArchive.h"
@implementation ZipTool

+ (NSString *)getZipPath:(NSString *)pathArrayString{
    NSString *filePath  = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/Documents/Draft"];
    NSString *fileName = [NSString stringWithFormat:@"%@/draft%d.zip",filePath,arc4random()%1000];
    BOOL x = YES;
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&x]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSArray *pathArray = [pathArrayString componentsSeparatedByString:@"," ];
    
    ZipArchive *zip = [[ZipArchive alloc] init];
    [zip CreateZipFile2:fileName];
    
    for (int i = 0; i < pathArray.count; i++) {
     Boolean success = [zip addFileToZip:pathArray[i] newname:[NSString stringWithFormat:@"m%d.jpg",i]];
        if (success) {
            NSLog(@"zip success");
        }else{
            NSLog(@"zip error");
            return nil;
        }
    }
    [zip CloseZipFile2];
    return fileName;
}

@end
