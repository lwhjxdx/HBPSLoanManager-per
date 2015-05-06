//
//  DBManager.h
//  DB
//
//  Created by  YM on 14-8-25.
//  Copyright (c) 2014年  YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBReportModel.h"
//封装数据管理类，用于操作数据

@interface DBManager : NSObject
//开发中一般，暴露一个类方法，来使其他对象通过此方法获取到单例
+ (DBManager *)shareManager;
//插入一条数据
- (BOOL)insertDataWithModel:(HBReportModel *)model;
//根据id来删除一条数据
- (void)deleteDataWithReportId:(NSInteger)reportId;


//获取全部数据
- (NSArray *)fetchAllUsers;

-(BOOL)isDataExistsWithReportId:(NSInteger)reportId;



- (BOOL)updateWithModel:(HBReportModel *)model;

//根据model来删除一条数据
- (void)deleteDataWithModel:(HBReportModel *)model;

//根据isSelect来删除数据
- (void)deleteAllDataWithSelected;



//查询所有Select状态的数据
- (NSArray *)fetchAllSelect;

//根据检查类型 客户名称 获取报告信息
- (HBReportModel *)selectInfo:(NSString *)userName withType:(NSInteger)type;

@end
