//
//  TemplateModel.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/18.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemplateModel : NSObject

@property (nonatomic,copy) NSString *userId;

@property (nonatomic,copy) NSString *conNo;


@property (nonatomic,copy) NSString *actualPayMethod;
//贷款实际支付方式
@property (nonatomic,copy) NSString *isPerformfunds;
//是否按合同约定的用途使用信贷资金   0-否 1-是
@property (nonatomic,copy) NSString *isPerform;
//是否履行合同约定  0-否 1-是
@property (nonatomic,copy) NSString *checkAttitude;
//对我行检查的态度  0-配合    1-一般    2-不配合
@property (nonatomic,copy) NSString *isRiskFlag;
//是否存在风险预警信号0-否 1-是
@property (nonatomic,copy) NSString *suggest;
//措施和建议
@property (nonatomic,copy) NSString *actualPurposeAmt;
//实际用途资金使用量 [是否按合同约定的用途使用]选择[是]的场合
@property (nonatomic,copy) NSString *performfundsInputInfo;
//[是否按合同约定的用途使用信贷资金]选择[否]的场合
@property (nonatomic,copy) NSString *performInputInfo;
//[是否履行合同约定]选择[否]的场合
@property (nonatomic,copy) NSString *riskInputInfo;
//风险预警信息 [是否存在风险预警信号]选择[是]的场合

@end