//
//  HBPersonPlanViewController.m
//  HBPSLoanManager
//
//  Created by QC on 15-4-23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPersonPlanViewController.h"
#import "HBCompanyInfoViewController.h"
@interface HBPersonPlanViewController ()
{
    NSMutableArray *_dataArray;
    NSString *_searchString;
}
@end

@implementation HBPersonPlanViewController

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
    self.titleLabel.text = @"个人商务贷款";
    [self configUI];
}

- (void)configUI{
    [self initSearchView:@"请输入搜索关键字" SearchClicked:^(NSString *searchString) {
        _searchString = searchString;
        [self requestFromNetWorking];
    }];
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
    [dic setObject:@"2" forKey:@"productType"];
    
    if (PAT_) {
        [dic setObject:[HBUserModel getUserId] forKey:@"userNo"];
    }else{
        [dic setObject:@"161" forKey:@"userNo"];
    }
    
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
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 40, 15, 20, 30)];
    arrowImageView.image = [UIImage imageNamed:@"dot"];
    cell.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    cell.textLabel.text = _dataArray[indexPath.section][@"cusName"];
    [cell.contentView addSubview:arrowImageView];
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
