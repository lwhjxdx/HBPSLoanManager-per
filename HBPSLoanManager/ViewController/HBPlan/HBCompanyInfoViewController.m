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

#import "HBSignInController.h"
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
    NSString *planTypeString;
    NSString *interfaceString;
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
    [self requestFromNetWorking];
    [self.topTableView reloadData];

}
-(void)setPlanType:(PlanType)planType
{
    _planType = planType;
    interfaceString = kfindGetParperInfo;
    switch (planType) {
        case PlanTypeGerenchedai:
            interfaceString = kQueryCarBaseInfo;
            break;
        case PlanTypeGerenshangdai:
            interfaceString = kQueryPersonalBaseInfo;
            break;
        case PlanTypeXiaoqiyefaren:
            interfaceString = kInsertIndexCheckModel;
            break;
        default:
            break;
            
    }
}
- (void)loadData{
    
    
     conNoList = [self.customerDic[@"conNo"] componentsSeparatedByString:@","];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:conNoList];
    [tempArr insertObject:@"全部" atIndex:0];
    conNoList = tempArr;
    receiptNoList = @[@"全部"];
    conNoString = conNoList[0];
    receiptNoString = receiptNoList[0];
//    conNoString = conNoList[0]?conNoList[0]:@"";
#warning 点击企业检查上海后报错：试图插入空对象
    if (_planType == PlanTypeXiaoqiyefaren) {
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
    }else{
        lableStringArray1 = @[@"客户编号",
                              @"客户姓名",
                              @"合同编号",
                              @"借据编号",
                              @"证件类型",
                              @"证件号码",
                              @"客户联系电话",
                              @"额度种类",
                              @"贷款品种",
                              @"贷款用途",
                              @"授信额度",
                              @"额度余额",
                              @"放款时间",
                              @"还款方式"
                              ];
        valueArray1 = @[ self.customerDic[@"cusId"],
                         self.customerDic[@"cusName"],
                         conNoString,
                         receiptNoString,
                         @"身份证",
                         self.customerDic[@"certNo"],
                         self.customerDic[@"mobilePhone"]
                         ];
        
    }
   
    
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
//    lableStringArray2 = @[@"近期检查反应的风险点",
//                          @"企业主营业务",
//                          @"法人代表人联系电话",
//                          @"企业联系人",
//                          @"企业联系人联系电话",
//                          @"企业经营地址",
//                          @"抵（质）押物具体信息",
//                          @"银行借款情况",
//                          ];
//    valueArray2 = @[self.customerDic[@"enterpriseLink"],
//                    self.customerDic[@"enterpriseName"],
//                    self.customerDic[@"legalPersonTel"],
//                    self.customerDic[@"enterpriseLink"],
//                    self.customerDic[@"linkManTel"],
//                    self.customerDic[@"enterpriseAddr"],
//                    self.customerDic[@"collateral"],
//                    self.customerDic[@"cusInfo"],
//                    self.customerDic[@"cusId"],
//                    ];
}


-(void)gettingReceiptNoList:(NSString*)conNo
{
    if ([conNo isEqualToString:@"全部"]) {
        receiptNoList = @[@"全部"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"conNo":conNo}];
    [HBRequest RequestDataJointStr:@"customerAction/getDueNum.do" parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        NSMutableArray *tempArr =[NSMutableArray arrayWithArray: [receiveJSON[@"dueNUM"] componentsSeparatedByString:@","]];
        [tempArr insertObject:@"全部" atIndex:0];
        receiptNoList = tempArr;
    } failBlock:^(NSError *error) {

    }];
    if (_planType==PlanTypeXiaoqiyefaren) {
        return;
    }
    [HBRequest RequestDataJointStr:@"customerAction/getLoanInfo.do" parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        if (receiveJSON[@"tCustomInfo"]) {
            NSDictionary *dic = receiveJSON[@"tCustomInfo"];
            valueArray1 = @[ self.customerDic[@"cusId"],
                             self.customerDic[@"cusName"],
                             conNoString,
                             receiptNoString,
                             @"身份证",
                             self.customerDic[@"certNo"],
                             self.customerDic[@"mobilePhone"],
                             dic[@"repayType"],
                             dic[@"isNeedLimit"],
                             dic[@"appOpName"],
                             dic[@"lineAmount"],
                             dic[@"lineBalance"],
                             dic[@"loadDate"],
                             dic[@"loanPurpose"]
                             ];
            [self.topTableView reloadData];
        }

    } failBlock:^(NSError *error) {
        
    }];
}
//tableView 基础设置在基类里面设置好，子类只用复写填写数据的相关方法
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
        static NSString *cellIDE = @"IDE";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIDE];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellIDE];
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
            if (indexPath.row == 2) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\t\t",conNoString];
            }else{
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\t\t",receiptNoString];

            }
            
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 30, cell.frame.size.height/2 - 10, 25, 20)];
            view.image = [UIImage imageNamed:@"dot3"];
            [cell.contentView addSubview:view];
        }else{
            if (indexPath.row<valueArray1.count) {
                cell.detailTextLabel.text = (valueArray1[indexPath.row])?valueArray1[indexPath.row]:@"";
            }else{
                cell.detailTextLabel.text = @"";

            }
        }
    }else{
        static NSString *cellIDE1 = @"IDE123";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIDE1];
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
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
//    [dict setObject:dic[@"cusNo"] forKey:@"conNo"];
//    if (PAT_) {
//        if (![receiptNoString isEqualToString:@"全部"]) {
//            [dict setObject:receiptNoString  forKey:@"conNo"];
//        }
//        
////        [dict setObject:conNoString forKey:@"conNo"];
//    }else{
//        [dict setObject:@"007"  forKey:@"custId"];
//        [dict setObject:@"88888" forKey:@"conNo"];
//    }
//    {"data":"{\"dueNum\":\"d0001\",\"custId\":\"009\",\"conNo\":\"c0001\"}"}
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:dic[@"dueNum"] forKey:@"dueNum"];
    [tempDic setObject:self.customerDic[@"cusId"] forKey:@"custId"];
    [tempDic setObject:dic[@"conNo"] forKey:@"conNo"];
    [HBRequest RequestDataJointStr:interfaceString parameterDic:tempDic successfulBlock:^(NSDictionary *receiveJSON) {
        NSLog(@"------receiveJSON------");
        [self.refreshControl endRefreshing];
        [self cellClicked: [self handleDataToJump:receiveJSON withDic:dic]];
        
    } failBlock:^(NSError *error) {
        [self.refreshControl endRefreshing];
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

    
    


//    NSArray *tempArr = @[@"半年检查",  //  1
//                         @"首次检查",  //  2
//                         @"例行检查",  //  3
//                         @"逾期催收",  //  4
//                         @"还款落实检查",//  5
//                         @"额度年检",   //  6
//                         @"抽查",       //  7
//                         @"全面检查"];    // 8
   
    NSInteger type = [dic[@"checkType"] integerValue];
    Class className ;
/***************************小企业法人检查模板************************
    //    HBLocaleCollectionCheckViewController现场催收
    
    //    HBPayBackCheckFirstViewController还款资金落实情况检查
    
    //    HBAllCheckViewController全面检查
    
    //    HBRoutineFirstViewController例行检查
    
    //    HBCFirstViewController首次检查
 */

    
/*********************个商还款检查模板
     HBIndividualCommercialFirstTrackingViewController  个商还款情况
     
     HBIndividualCommercialCreditDailyCheckViewController   个商贷款日常检查
     
     HBICRepaymentConditionViewController   个商现场催收
     
     HBIndividualCommercialFirstTrackingViewController个商首次跟踪检查
*/
    
    
/*********************************个商车贷检查模板
     HBPersonalVehiclesDailyMortgageChecksViewController个商车辆贷款日常及逾期
     
     HBPVehiclesDailyMortgageFirstChecksViewController个商车辆贷款首次检查
*/
    switch (type) {
        case 3://例行检查
        {
            if (_planType == PlanTypeGerenshangdai) {
                className = NSClassFromString(@"HBIndividualCommercialCreditDailyCheckViewController");
            }else{
                className = NSClassFromString(@"HBRoutineFirstViewController");
            }
        }
            break;
        case 2://首次检查
        {
            if (_planType == PlanTypeGerenshangdai) {
                className = NSClassFromString(@"HBIndividualCommercialFirstTrackingViewController");
            }else if(_planType == PlanTypeXiaoqiyefaren){
                className = NSClassFromString(@"HBCFirstViewController");
            }else{
                className = NSClassFromString(@"HBPVehiclesDailyMortgageFirstChecksViewController");
            }
        }
            break;
            
        case 4://逾期催收"
        {
            if (_planType == PlanTypeGerenshangdai) {
                className = NSClassFromString(@"HBIndividualCommercialLocaleCollectionCheckViewContr");
            }else if(_planType == PlanTypeXiaoqiyefaren){
                className = NSClassFromString(@"HBLocaleCollectionCheckViewController");
            }else{
                className = NSClassFromString(@"HBPersonalVehiclesDailyMortgageChecksViewController");
            }
        }
            break;
        case 5://还款落实检查
        {
            if (_planType == PlanTypeXiaoqiyefaren) {
                className = NSClassFromString(@"HBPayBackCheckFirstViewController");
            }else{
                className = NSClassFromString(@"HBICRepaymentConditionViewController");
            }
        }
            break;
        case 8://全面检查
        {
            className = NSClassFromString(@"HBAllCheckViewController");
        }
            break;
 
            break;
        default:
            break;
    }
    if (!className) {
        if (_planType == PlanTypeGerenshangdai) {
            className = NSClassFromString(@"HBIndividualCommercialCreditDailyCheckViewController");
        }else{
            className = NSClassFromString(@"HBAllCheckViewController");
        }
    }
    [self pushHBSignInControllerWithDic:[NSMutableDictionary dictionaryWithDictionary:dic] withNextClass:className];
}

- (void)pushHBSignInControllerWithDic:(NSMutableDictionary*)dic withNextClass:(Class)class
{
    if (!class) {
        return;
    }
    HBSignInController *qiandaoVC = [[HBSignInController alloc]init];
    qiandaoVC.isShowNextItem = YES;
    qiandaoVC.classString = class;
    qiandaoVC.pushNextDic = dic;
    [self pushViewController:qiandaoVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.thisTableView) {
        return;
    }
    if (indexPath.row == 2 || indexPath.row == 3) {
        //合同编号
        MyCustomPickerView *pick = [[MyCustomPickerView alloc] initWithFrame:CGRectZero];
        pick.contentArray =  [NSMutableArray arrayWithArray:(indexPath.row == 2)?conNoList:receiptNoList];
        [pick pickerDataWithCancelBtnBlock:^(UIButton *btn) {
            
        } withDoneBtnBlock:^(NSInteger index, id receiveData) {
            if (indexPath.row==2) {
                conNoString = conNoList[index];
                cell.detailTextLabel.text = conNoString;
                UITableViewCell *cell2 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                receiptNoString = receiptNoList[0];
                cell2.detailTextLabel.text = receiptNoString;
                [self gettingReceiptNoList:conNoString];
            }else{
                receiptNoString = receiptNoList[index];
                cell.detailTextLabel.text = receiptNoString;
            }
            _startIndex = 1;
            [self requestFromNetWorking];
        } withChangedEventBlock:^(NSInteger index) {
            
        }];
        lableStringArray3 = [NSMutableArray array];
        [pick showInView:self.view];
    }
}


- (NSMutableDictionary *)makeParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (PAT_) {
        [dic setObject:[HBUserModel getUserId] forKey:@"userNo"];
        if (![conNoString isEqualToString:@"全部"]) {
            [dic setObject:conNoString forKey:@"conNo"];
        }
        if (![receiptNoString isEqualToString:@"全部"]) {
            [dic setObject:conNoString forKey:@"dueNum"];
        }
        [dic setObject:self.customerDic[@"cusId"] forKey:@"cusId"];
        
    }else{
        [dic setObject:@"161" forKey:@"userNo"];
    }
    [dic setObject:[self productType] forKey:@"productType"];
    [dic setObject:@0 forKey:@"checkPlanType"];
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
        [self.thisTableView reloadData];
    }];
}
- (NSNumber*)productType
{
    if (_planType==PlanTypeXiaoqiyefaren) {
        return @1;
    }else if(_planType == PlanTypeGerenshangdai){
        return @2;
    }else{
        return @3;
    }
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
    if (dic.count < 20) {
        _hasMoreData = NO;
    }else{
        _hasMoreData = YES;
    }
    [self.thisTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
