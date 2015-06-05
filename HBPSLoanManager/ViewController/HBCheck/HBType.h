//
//  HBType.h
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/5.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#ifndef HBPSLoanManager_HBType_h
#define HBPSLoanManager_HBType_h
/**
 通过不同的检查类型，请求不同数据，push到不同的页面
 */
typedef enum : NSUInteger {
    CheckTypeGerenshangdai,
    CheckTypeXiaoqiyefaren,
    ChechTypeGerenchedai,
} CheckType;

typedef enum : NSUInteger {
    PlanTypeXiaoqiyefaren,
    PlanTypeGerenshangdai,
    PlanTypeGerenchedai,
} PlanType;
#endif
