//
//  HBDraftBoxViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/14.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBDraftBoxViewController.h"
#import "HBDraftBoxTableViewCell.h"
#import "DBManager.h"
#import "HBDraftSevice.h"
#import "HBCFirstViewController.h"
#import "HBRoutineFirstViewController.h"
#import "HBAllCheckViewController.h"
#import  "HBPayBackCheckFirstViewController.h"
#import "HBLocaleCollectionCheckViewController.h"
#import "HBPVDailyMortgageFirstChecksNextViewController.h"
#import "HBPersonalVehiclesDailyMortgageChecksViewController.h"
#import "HBIndividualCommercialLocaleCollectionCheckViewContr.h"
#import "HBICRepaymentConditionViewController.h"
#import "HBIndividualCommercialCreditDailyCheckViewController.h"
#import "HBIndividualCommercialFirstTrackingViewController.h"

@interface HBDraftBoxViewController ()<HBDraftBoxCellDelegate>
{
    NSString *_searchString;
    NSArray *_dataArray;
    HBDraftSevice *sevice;
    HBReportModel *tempDelModel;
}
@end

@implementation HBDraftBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"草稿箱";
    [self loadData];
    sevice = [[HBDraftSevice alloc] init];
    [sevice changeALLSelectStation:@"NO"];
    [self configUI];
}


- (void)configUI{
    [self initSearchView:@"请输入公司" SearchClicked:^(NSString *searchString) {
        _searchString = searchString;
        
    }];
    
    [self initTableViewForResult:CGRectMake(0,kTopBarHeight + kSearchBarHigh ,kSCREEN_WIDTH ,kSCREEN_HEIGHT - kTopBarHeight - 40 - kSearchBarHigh)];
    [self initBottomView];
    
}





- (void)initBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT - 40, kSCREEN_WIDTH, 40)];
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setFrame:CGRectMake(kSCREEN_WIDTH/2, 5, kSCREEN_WIDTH/4 - kSCREEN_WIDTH/12 , 30)];
    [delBtn addTarget:self action:@selector(delReportClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [delBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    [delBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    delBtn.center = CGPointMake(kSCREEN_WIDTH / 2, delBtn.center.y);
    delBtn.layer.cornerRadius = 3;
    delBtn.layer.masksToBounds = YES;
    delBtn.layer.borderColor = [UIColor blackColor].CGColor;
    delBtn.layer.borderWidth = 1;
    
    [bottomView  addSubview:delBtn];
    
    
//    UIButton *updataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [updataBtn setFrame:CGRectMake( kSCREEN_WIDTH*3/4 , 5,kSCREEN_WIDTH/4 - kSCREEN_WIDTH/12, 30)];
//    [updataBtn addTarget:self action:@selector(uploadReportClicked) forControlEvents:(UIControlEventTouchUpInside)];
//    [updataBtn setTitle:@"上传" forState:(UIControlStateNormal)];
//    [updataBtn setTitleColor:RGBACOLOR(244, 160, 112, 1) forState:(UIControlStateNormal)];
//    updataBtn.layer.cornerRadius = 3;
//    updataBtn.layer.masksToBounds = YES;
//    updataBtn.layer.borderColor = RGBACOLOR(244, 160, 112, 1).CGColor;
//    updataBtn.layer.borderWidth = 1;
//    
//    
//    [bottomView  addSubview:updataBtn];
    bottomView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self.view addSubview:bottomView];
    
}


//上传
- (void)uploadReportClicked{
    
}


- (void)okDel{
    [sevice deleteAllSeleteItem];
    [self loadData];
    [self reloadTableView];
}


- (void)loadData{
    
    _dataArray = [[DBManager shareManager] fetchAllUsers];
}
#pragma mark - tableViewDatasouse&&delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBDraftBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDE"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HBDraftBoxTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    HBReportModel *model = _dataArray[indexPath.row];
    [cell configerCellWithData:model];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return  YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        tempDelModel = [_dataArray objectAtIndex:indexPath.row];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认删除" message:@"是否确认该检查计划" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 100012;
        [alert show];
        
            }
}

- (void)reloadTableView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HBReportModel *model = [_dataArray objectAtIndex:indexPath.row];
    NSDictionary *dic = [sevice getDataFromDraft:model];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
//    HBDraftType type = model.reportType;
    
    
#warning  根据不同的HBDraftType 跳转不同的 报告模板
    HBCheckFirstBaseController *vc ;
    /**
     所有 通过草稿箱跳转的模板 都应该 写成如下方式
        case firstCheck:
            {
                vc = [[HBCFirstViewController alloc] init];
            }
                break;
     */
    vc = [[NSClassFromString(model.className) alloc] init];
//    if (!vc) switch (type) {
//        case firstCheck:
//        {
//            vc = [[HBCFirstViewController alloc] init];
//        }
//            break;
//        case routeCheck:
//        {
//            vc = [[HBRoutineFirstViewController alloc] init];
//        }
//            break;
//        case allCheck:
//        {
//            vc = [[HBAllCheckViewController alloc] init];
//        }
//            break;
//        case payBackCheck:
//        {
//            vc = [[HBPayBackCheckFirstViewController alloc] init];
//        }
//            break;
//            
//        case localeCollectionCheck:{
//            vc = [[HBLocaleCollectionCheckViewController alloc] init];
//        }
//            break;
/////**
//// pVDailyMortgageFirstChecks,//个商车辆贷款首次检查
//// personalVehiclesDailyMortgageChecks,//    个商车辆贷款日常及逾期
//// individualCommercialLocaleCollect,//    个商现场催收
//// iCRepaymentCondition,//    个商还款情况
//// individualCommercialCreditDailyCheck,//个商贷款日常检查
//// 
//// 
//// */
////           case individualCommercialFirstTracking:
////        {
////            
////        }
////            break;
////        case pVDailyMortgageFirstChecks:{
////            vc = [[HBIndividualCommercialFirstTrackingViewController alloc] init];
////        }
////        case personalVehiclesDailyMortgageChecks:{
////            vc = [[HBPersonalVehiclesDailyMortgageChecksViewController alloc] init];
////        }
////        case individualCommercialLocaleCollect:{
////            vc = [[HBIndividualCommercialLocaleCollectionCheckViewContr alloc] init];
////        }
////        case iCRepaymentCondition:{
////            vc = [[HBICRepaymentConditionViewController alloc] init];
////        }
////        case individualCommercialCreditDailyCheck:{
////            vc = [[HBIndividualCommercialCreditDailyCheckViewController alloc] init];
////        }
//
//        default:
//            break;
//    }
    vc.userDic = dataDic;
    [self pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (void)cellChangeClicked:(NSDictionary *)dic{
    [self loadData];
    [self reloadTableView];
}
#pragma mark - 界面布局
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:YES];
}

- (void)backBtnEvents:(id)sender{

    [sevice changeALLSelectStation:@"NO"];
    [super backBtnEvents:sender];
}

//删除选中
- (void)delReportClicked{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认删除" message:@"是否确认删除选中的的检查计划" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
#pragma mark - alertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1) {
        if (alertView.tag == 100012) {
            [sevice deleteModel:tempDelModel];
            [self loadData];
            [self reloadTableView];
        }else{
            [self okDel];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
