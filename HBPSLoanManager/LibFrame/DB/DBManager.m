//
//  DBManager.m
//  DB
//
//  Created by  YM on 14-8-25.
//  Copyright (c) 2014年  YM. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"//第三方开源库,封装了ios中sqlite3数据的操作

@implementation DBManager{
    FMDatabase *_dataBase;
}

//被static修饰，只会初始化一次， 并且会一直持有初始化的值
static DBManager *manager = nil;
+ (DBManager *)shareManager{
    if (manager == nil) {
        manager = [[DBManager alloc] init];
    }
    return manager;
}
//重写init 进行一些必要的初始化操作
- (id)init{
    self = [super init];
    if (self) {
        //拼接数据库的路径
        //NSHomeDirectory() 程序的沙盒根目录
        NSString *dbPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/report.db"];
        //创建fmdb对象，并将路径传递过去
        _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
        //open dbPath中没有数据库文件，会创建并打开数据库；有文件，则直接打开
        //[_dataBase close];
        if ([_dataBase open]) {
            //创建表 blob 二进制对象类型
            NSString *createSql = @"create table if not exists reportInfo(id integer primary key autoincrement,reportType integer,titleString varchar(256),contentString integer,isSelect varchar(20),filePath varchar(256))";
            //executeUpdate 增、删、改，创建表 的sql全用此方法
            //返回值为执行的结果 yes no
            BOOL isSuccessed  =[_dataBase executeUpdate:createSql];
            if (!isSuccessed) {
                //打印失败的信息
                NSLog(@"create error:%@",_dataBase.lastErrorMessage);
            }
        }
    }
    return self;
}




//插入一条数据
- (void)insertDataWithModel:(HBReportModel *)model{

    NSString *insertSql = @"insert into reportInfo(reportType,titleString,contentString,filePath,isSelect) values(?,?,?,?,?)";
    //executeUpdate 要求后面跟的参数必须是NSObject类型,否则会抛出EXC_BAD_ACCESS错误,fmdb会在将数据写入之前对数据进行自动转化
    BOOL isSuccessd =[_dataBase executeUpdate:insertSql,[NSNumber numberWithInteger: model.reportType],model.titleString,model.contentString,model.filePath,@"NO"];
    if (!isSuccessd) {
        NSLog(@"insert error:%@",_dataBase.lastErrorMessage);
    }
}



#pragma mark ----------------删除----------------------

//根据id来删除一条数据
- (void)deleteDataWithReportId:(NSInteger)reportId{
    NSString *deleteSql = @"delete from reportInfo where id = ?";
    BOOL isSuccessed =[_dataBase executeUpdate:deleteSql,[NSNumber numberWithInteger:reportId]];
    if (!isSuccessed) {
        NSLog(@"delete error:%@",_dataBase.lastErrorMessage);
    }
}


//根据model来删除一条数据
- (void)deleteDataWithModel:(HBReportModel *)model{
    NSString *deleteSql = @"delete from reportInfo where id = ?";
    BOOL isSuccessed =[_dataBase executeUpdate:deleteSql,[NSNumber numberWithInteger:model.reportId]];
    if (!isSuccessed) {
        NSLog(@"delete error:%@",_dataBase.lastErrorMessage);
    }
}

//根据isSelect来删除一条数据
- (void)deleteAllDataWithSelected{
    NSString *deleteSql = @"delete from reportInfo where isSelect =YES";
    BOOL isSuccessed =[_dataBase executeUpdate:deleteSql];
    if (!isSuccessed) {
        NSLog(@"delete error:%@",_dataBase.lastErrorMessage);
    }
}




#pragma mark ----------------更新----------------------

//根据id更新数据
- (void)updateWithModel:(HBReportModel *)model{
    
    NSString *updateSql = @"update reportInfo set titleString=?,contentString=?,filePath=?,isSelect=? where id=?";
    BOOL isSuccessed =[_dataBase executeUpdate:updateSql withArgumentsInArray:@[model.titleString,model.contentString,model.filePath,model.isSelect,[NSNumber numberWithInteger: model.reportId]]];

    if (!isSuccessed) {
        NSLog(@"update error:%@",_dataBase.lastErrorMessage);
    }
}



#pragma mark --------------查询----------------------
//获取全部数据
- (NSArray *)fetchAllUsers{
    NSString *seleteSql = @"select * from reportInfo";
    //查询的sql语句用executeQuery
    //FMResultSet 查询结果的集合类
    FMResultSet *set =[_dataBase executeQuery:seleteSql];
    //next 从第一条数据开始，一直能取到最后一条，能取到当前的数据返回YES
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        //根据字段名称，获取字段的值
        HBReportModel *model = [[HBReportModel alloc] init];
        NSInteger reportId = [set intForColumn:@"id"];
        model.reportId = reportId;
        //stringForColumn 获取字符串的值
        NSString *titleString = [set stringForColumn:@"titleString"];
        model.titleString = titleString;
        model.contentString = [set stringForColumn:@"contentString"];
        model.filePath = [set stringForColumn:@"filePath"];
        model.reportType = [set intForColumn:@"reportType"];
        NSString *isSelect = [set stringForColumn:@"isSelect"];
        model.isSelect = isSelect;
        [array addObject:model];
    }
    return array;
}

//判断某条数据是否存在
-(BOOL)isDataExistsWithReportId:(NSInteger)reportId{
    NSString *selectSql  = @"select * from reportInfo where id = ?";
    FMResultSet *set = [_dataBase executeQuery:selectSql,[NSNumber numberWithInteger:reportId]];
    return [set next];
}






#pragma mark -------------业务-----------------

- (void)changOneSelectStation:(HBReportModel *)model{
    if ([model.isSelect isEqualToString:@"YES"]) {
        model.isSelect = @"NO";
    }else{
         model.isSelect = @"YES";
    }
    [self updateWithModel:model];
}




- (NSArray *)fetchAllSelect{
    NSString *seleteSql = @"select * from reportInfo where isSelect =?";
    //查询的sql语句用executeQuery
    //FMResultSet 查询结果的集合类
    FMResultSet *set =[_dataBase executeQuery:seleteSql,@"YES"];
    //next 从第一条数据开始，一直能取到最后一条，能取到当前的数据返回YES
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        //根据字段名称，获取字段的值
        HBReportModel *model = [[HBReportModel alloc] init];
        NSInteger reportId = [set intForColumn:@"id"];
        model.reportId = reportId;
        //stringForColumn 获取字符串的值
        NSString *titleString = [set stringForColumn:@"titleString"];
        model.titleString = titleString;
        model.contentString = [set stringForColumn:@"contentString"];
        model.filePath = [set stringForColumn:@"filePath"];
        model.reportType = [set intForColumn:@"reportType"];
        NSString *isSelect = [set stringForColumn:@"isSelect"];
        model.isSelect = isSelect;
        [array addObject:model];
    }
    return array;
}


//根据检查类型 客户名称 查询报告信息
- (HBReportModel *)selectInfo:(NSString *)userName withType:(NSInteger)type{
    HBReportModel *model ;
    NSString *seleteSql = @"select * from reportInfo where titleString = ?and reportType = ?";
    //查询的sql语句用executeQuery
    //FMResultSet 查询结果的集合类
    FMResultSet *set =[_dataBase executeQuery:seleteSql,userName,[NSNumber numberWithInteger:  type]];

    //next 从第一条数据开始，一直能取到最后一条，能取到当前的数据返回YES

    while ([set next]) {
        //根据字段名称，获取字段的值
        model = [[HBReportModel alloc] init];
        NSInteger reportId = [set intForColumn:@"id"];
        model.reportId = reportId;
        //stringForColumn 获取字符串的值
        NSString *titleString = [set stringForColumn:@"titleString"];
        model.titleString = titleString;
        model.contentString = [set stringForColumn:@"contentString"];
        model.filePath = [set stringForColumn:@"filePath"];
        model.reportType = [set intForColumn:@"reportType"];
        NSString *isSelect = [set stringForColumn:@"isSelect"];
        model.isSelect = isSelect;
    }
    return model;
}





@end
