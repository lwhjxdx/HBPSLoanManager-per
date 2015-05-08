//
//  HBCompanyInfoViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/10.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCompanyInfoViewController.h"
#import "HBPlanComInfoCell.h"
#import "MyCustomPickerView.h"

#import "HBCFirstViewController.h"
#import "HBRoutineFirstViewController.h"
#import "HBAllCheckViewController.h"
#import "HBPayBackCheckFirstViewController.h"


@interface HBCompanyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
//    UITableView *_tableView;
    NSArray *lableStringArray1;
    NSArray *lableStringArray2;
    NSMutableArray *lableStringArray3;
    NSArray *valueArray1;
    NSArray *valueArray2;
    NSArray *conNoList;
    NSArray *receiptNoList;
    NSString *conNoString;
    NSString *receiptNoString;
    BOOL isShow;
}
@end

@implementation HBCompanyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hasMoreData = NO;
    [self loadData];
//    [self initTableView];
    self.titleLabel.text = @"企业用户检查计划";
    isShow = NO;
    self.backButton.hidden = NO;


}

- (void)loadData{
    lableStringArray1 = @[@"客户编号",
                          @"企业名称",
                          @"合同编号",
                          @"借据编号",
                          @"法人代表",
                          @"近期检查反应的风险点",
                          @"企业主营业务",
                          @"法人代表人联系电话",
                          @"企业联系人",
                          @"企业联系人联系电话",
                          @"企业经营地址",
                          @"抵（质）押物具体信息",
                          @"银行借款情况"
                          ];
     conNoList = [self.customerDic[@"conNo"] componentsSeparatedByString:@","];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:conNoList];
    [tempArr insertObject:@"全部" atIndex:0];
    conNoList = tempArr;
    receiptNoList = @[@"全部"];
    
//    conNoString = conNoList[0]?conNoList[0]:@"";
#warning 点击企业检查上海后报错：试图插入空对象
    valueArray1 = @[ self.customerDic[@"cusId"],
                     self.customerDic[@"enterpriseName"],
                     conNoList[0],
                     receiptNoList[0],
                     self.customerDic[@"legalPerson"]
                     ,self.customerDic[@"enterpriseLink"],
                     self.customerDic[@"enterpriseName"],
                     self.customerDic[@"legalPersonTel"],
                     self.customerDic[@"enterpriseLink"],
                     self.customerDic[@"linkManTel"],
                     self.customerDic[@"enterpriseAddr"],
                     self.customerDic[@"collateral"],
                     self.customerDic[@"cusInfo"],
                     self.customerDic[@"cusId"]
                     ];
    
    /**
     *  custNo;//客户编号
     enterpriseAddr;//企业经营地址
      legalPerson;//法人代表人
      legalPersonTel;//法人代表人联系电话
      enterpriseLink;//企业联系人
      linkManTel;//企业联系人联系电话
      collateral;//抵（质）押物具体信息
      danger;//近期检查反映的风险点
      cusInfo;//银行借款情况
      prevCheck;//上次检查时间
      mainBiz;//企业主营业务
     */
    lableStringArray2 = @[@"近期检查反应的风险点",
                          @"企业主营业务",
                          @"法人代表人联系电话",
                          @"企业联系人",
                          @"企业联系人联系电话",
                          @"企业经营地址",
                          @"抵（质）押物具体信息",
                          @"银行借款情况",
                          ];
    valueArray2 = @[self.customerDic[@"enterpriseLink"],
                    self.customerDic[@"enterpriseName"],
                    self.customerDic[@"legalPersonTel"],
                    self.customerDic[@"enterpriseLink"],
                    self.customerDic[@"linkManTel"],
                    self.customerDic[@"enterpriseAddr"],
                    self.customerDic[@"collateral"],
                    self.customerDic[@"cusInfo"],
                    self.customerDic[@"cusId"],
                    ];
}
-(void)gettingReceiptNoList:(NSString*)conNo
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"conNo":conNo}];
    [HBRequest RequestDataJointStr:@"customerAction/getDueNum.do" parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        
    } failBlock:^(NSError *error) {
        
    }];
}
#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView != self.topTableView) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 35;
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.topTableView) {
        return lableStringArray1.count;
    }else{
        if (lableStringArray3) {
            return lableStringArray3.count;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    if (tableView == self.topTableView) {
        
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"IDE"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"IDE"];
        }
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        cell.contentView.backgroundColor = RGBACOLOR(247, 247, 247, 1);
        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:13]];
        [cell.detailTextLabel setTextColor:[UIColor grayColor]];
        
        
        for (UIView *view in [cell.contentView subviews]) {
            [view removeFromSuperview];
        }
        cell.textLabel.text = lableStringArray1[indexPath.row];
        if (indexPath.row == 2||indexPath.row == 3) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\t\t",valueArray1[indexPath.row]];
            
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 30, cell.frame.size.height/2 - 10, 25, 20)];
            view.image = [UIImage imageNamed:@"dot3"];
            [cell.contentView addSubview:view];
        }else{
            cell.detailTextLabel.text = valueArray1[indexPath.row];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"IDE1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HBPlanComInfoCell" owner:self options:nil] lastObject];
        }
        [((HBPlanComInfoCell *)cell) loadData:lableStringArray3[indexPath.row]];
        
        [((HBPlanComInfoCell *)cell) setComInfoClicked:^(NSDictionary *dic) {
            [self requestFromNetWorkingToJump:dic];
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


#pragma mark ---------------------跳转-----------------------------
//从网络请求数据
- (void)requestFromNetWorkingToJump:(NSDictionary *)dic{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (PAT_) {
        [dict setObject:self.customerDic[@"cusId"]  forKey:@"cusId"];
        
//        [dict setObject:conNoString forKey:@"conNo"];
    }else{
        [dict setObject:@"007"  forKey:@"custId"];
        [dict setObject:@"88888" forKey:@"conNo"];
    }
    

    [HBRequest RequestDataJointStr:kQueryReportBaseInfo parameterDic:dict successfulBlock:^(NSDictionary *receiveJSON) {
        NSLog(@"------receiveJSON------");
        [self.refreshControl endRefreshing];
        [self cellClicked: [self handleDataToJump:receiveJSON withDic:dic]];
        
    } failBlock:^(NSError *error) {
        [self.refreshControl endRefreshing];

        NSLog(@"=======error====");
    }];
}

////配置参数
//- (NSMutableDictionary *)markParamsToJump{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"007" forKey:@"custId"];
//    [dic setObject:@"88888" forKey:@"conNo"];
//    return dic;
//}

//处理数据
- (NSMutableDictionary *)handleDataToJump:(NSDictionary *)dic withDic:(NSDictionary *)oldDic{
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary: oldDic];
    
    for (NSString *key in [dic allKeys]) {
        [tempDic setObject:[dic objectForKey:key] forKey:key];
    }
    
   
    return tempDic;
}

- (void)cellClicked:(NSDictionary *)dic{
    NSInteger type = [dic[@"checkType"] integerValue];
    switch (type) {
        case 1:
        {
            HBCFirstViewController *vc = [[HBCFirstViewController alloc] init];
            vc.userDic = dic;
            [self pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            HBRoutineFirstViewController *vc = [[HBRoutineFirstViewController alloc] init];
            vc.userDic = dic;
            [self pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            HBAllCheckViewController *vc = [[HBAllCheckViewController alloc] init];
            vc.userDic = dic;
            [self pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            HBPayBackCheckFirstViewController *vc = [[HBPayBackCheckFirstViewController alloc] init];
            vc.userDic = dic;
            [self pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.thisTableView) {
        return;
    }
    if (indexPath.row == 2 ) {
        //合同编号
        MyCustomPickerView *pick = [[MyCustomPickerView alloc] initWithFrame:CGRectZero];
        pick.contentArray =  [NSMutableArray arrayWithArray:(indexPath.row == 2)?conNoList:receiptNoList];
        [pick pickerDataWithCancelBtnBlock:^(UIButton *btn) {
            
        } withDoneBtnBlock:^(NSInteger index, id receiveData) {
            
            conNoString = conNoList[index];
            cell.detailTextLabel.text = conNoString;
            UITableViewCell *cell2 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            receiptNoString = receiptNoList[0];
            cell2.detailTextLabel.text = receiptNoString;
            [self gettingReceiptNoList:conNoString];
            [self requestFromNetWorking];
        } withChangedEventBlock:^(NSInteger index) {
            
        }];
        [pick showInView:self.view];
    }
}

- (NSMutableDictionary *)makeParams{
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (PAT_) {
        [dic setObject:[HBUserModel getUserId] forKey:@"userNo"];
        if (conNoString) {
            [dic setObject:conNoString forKey:@"conNo"];
        }
        if (receiptNoString) {
            [dic setObject:conNoString forKey:@"conNo"];
        }
        [dic setObject:self.customerDic[@"cusId"] forKey:@"cusId"];

    }else{
        [dic setObject:@"161" forKey:@"userNo"];
    }
    [dic setObject:@(_startIndex) forKey:@"page"];
    [dic setObject:@(20) forKey:@"pageNo"];
    [dic setObject:@(0) forKey:@"checked"];
    [dic setObject:[HBUserModel getRoleName] forKey:@"roleName"];
    [dic setObject:[HBUserModel getUserInstitution] forKey:@"userInstitution"];
    return dic;
}

- (void)requestFromNetWorking{
    NSMutableDictionary *dic = [self makeParams];
    _hasMoreData = NO;
    [HBRequest RequestDataJointStr:kGetCheckPlanList parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self.refreshControl endRefreshing];
        [self handleData:receiveJSON];
    } failBlock:^(NSError *error) {
        [self.refreshControl endRefreshing];
    }];
}

- (void)handleData:(NSDictionary *)dic{
//    _hasMoreData = YES;
    if (dic[@"checkPlanList"]) {
        if (!lableStringArray3||_isLoading) {
            lableStringArray3 = [NSMutableArray arrayWithArray:dic[@"checkPlanList"]];
            _isLoading = NO;
        }else{
            [lableStringArray3 addObjectsFromArray:dic[@"checkPlanList"]];
        }
    }else{
        lableStringArray3 = [NSMutableArray array];
    }
    if (lableStringArray3.count < [dic[@"planNO"] integerValue]) {
        _hasMoreData = YES;
    }else{
        _hasMoreData = NO;
    }
    [self.thisTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self requestFromNetWorking];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
