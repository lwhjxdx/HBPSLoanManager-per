//
//  HBCheckCaledarViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckCaledarViewController.h"
#import "HBCheckCalendarCell.h"
#import "HBCheckCalenderMoreViewController.h"
@interface HBCheckCaledarViewController ()<HBCheckCalendarDelegate>
{
    NSMutableArray *dataArray;
}
@end

@implementation HBCheckCaledarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"检查日历";
    [self initBaseTableView];
    [self loadData];
  
}

- (void)loadData{
    [self requestFromNetWorking];
}


- (void)requestFromNetWorking{
    [HBRequest RequestDataJointStr:kGetCheckPlanList parameterDic:[self makeParms] successfulBlock:^(NSDictionary *receiveJSON) {
        [self handleData:receiveJSON];
    } failBlock:^(NSError *error) {
        
    }];
}

- (NSMutableDictionary *)makeParms{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (PAT_) {
        [dic setObject:[HBUserModel getUserId] forKey:@"userNo"];
    }else{
        [dic setObject:@"161" forKey:@"userNo"];

    }

    return dic;
}

- (void)handleData:(NSDictionary *)dic{
    if (dic[@"checkPlanList"]) {
        dataArray = dic[@"checkPlanList"];
    }else{
        dataArray = [NSMutableArray array];
    }
    [self.baseTableView reloadData];
}

- (void)initBaseTableView
{
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kTopBarHeight ,kSCREEN_WIDTH ,kSCREEN_HEIGHT - kTopBarHeight) style:UITableViewStyleGrouped];
    self.baseTableView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    self.baseTableView.separatorStyle =
    UITableViewCellSeparatorStyleSingleLine;
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.tableHeaderView = [[UIView alloc] init];
    self.baseTableView.tableFooterView = [[UIView alloc] init];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;

    [self.view addSubview:self.baseTableView];
    
    if (DSystemVersion >= 7.0)
        //分割线的位置不带偏移
        self.baseTableView.separatorInset = UIEdgeInsetsZero;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 247;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBCheckCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDE"];
    if (cell == nil) {
        cell =
        [[[NSBundle mainBundle] loadNibNamed:@"HBCheckCalendarCell" owner:self options:nil] lastObject];
    }
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [cell setParams:dataArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}


#pragma mark - CheckCalendarCell
- (void)hbCheckCalendarMoreClicked:(NSDictionary *)dic{
    HBCheckCalenderMoreViewController *vc = [[HBCheckCalenderMoreViewController alloc] init];
    vc.conNoString = dic[@"conNo"];
    [self pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:@"YES"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
