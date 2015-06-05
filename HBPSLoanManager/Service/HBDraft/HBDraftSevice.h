//
//  HBDraftSevice.h
//  HBPSLoanManager
//
//  Created by YM on 15/4/8.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBReportModel.h"

/*
 所有的检查类型报告 在此都应该有一个对应的type值
 
 通过type 值 ，我们可以知道存储的为哪一个模板类型
 
 
 */
typedef NS_ENUM(NSUInteger, HBDraftType) {
    firstCheck = 1,
    routeCheck,
    allCheck,
    payBackCheck,
    localeCollectionCheck,//催收
    individualCommercialFirstTracking,//个商首次跟踪
    pVDailyMortgageFirstChecks,//个商车辆贷款首次检查
    personalVehiclesDailyMortgageChecks,//    个商车辆贷款日常及逾期
    individualCommercialLocaleCollect,//    个商现场催收
    iCRepaymentCondition,//    个商还款情况
    individualCommercialCreditDailyCheck,//个商贷款日常检查
};

@interface HBDraftSevice : NSObject


//保存数据到草稿箱
- (Boolean)saveDraft:(NSMutableDictionary *)dataDic withType:(HBDraftType)type withClassName:(Class)className;

- (void)cleanDraft:(NSString *)name type:(HBDraftType)type;

- (NSMutableDictionary *)getDataFromDraft:(HBReportModel *)model;

- (void)deleteModel:(HBReportModel *)model;
- (NSInteger)deleteAllSeleteItem:(BOOL)isDelete;


- (void)changeALLSelectStation:(NSString *)string;


@end
