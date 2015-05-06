//
//  HBDraftSevice.m
//  HBPSLoanManager
//
//  Created by YM on 15/4/8.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBDraftSevice.h"
#import "DBManager.h"
@implementation HBDraftSevice



//保存数据到草稿箱

- (Boolean)saveDraft:(NSMutableDictionary *)dataDic withType:(HBDraftType)type withClassName:(Class)className
{
    
    //剔除默认的值
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary: dataDic ];
    for (NSString *keyString in [dataDic allKeys]) {
        if ([dataDic[keyString] isEqualToString:kDefaultValue]) {
            [tempDic removeObjectForKey:keyString];
        }
    }
    [tempDic setObject:NSStringFromClass(className) forKey:@"className"];
    NSString *pathString = [self saveData:tempDic];
    if (!pathString) {
        return NO;
    }
    NSString *nameString =  dataDic[@"custName"];
    NSString *checkTypeString = [self getTypeString:type];
    NSInteger checkType = type;

    if (nameString && checkTypeString) {
        
        HBReportModel *model = [[DBManager shareManager] selectInfo:nameString withType:checkType];
        if (model) {
            model.titleString = nameString;
            model.contentString = checkTypeString;
            model.filePath = pathString;
            model.reportType = type;
            model.className = NSStringFromClass(className);
            return [[DBManager shareManager] updateWithModel:model];
        }else{
            model = [[HBReportModel alloc] init];
            model.titleString = nameString;
            model.contentString = checkTypeString;
            model.filePath = pathString;
            model.reportType = type;
            model.className = NSStringFromClass(className);
            return [[DBManager shareManager] insertDataWithModel:model];
        }
        return YES;
    }else{
        //数据异常
        return NO;
    }
}



//获取检查 类型

#warning getTypeString 获取检查类型 目的为填充 首次检查 字样
- (NSString *)getTypeString:(HBDraftType)type{
    NSString *typeString;
    switch (type) {
        case firstCheck:
            typeString = @"首次检查";
            break;
        case routeCheck:
            typeString = @"例行检查";
            break;
        case allCheck:
            typeString = @"全面检查";
            break;
        case payBackCheck:
            typeString = @"贷后跟踪检查";
            break;
        case  localeCollectionCheck:
            typeString = @"催收";
            break;
        case individualCommercialFirstTracking:
            typeString = @"个商首次跟踪";
            break;
        case pVDailyMortgageFirstChecks:
            typeString = @"个商车辆贷款首次检查";
            break;
        case personalVehiclesDailyMortgageChecks:
            typeString = @"个商车辆贷款日常及逾期";
            break;
        case individualCommercialLocaleCollect:
            typeString = @"个商现场催收";
            break;
        case iCRepaymentCondition:
            typeString = @"个商还款情况";
            break;
        case individualCommercialCreditDailyCheck:
            typeString = @"个商贷款日常检查";
            break;

        /**
           依次为 
           case firstCheck:
           typeString = @"首次检查";
           break;
           
           case firstCheck:
           typeString = @"首次检查";
           break;
           
           case firstCheck:
           typeString = @"首次检查";
           break;
           */
            
            
        default:
            break;
    }
    return typeString;
}

//保存数据到本地 返回数据的文件路径
- (NSString *)saveData:(NSMutableDictionary *)data{
    
    NSString *filePath  = [NSHomeDirectory()stringByAppendingPathComponent:@"/Documents/draft"];
    NSString *fileName = [NSString stringWithFormat:@"%@/draft%@%@_%@.plist",filePath,data[@"className"],data[@"conNo"],data[@"custId"]];
    BOOL x = YES;
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&x]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    BOOL success = [data writeToFile:fileName atomically:YES];
    if (success) {
        
        NSLog(@"<<<<<<<fileName %@",fileName);
        return [NSString stringWithFormat:@"/draft%@%@_%@.plist",data[@"className"],data[@"conNo"],data[@"custId"]];
    }else{
        return nil;
    }
}



//从草稿箱中获取数据
- (NSMutableDictionary *)getDataFromDraft:(HBReportModel *)model{
    NSString *filePath = model.filePath;
    NSString *mainfilePath  = [NSHomeDirectory()stringByAppendingPathComponent:@"/Documents/draft"];

    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@%@",mainfilePath,filePath]];
    return [NSMutableDictionary dictionaryWithDictionary:dataDic];
}

//清理草稿箱
- (void)cleanDraft:(NSString *)name type:(HBDraftType)type{
   HBReportModel *model = [[DBManager shareManager] selectInfo: name withType:type];
    if (model) {
        [self deleteModel:model];
    }
}

- (void)deleteModel:(HBReportModel *)model{
    [[DBManager shareManager] deleteDataWithModel:model];
    
    //删除 文件
    if ([[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@",[NSHomeDirectory()stringByAppendingPathComponent:@"/Documents/draft"],model.filePath] error:nil]) {
        NSLog(@"%@删除成功",model.filePath);
    }

}


- (void)deleteAllSeleteItem{
    NSArray *array = [[DBManager shareManager] fetchAllSelect];
    for (HBReportModel *model in array) {
        [self deleteModel:model];
    }
}


//改变所有的数据选择状态

- (void)changeALLSelectStation:(NSString *)string{
    NSArray *dataArray = [[DBManager shareManager] fetchAllUsers];
    for (int i = 0; i < dataArray.count; i++) {
        HBReportModel *model = dataArray[i];
        model.isSelect = string;
        [[DBManager shareManager] updateWithModel:model];
    }
}



@end
