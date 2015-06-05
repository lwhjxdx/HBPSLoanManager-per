//
//  PlanListViewController.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/6/4.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "PlanListViewController.h"
#import "HBPlanComInfoCell.h"
#import "HBType.h"
#import "HBSignInController.h"
@interface PlanListViewController ()
@property (nonatomic,assign)PlanType planType;

@end

@implementation PlanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBaseTableView];
}
//-(void)setListArray:(NSArray *)listArray
//{
//    _listArray = listArray;
//    if (self.baseTableView) {
//        [self.baseTableView reloadData];
//    }
//}
-(void)initBaseTableView
{
    self.baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    [self.view addSubview:self.baseTableView];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(44, 0, 0, 0));
    }];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *spacingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
    NSArray *titleArray = @[@"检查类型",@"开始日期",@"结束日期",@"检查方式",@"操作"];
    for (int i = 0; i < titleArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( i*(kSCREEN_WIDTH)/titleArray.count, 0, (kSCREEN_WIDTH)/titleArray.count, 20)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:titleArray[i]];
        [label setTextColor:[UIColor whiteColor]];
        label.backgroundColor = RGBACOLOR(0, 88, 64, 1);
        [label setFont:[UIFont systemFontOfSize:13]];
        [spacingView addSubview:label];
        if (i>1&&i<4) {
            label.textAlignment = NSTextAlignmentRight;
        }
    }
    spacingView.backgroundColor = KMainColor;
    return spacingView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_listArray) {
        return _listArray.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBPlanComInfoCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([HBPlanComInfoCell class])];
    
    HBPlanComInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBPlanComInfoCell class]) forIndexPath:indexPath];
    [cell loadData:_listArray[indexPath.row]];
    
    [((HBPlanComInfoCell *)cell) setComInfoClicked:^(NSDictionary *dic) {
        [self requestFromNetWorkingToJump:dic];
    }];

    return cell;
}
- (void)requestFromNetWorkingToJump:(NSDictionary *)dic{
    
    NSArray *arr = @[kInsertIndexCheckModel,kQueryPersonalBaseInfo,kQueryCarBaseInfo];
    NSString *interfaceString = arr[[dic[@"productType"] intValue] - 1];
    self.planType =[dic[@"productType"] intValue] - 1;

    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:dic[@"dueNum"] forKey:@"dueNum"];
    [tempDic setObject:dic[@"custNo"] forKey:@"custId"];
    [tempDic setObject:dic[@"conNo"] forKey:@"conNo"];
    [HBRequest RequestDataJointStr:interfaceString parameterDic:tempDic successfulBlock:^(NSDictionary *receiveJSON) {
        NSLog(@"------receiveJSON------");
        [self cellClicked:[self handleDataToJump:receiveJSON withDic:dic]];
        
    } failBlock:^(NSError *error, NSDictionary *receiveJSON) {
    }];
}
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
