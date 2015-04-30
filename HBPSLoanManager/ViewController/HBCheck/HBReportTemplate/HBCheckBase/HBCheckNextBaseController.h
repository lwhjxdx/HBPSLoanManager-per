//
//  HBCheckNextBaseController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/31.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckBaseViewController.h"
#import "HBDraftSevice.h"

#define kNextStepCellHigh 85
#define kTextFieldHigh 40
@interface HBCheckNextBaseController : HBCheckBaseViewController
{
    NSMutableArray *cellArray;
    NSArray *_infoArray;
    NSMutableArray *viewArray;
    NSArray *_textLengthArray;
    UIButton *saveBtn;
    UIButton *upDataBtn;
    NSArray *valueArrays;
    
    HBDraftSevice *_draftSevice;
}


@property (nonatomic,copy) GetBackData getbackData;

//检查类型
@property (nonatomic,assign) HBDraftType checkType;

//请求的地址
@property (nonatomic,copy) NSString *requestUrl;

//刷新视图
- (void)refreshView:(NSMutableDictionary *)dic;

//保存草稿箱
- (void)save;

//上传
- (void)upData;

//添加两个按钮（保存草稿箱按钮  提交按钮）
- (void)addTwoBtn;


//上传文本信息
- (void)upDataString;

//从字典中填充数据到界面
- (void)fillDataFromDic;

//设置点击返回时的
- (void)setBackEvent:(GetBackData)black;

//zip参数格式 是否正确（当相应参数的格式 不为文件路径时，判断为格式正确）
- (Boolean)isZipParamsRight;



@end
