//
//  Define.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#ifndef HBPSLoanManager_Define_h
#define HBPSLoanManager_Define_h

//接口宏定义

#define PAT_   YES
//生产环境

#define LogInfo 1

#if LogInfo
#define NSLog(...)  NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif



#define kBaseURL  @"http://180.168.123.215:8090/p2pInterface/"
//基本URL

#define kLoginURL @"userAction/login.do"
//登录

#define kSignInURL1 @"userAction/signIn.do" 
//签到第一步
#define kSignInURL2 @"userAction/querySignInDate.do"
//签到第二步
//签到

#define kLoginOutURL @"userAction/loginOut.do"
//登出

#define kModifyPwdURL @"userAction/modifyPwd.do"
//密码修改


#define kFileUploadURL @"fileUploadAction/fileUpload.do"
//文件上传

#define kFindCustInfo @"customerAction/findCustInfo.do"
//用户信息查询

#define kQueryReportBaseInfo @"reportAction/queryReportBaseInfo.do"
//贷款情况查询


#define kGetCheckPlanList  @"checkPlanAction/getCheckPlanList.do"
//获取检查计划列表   userNo  checked

#define kSaveVoiceCall @"ycallAction/saveVoiceCall.do"
//保存语音外呼接口 userId:161,destTel:1312125,srcTel:21513626

#define kUpdateUserUrl  @"userAction/updateUserUrl.do"
//上传头像接口 ?data={userId:6420150313143702,userPictureUrl:www.baidu.com"

#define kInsertIndexCheckModel @"reportAction/queryReportBaseInfo.do"
//首次检查报告

#define kInsertComCheckModel @"reportAction/insertComCheckModel.do"
//例行检查

#define kInsertRepayCheckModel @"reportAction/insertRepayCheckModel.do"
//还款检查

#define kInsertAllCheckModel @"reportAction/insertAllCheckModel.do"
//全面检查

#define kInsertCollectionCheckModel @"reportAction/insertCollectionCheckModel.do"
// 现场催收检查信息

#define kInsertPersonalIndexModel @"reportAction/insertPersonalIndexModel.do"
//个人商务贷款首次跟踪检查模板

#define kInsertPersonalComModel @"reportAction/insertPersonalComModel.do"
//个人商务贷款日常检查模板

#define kInsertPersonalRepayModel @"reportAction/insertPersonalRepayModel.do"
//个人商务贷款客户还款资金落实情况检查模板

#define kInsertPersonalCollectionModel @"reportAction/insertPersonalCollectionModel.do"
//个人商务贷款现场催收模板

#define kInsertCarIndexModel @"reportAction/insertCarIndexModel.do"
//个人经营性车辆按揭贷款首次检查模板

#define kInsertCarComModel @"reportAction/insertCarComModel.do"
//个人经营性车辆按揭贷款日常及逾期检查模板

#define kQueryPersonalBaseInfo @"reportAction/queryPersonalBaseInfo.do"
//取得模版基本信息(个人商务)

#define kQueryCarBaseInfo @"reportAction/queryCarBaseInfo.do"
//取得模版基本信息(车辆)

#define kfindGetParperInfo @"customerAction/getDueNum.do"
//取得模版借据编号
//#define kfindGetParperInfo @"customerAction/getDueNum.do"
////取得模版借据编号
//#define kfindGetParperInfo @"customerAction/getDueNum.do"
////取得模版借据编号

#endif
