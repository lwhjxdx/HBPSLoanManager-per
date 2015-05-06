//
//  HBRepeatListViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBRepeatListViewController.h"
#import "HBCFirstViewController.h"

#import "HBAllCheckViewController.h"
#import "HBPayBackCheckFirstViewController.h"
#import "HBRoutineFirstViewController.h"
#import "HBLocaleCollectionCheckViewController.h"
#import "HBIndividualCommercialFirstTrackingViewController.h"
#import "HBIndividualCommercialCreditDailyCheckViewController.h"
#import "HBICRepaymentConditionViewController.h"
#import "HBIndividualCommercialLocaleCollectionCheckViewContr.h"
#import "HBPVehiclesDailyMortgageFirstChecksViewController.h"
#import "HBPersonalVehiclesDailyMortgageChecksViewController.h"

@interface HBRepeatListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation HBRepeatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.titleString;
    self.backButton.hidden = NO;
    [self configData];
    [self initBaseTableView];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
}
-(void)setCheckType:(CheckType)checkType
{
    _checkType = checkType;
    switch (_checkType) {
        case CheckTypeGerenshangdai:
        {
            self.dataArray = @[@"个商首次跟踪检查",
                               @"个商贷款日常检查",
                               @"个商还款情况",
                               @"个商现场催收"];
        }
            break;
         
        case CheckTypeXiaoqiyefaren:
        {
            self.dataArray = @[@"首次检查",
                               @"例行检查",
                               @"全面检查",
                               @"还款资金落实情况检查",
                               @"现场催收"];
        }
            break;
        case ChechTypeGerenchedai:
        {
            self.dataArray = @[@"个商车辆贷款首次检查",
                               @"个商车辆贷款日常及逾期"];
        }
            break;
        default:
            break;
    }
}
- (void)configData{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellIDE";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17.f];
    }
//    for (UIView *view in [cell.contentView subviews]) {
//        [view removeFromSuperview];
//    }
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kSCREEN_WIDTH - 80, 60)];
//    [label setText:dataArray[indexPath.row]];
//    [label setFont:[UIFont systemFontOfSize:20]];
//    [label setTextAlignment:(NSTextAlignmentLeft)];
//    [label setTextColor:RGBACOLOR(57, 57, 57, 1)];
//    [cell.contentView addSubview:label];
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 60, 10, 30, 40)];
//    imageView.image = [UIImage imageNamed:@"dot"];
//    [cell.contentView addSubview:imageView];
//    cell.contentView.backgroundColor = RGBACOLOR(247, 247, 247, 1);
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger selectNum = indexPath.row;
    if (_checkType == CheckTypeGerenshangdai) {
        selectNum = indexPath.row + 5;
    }else if(_checkType == ChechTypeGerenchedai){
        selectNum = indexPath.row + 9;
    }
    switch (selectNum) {
        case 0:
        {
            //@"首次检查"
            HBCFirstViewController *vc  = [[HBCFirstViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
        case 1:
        {
            //@"例行检查"
            HBRoutineFirstViewController *vc  = [[HBRoutineFirstViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
            
        case 2:
        {
            //@"全面检查"
            HBAllCheckViewController *vc  = [[HBAllCheckViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
            
        case 3:
        {
            //@"还款资金落实情况检查"
            HBPayBackCheckFirstViewController *vc = [[HBPayBackCheckFirstViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
        case 4:
        {
            //@"现场催收"
            HBLocaleCollectionCheckViewController *vc = [[HBLocaleCollectionCheckViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
        case 5:
        {
            //@"个商首次跟踪检查"
            HBIndividualCommercialFirstTrackingViewController *vc = [[HBIndividualCommercialFirstTrackingViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
        case 6:
        {
            //@"个商贷款日常检查"
            HBIndividualCommercialCreditDailyCheckViewController *vc = [[HBIndividualCommercialCreditDailyCheckViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
        case 7:
        {
            //@"个商贷款日常检查"
            HBICRepaymentConditionViewController *vc = [[HBICRepaymentConditionViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
        case 8:
        {
            //@"个商贷款日常检查"个商车辆贷款首次检查
            HBIndividualCommercialLocaleCollectionCheckViewContr *vc = [[HBIndividualCommercialLocaleCollectionCheckViewContr alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
        case 9:
        {
            //个商车辆贷款首次检查 HBPersonalVehiclesDailyMortgageChecksViewController
            HBPVehiclesDailyMortgageFirstChecksViewController *vc = [[HBPVehiclesDailyMortgageFirstChecksViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
        case 10:
        {
            //个商车辆贷款日常及逾期
            HBPersonalVehiclesDailyMortgageChecksViewController *vc = [[HBPersonalVehiclesDailyMortgageChecksViewController alloc] init];
            vc.userDic = self.customerDic;
            [self pushViewController:vc animated:NO];
        }
            break;
            
        default:
            break;
    }
}





@end
