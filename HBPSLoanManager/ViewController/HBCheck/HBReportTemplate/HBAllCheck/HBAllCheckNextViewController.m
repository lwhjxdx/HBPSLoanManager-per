//
//  HBAllCheckNextViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/20.
//  Copyright (c) 2015年 YM. All rights reserved.


#import "HBAllCheckNextViewController.h"
#import "HBNextStepChangeCell.h"
#import "HBCTextFeildTableViewCell.h"

@interface HBAllCheckNextViewController ()
{
    NSArray *_titleArray;
    NSArray *_itemArray1;
    NSArray *_itemArray2;
    NSArray *_itemArray3;
    NSArray *_keyArray;
}
@end

@implementation HBAllCheckNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"全面检查";
    self.checkType = allCheck;
    self.requestUrl = kInsertAllCheckModel;
    [self loadData];
    [self configUI];
    
}

- (void)loadData{
    
    _titleArray = @[
                    @"对我行检查的态度",
                    @"额度年检",
                    @"担保物年检",
                    @"是否较最近月份大幅增加(增幅超过30%)",
                    @"应收账款大幅增加",
                    @"是否有新增银行借款",
                    @"剔除季节性因素后的销售额是否有大幅下降",
                    @"现金流降幅增加",
                    @"是否与销售收入、经营收入相匹配",
                    @"营业执照、贷款卡是否如期年检",
                    
                    @"企业是否有公开的负面信息",
                    @"营业执照信息是否有变更",
                    @"企业实际控制人、主要股东及主要管理人员是否发生变更",
                    @"企业所在行业是否发生重大不利变化",
                    @"企业主营业务情况是否发生变更",
                    @"企业是否有与主业无关的扩张计划",
                    @"企业生产经营场所是否发生或即将发生变动",
                    @"企业主要原材料或货物的采购成本是否明显上升",
                    @"企业生产经营是否出现异常情况",
                    @"企业销售是否出现异常情况",
                    
                    @"企业上下游核心客户是否发生重大变更",
                    @"企业订单是否出现大幅下降",
                    @"企业生产经营是否有安全隐患",
                    @"是否建议调整额度",
                    @"抵(质)押物市场价值和变现能力是否出现不利变化",
                    @"抵(质)押物是否出现约定的需增加、置换等变动情形",
                    @"是否存在风险预警信号",
                    @"制造型企业水、电、煤气等资源消耗量是否较上年同期明显下降"];
    
    _itemArray2 = @[@"是",@"否"];
    
    _itemArray3 = @[@"配合",@"一般",@"不配合"];
    
    _keyArray = @[
                  @"checkCoop",
                  @"isQuotaCheck",
                  @"isQuarCheck",
                  @"isStockIncrease",
                  @"isReceIncrease",
                  @"hasNewLent",
                  @"isSalesDrop",
                  @"isCashDrop",
                  @"isIncomeMatch",
                  @"isYearCheck",//yearCheckInputInfo
                  @"isPublic",//publicInfo
                  @"isChange",//----1---changeInputInfo
                  @"isPersonChange",//--1--personChangeInputInfo
                  @"isWrongChange",//---wrongChangeInputInfo
                  @"isBusiChange",//----busiChangeInputInfo
                  @"isBusiRalation",//---busiRalationInputInfo
                  @"isAddrChange",//--addrChangeInputInfo
                  @"isCostRaise",//--costRaiseInputInfo
                  @"isBusiExce",//---busiExceInputInfo
                  @"isSellExce",//----sellExceInputInfo
                  @"isCustChange",//custChangeInputInfo
                  @"isOrderDecl",//orderDeclInputInfo
                  @"isSafe",//safeInputInfo
                  @"isLimitAdjust",//adjustLimit
                  @"isErrorChange",//errorChangeInputInfo
                  @"isGuarChange",//guarChangeInputInfo
                  @"isRiskFlag",//riskInputInfo
                  @"isResoDecl", //---resoDeclInputInfo
];
    _infoArray = @[
                   @"",
                   @"",
                   @"",
                   @"isStockReason",
                   @"isReceReason",
                   @"hasNewReason",
                   @"isSalesReason",
                   @"isCashReason",
                   @"isIncomeReason",
                   @"yearCheckInputInfo",
                   @"publicInfo",
                   @"changeInputInfo",
                   @"personChangeInputInfo",
                   @"wrongChangeInputInfo",
                   @"busiChangeInputInfo",
                   @"busiRalationInputInfo",
                   @"addrChangeInputInfo",
                   @"costRaiseInputInfo",
                   @"busiExceInputInfo",
                   @"sellExceInputInfo",
                   @"custChangeInputInfo",
                   @"orderDeclInputInfo",
                   @"safeInputInfo",
                   @"adjustLimit",
                   @"errorChangeInputInfo",
                   @"guarChangeInputInfo",
                   @"riskInputInfo",
                   @""
                   ];
    

    _textLengthArray = @[[NSNumber numberWithInteger:1],
                         [NSNumber numberWithInteger:1],
                         [NSNumber numberWithInteger:1],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         [NSNumber numberWithInteger:500],
                         ];
    viewArray = [NSMutableArray array];
    cellArray = [NSMutableArray array];
    valueArrays = @[@"licenseImageFile",
                    @"orgaImageFile",
                    @"surfaceImageFile",
                    @"addressImageFile",
                    @"productImageFile",
                    @"detailImageFile",
                    @"salesImageFile",
                    @"bankSeqImageFile",
                    @"financialImageFile",
                    @"dueImageFile"
                    ];
}

- (void)configUI{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTopBarHeight)];
    centPoint = scrollView.center;
    
    for (int i = 0; i<_titleArray.count; i++) {
        HBNextStepChangeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBNextStepChangeCell" owner:nil options:nil] lastObject];
        cell.frame = CGRectMake(0, i*kNextStepCellHigh, kSCREEN_WIDTH, kNextStepCellHigh);
        cell.index = i;
        cell.keyString = _keyArray[i];
        cell.needAdd = 0;

        if(i != 0){
            [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
        }
        else{
            [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray3];
        }
        [cell setSelectIndex:1];
        
    
        
        if([cell.keyString isEqualToString:@"isYearCheck"]){
            cell.needAdd = 1;
            [cell setSelectIndex:0];
        }else  if([cell.keyString isEqualToString:@"isIncomeMatch"]){
            cell.needAdd = 1;
            [cell setSelectIndex:0];
        }
        
        
        cell.vc = self;
        [cellArray addObject:cell];
        [viewArray addObject:cell];
        [scrollView addSubview:cell];
    }
    CGFloat scorllHigh = kNextStepCellHigh * 2;
    for (UIView *view in viewArray) {
        scorllHigh += view.frame.size.height;
    }
    scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, scorllHigh);
    [self addSupportText];
    [self addTwoBtn];
    [self.view addSubview:scrollView];
    [self getScrollClicked];
}

- (void)addSupportText{
    HBCTextFeildTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBCTextFeildTableViewCell" owner:nil options:nil] lastObject];
    cell.frame = CGRectMake(0,cellArray.count*kNextStepCellHigh, kSCREEN_WIDTH, kTextFieldHigh);
    cell.keyString = @"resoDeclInputInfo";
    [cell setTextLength:[NSNumber numberWithInteger:3000]];
    cell.infoTextField.placeholder = @"是否较最近月份大幅增加(增幅超过30%)";
    [viewArray addObject:cell];
    [scrollView addSubview:cell];
}



//处理特殊字段
- (void)handleSpecial{
}


@end
