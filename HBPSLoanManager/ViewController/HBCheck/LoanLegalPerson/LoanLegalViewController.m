//
//  LoanLegalViewController.m
//  HBPSLoanManager
//
//  Created by QC on 15-4-23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "LoanLegalViewController.h"
#import "HBCheckDetailViewController.h"
@interface LoanLegalViewController ()
{
    
    NSMutableArray *_dataArray;
    
    NSString *_searchString;
    
    NSDictionary *customerDic;

}
@end

@implementation LoanLegalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.backButton.hidden = NO;
    self.titleLabel.text = @"贷后检查报告";
    [self configUI];
    
}

- (void)configUI{
    [self initSearchView:@"请输入公司名称" SearchClicked:^(NSString *searchString) {
        _searchString = searchString;
        [self requestFromNetWorking];
    }];
    [self initTableViewForResult:CGRectZero];
    
}



//从网络请求数据
- (void)requestFromNetWorking{
    NSMutableDictionary *dic = [self markParams];
    if (!dic) {
        return;
    }
    
    [HBRequest RequestDataJointStr:kFindCustInfo parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self handleData:receiveJSON];
    } failBlock:^(NSError *error) {
        
    }];
    
}



//配置参数
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (_searchString) {
        [dic setObject:_searchString forKey:@"enterpriseName"];
    }
    
    [dic setObject:@"1" forKey:@"productType"];
    if (PAT_) {
        [dic setObject:[HBUserModel getUserId] forKey:@"userNo"];
    }else{
        [dic setObject:@"161" forKey:@"userNo"];
    }
    return dic;
}

//处理数据
- (void)handleData:(NSDictionary *)jsonDic{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    _dataArray = [NSMutableArray arrayWithArray: jsonDic[@"custList"]];
    [self.tableView reloadData];
}


- (void)loadData{
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        if (!PAT_) {
            return 1;
    }else{
        return _dataArray.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//_dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = @"cellIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    NSDictionary *dic = _dataArray[indexPath.section];
    cell.textLabel.text = dic[@"enterpriseName"];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:20]];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HBCheckDetailViewController *vc = [[HBCheckDetailViewController alloc] init];
    vc.customerDic = [NSMutableDictionary dictionaryWithDictionary:_dataArray[indexPath.section]];
    [self pushViewController:vc animated:YES];
}



//dueNum //借据编号
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:@"YES"];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
@end

