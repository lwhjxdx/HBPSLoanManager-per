//
//  HBCompanyPlanViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/10.
//  Copyright (c) 2015年 YM. All rights reserved.
//  企业客户检查计划

#import "HBCompanyPlanViewController.h"
#import "HBCompanyInfoViewController.h"
@interface HBCompanyPlanViewController ()
{
    NSMutableArray *_dataArray;
    NSString *_searchString;
}
@end

@implementation HBCompanyPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"小企业法人授信业务";
    [self configUI];
}

- (void)configUI{
    [self initSearchView:@"请输入搜索关键字" SearchClicked:^(NSString *searchString) {
        _searchString = searchString;
        [self requestFromNetWorking];
    }];
    [self initTableViewForResult:CGRectMake(0,kValueTopBarHeight + kSearchBarHigh ,kSCREEN_WIDTH ,kSCREEN_HEIGHT - kValueTopBarHeight - kSearchBarHigh)];

    
}

//从网络请求数据 查询企业信息
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

//配置参数 查询企业信息
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (_searchString) {
        [dic setObject:_searchString forKey:@"enterpriseName"];
    }
    [dic setObject:@"1" forKey:@"productType"];
    [dic setObject:[HBUserModel getUserId] forKey:@"userNo"];
    
    [dic setObject:[HBUserModel getRoleName] forKey:@"roleName"];
    [dic setObject:[HBUserModel getUserInstitution] forKey:@"userInstitution"];
    return dic;
}

//处理数据 查询企业信息
- (void)handleData:(NSDictionary *)jsonDic{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    if (jsonDic[@"custList"]) {
        _dataArray = [NSMutableArray arrayWithArray: jsonDic[@"custList"]];
    }else{
        [_dataArray removeAllObjects];
    }
    [self.tableView reloadData];
}

#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDE"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"IDE"];
    }
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    
//    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 40, 15, 20, 30)];
//    arrowImageView.image = [UIImage imageNamed:@"dot"];
    cell.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    cell.textLabel.text = _dataArray[indexPath.section][@"enterpriseName"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HBCompanyInfoViewController *vc = [[HBCompanyInfoViewController alloc] init];
    vc.customerDic = _dataArray[indexPath.section];
    vc.planType = PlanTypeXiaoqiyefaren;
    [self pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:YES];
}



@end
