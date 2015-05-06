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
    UITableView *_tableView;
    NSArray *lableStringArray1;
    NSArray *lableStringArray2;
    NSArray *lableStringArray3;
    NSArray *valueArray1;
    NSArray *valueArray2;
    NSArray *conNoList;
    NSString *conNoString;
    BOOL isShow;
}
@end

@implementation HBCompanyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initTableView];
    self.titleLabel.text = @"企业用户检查计划";
    isShow = NO;
    self.backButton.hidden = NO;


}

- (void)loadData{
    lableStringArray1 = @[@"客户编号",
                          @"企业名称",
                          @"合同编号",
                          @"法人代表",
                          ];
     conNoList = [self.customerDic[@"conNo"] componentsSeparatedByString:@","];;
    conNoString = conNoList[0]?conNoList[0]:@"";
#warning 点击企业检查上海后报错：试图插入空对象
    valueArray1 = @[ self.customerDic[@"custId"],
                     self.customerDic[@"enterpriseName"],
                     conNoList[0]?conNoList[0]:@"",
                     self.customerDic[@"legalPerson"]];
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
    valueArray2 = @[self.customerDic[@"danger"],
                    self.customerDic[@"mainBiz"],
                    self.customerDic[@"legalPersonTel"],
                    self.customerDic[@"enterpriseLink"],
                    self.customerDic[@"linkManTel"],
                    self.customerDic[@"enterpriseAddr"],
                    self.customerDic[@"collateral"],
                    self.customerDic[@"cusInfo"],
                    self.customerDic[@"custId"],
                    ];
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kTopBarHeight ,kSCREEN_WIDTH ,kSCREEN_HEIGHT - kTopBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGBACOLOR(238, 238, 238, 1);

    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    if (DSystemVersion >= 7.0)
        //分割线的位置不带偏移
        _tableView.separatorInset = UIEdgeInsetsZero;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    if (indexPath.section!=2) {
        
        
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
        if (indexPath.section == 0) {
            cell.textLabel.text = lableStringArray1[indexPath.row];
            if (indexPath.row == 2) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\t\t",valueArray1[indexPath.row]];
                
                UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 30, cell.frame.size.height/2 - 10, 25, 20)];
                view.image = [UIImage imageNamed:@"dot3"];
                [cell.contentView addSubview:view];
            }else{
                cell.detailTextLabel.text = valueArray1[indexPath.row];
            }
        }else{
            cell.textLabel.text = lableStringArray2[indexPath.row];
            cell.detailTextLabel.text = valueArray2[indexPath.row];
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
        [dict setObject:self.customerDic[@"custId"]  forKey:@"custId"];
        
        [dict setObject:conNoString forKey:@"conNo"];
    }else{
        [dict setObject:@"007"  forKey:@"custId"];
        [dict setObject:@"88888" forKey:@"conNo"];
    }
    

    [HBRequest RequestDataJointStr:kQueryReportBaseInfo parameterDic:dict successfulBlock:^(NSDictionary *receiveJSON) {
        NSLog(@"------receiveJSON------");
        [self cellClicked: [self handleDataToJump:receiveJSON withDic:dic]];
        
    } failBlock:^(NSError *error) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 35;
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return lableStringArray1.count;

    }else if(section == 1){
        if (isShow) {
            return lableStringArray2.count;
        }

    }else if(section == 2){
        return lableStringArray3.count;
            }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view;
    if (section == 0) {
        view = nil;
    }else if (section == 1){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2-11, 0, 22, 20)];
        [button addTarget:self action:@selector(showInfo:) forControlEvents:(UIControlEventTouchUpInside)];
        if (isShow) {
            [button setImage:[UIImage imageNamed:@"showinfo"] forState:(UIControlStateNormal)];
        }else{
            [button setImage:[UIImage imageNamed:@"hideInfo"] forState:(UIControlStateNormal)];
        }
        view.backgroundColor = [UIColor grayColor];
        [view addSubview:button];
    }else if(section == 2){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];

        NSArray *title2Array = @[@"检查类型",@"开始日期",@"结束日期"];

        for (int i = 0; i < title2Array.count; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*kSCREEN_WIDTH/4, 0, kSCREEN_WIDTH/4, 30)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setText:title2Array[i]];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:13]];
            [view addSubview:label];
        }
        [view setBackgroundColor:RGBACOLOR(0, 88, 64, 1)];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 20;
    }else if(section == 2){
        return 30;
    }
    return 0;
}

- (void)showInfo:(UIButton *)btn{
    isShow = !isShow;
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 2 &&indexPath.section == 0) {
        //合同编号
        MyCustomPickerView *pick = [[MyCustomPickerView alloc] initWithFrame:CGRectZero];
        pick.contentArray =  [NSMutableArray arrayWithArray:conNoList];
        [pick pickerDataWithCancelBtnBlock:^(UIButton *btn) {
            
        } withDoneBtnBlock:^(NSInteger index, id receiveData) {
            cell.detailTextLabel.text = receiveData;
            conNoString = conNoList[index];
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
        [dic setObject:self.customerDic[@"custId"] forKey:@"custId"];

    }else{
        [dic setObject:@"161" forKey:@"userNo"];
    }
    
    return dic;
}

- (void)requestFromNetWorking{
    NSMutableDictionary *dic = [self makeParams];
    [HBRequest RequestDataJointStr:kGetCheckPlanList parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self handleData:receiveJSON];
    } failBlock:^(NSError *error) {
        
    }];
}

- (void)handleData:(NSDictionary *)dic{
    if (dic[@"checkPlanList"]) {
        lableStringArray3 = dic[@"checkPlanList"];
    }else{
        lableStringArray3 = [NSArray array];
    }
    [_tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self requestFromNetWorking];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
