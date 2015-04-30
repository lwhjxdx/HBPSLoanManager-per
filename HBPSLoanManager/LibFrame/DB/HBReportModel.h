//
//  HBReportModel.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/14.
//  Copyright (c) 2015年 YM. All rights reserved.
//




#import <Foundation/Foundation.h>

/*
 *  草稿箱思路
 *
 *  将需要存储的信息转化为字典 字典转化为文件 记录文件路径
 *
 *  点击草稿箱 找到相应的文件路径，解析出字典信息，还原到模板界面
 *
 *  不需要创建5个Model进行数据库的分别存储
 *
 */


//报告草稿箱
@interface HBReportModel : NSObject

@property (nonatomic,assign) NSInteger reportId;
@property (nonatomic,assign) NSInteger reportType;
@property (nonatomic,copy) NSString *titleString;
@property (nonatomic,copy) NSString *contentString;
@property (nonatomic,copy) NSString *isSelect;
//存储的文件地址
@property (nonatomic,copy) NSString *filePath;

@end
