//
//  HBPersonageCarPlanController.m
//  HBPSLoanManager
//
//  Created by QC on 15-4-23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPersonageCarPlanController.h"
#import "HBCompanyInfoViewController.h"
@interface HBPersonageCarPlanController ()
{
    NSMutableArray *_dataArray;
    NSString *_searchString;
}
@end

@implementation HBPersonageCarPlanController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"个人经营性车辆按揭贷款";
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
        
    } failBlock:nil];
    
    
}

//配置参数 查询企业信息
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (_searchString) {
        [dic setObject:_searchString forKey:@"enterpriseName"];
    }
    [dic setObject:@"3" forKey:@"productType"];
    
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
    if (jsonDic[@"customInfos"]) {
        _dataArray = [NSMutableArray arrayWithArray: jsonDic[@"customInfos"]];
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
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    cell.textLabel.text = _dataArray[indexPath.section][@"cusName"];
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
    vc.planType = PlanTypeGerenchedai;
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
