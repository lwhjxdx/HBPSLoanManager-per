//
//  HBAllCheckViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/20.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBAllCheckViewController.h"
#import "ReportTableViewCell.h"
#import "HBAllCheckNextViewController.h"
#import "ReportPicCell.h"
@interface HBAllCheckViewController ()
{
    NSArray *titleArray;
    NSMutableArray *cellArray;
    NSArray *titleArray1;
    NSArray *keyArray;
    NSArray *keyArray1;
    NSArray *textLengthArray;
    
   
}
@end

@implementation HBAllCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"全面检查";
    self.backButton.hidden = NO;
    [self loadData];
    [self configUI];
}

- (void)loadData{
    
    
    
    titleArray = @[@"客户编号",
                   @"客户名称",
                   @"合同编号",
                   @"授信业务种类",
                   @"贷款金额",
                   @"贷款期限",
                   @"放款日期",
                   @"经营范围",
                   @"经营地址",
                   @"法定代表人",
                   @"股东信息",
                   @"应收账款",
                   @"原材料价值",
                   @"存货价值",
                   @"银行借款",
                   @"银行账户存款",
                   @"还款方式",
                   @"贷款约定用途",
                   @"贷款支付方式",
                   @"抵押物名称",
                   @"抵押物评估价值",
                   @"评估机构",
                   @"抵押物抵押率",
                   @"抵押物地址",
                   @"担保方式",
                   @"检查地点",

                   @"存货当前余额",
                   @"上期检查（或调查）时点余额",
                   @"应收账款当前余额",
                   @"应收账款上期余额",
                   @"银行借款当前贷款余额",
                   @"银行借款上期余额",
                   @"销售情况销售额",
                   @"现金流情况",
                   @"征信报告查询日期",
                   @"当前企业及个人征信情况",
                   @"上次抵质押物评估日期",
                   @"上次抵质押物评估金额",
                   @"抵质押物目前评估价值",
                   @"企业财务情况",
                   @"抵质押物目前状况",
                   ];
    
    keyArray = @[  @"custId",//客户编号
                   @"custName",//客户名称
                   @"conNo",//合同编号
                   @"creditProductCd",//授信业务种类
                   @"loadAmt",//贷款金额
                   @"endDate",//贷款期限
                   @"startDate",//放款日期
                   @"busiScope",//经营范围
                   @"operationAddress",//经营地址
                   @"legalPerson",//法定代表人
                   @"shareholderInfo",//股东信息
                   @"accountReceive",//应收账款
                   @"materialsValue",//原材料价值
                   @"stockValue",//存货价值 00
                   @"bankLoadAmt",//银行借款 00
                   @"bankDeposit",//银行账户存款
                   @"repayType",//还款方式
                   @"loanPurpose",//贷款约定用途
                   @"payMethod",//贷款支付方式
                   @"assetName",//抵押物质名称
                   @"affirmValue",//
                   @"evaMechanism",//
                   @"bondedRate",//
                   @"address",//
                   @"guarPay",//
                   @"checkAddress",//

                   @"stockBalance",//
                   @"stockPrevBalance",//
                   @"receBalance",//
                   @"isRecePrevBalance",//
                   @"lentBalance",//
                   @"lentPrevBalance",//
                   @"sales",//
                   @"cash",//
                   @"queryDate",//
                   @"creditInvest",//
                   @"evaluateDate",//
                   @"evaluateMon",//
                   @"evaluateValue",//
                   @"finace",//
                   @"nowState"//
                                      ];
    
    textLengthArray = @[[NSNumber numberWithInteger:30],
                        [NSNumber numberWithInteger:100],
                        [NSNumber numberWithInteger:30],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:8],
                        [NSNumber numberWithInteger:100],
                        [NSNumber numberWithInteger:500],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:10],
                        [NSNumber numberWithInteger:10],
                        [NSNumber numberWithInteger:30],
                        [NSNumber numberWithInteger:100],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:500],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:500],
                        [NSNumber numberWithInteger:30],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:8],
                        [NSNumber numberWithInteger:2000],
                        [NSNumber numberWithInteger:8],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:2000],
                        [NSNumber numberWithInteger:2],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:200],
                        [NSNumber numberWithInteger:1]
                        
                        ];
    
    titleArray1 = @[@"企业营业执照",
                    @"组织机构代码证",
                    @"生产经营场所外观",
                    @"企业经营场地或生产车间",
                    @"原材料、库存成品或半成品",
                    @"存货明细清单",
                    @"销售出入库单/销售合同/发票",
                    @"近两个月银行账户流水/会计凭证",
                    @"财务系统截屏/纳税申报表",
                    @"应收款明细"];
           
    
    keyArray1 = @[@"licenseImageFile",
                  @"orgaImageFile",
                  @"surfaceImageFile",
                  @"addressImageFile",
                  @"productImageFile",
                  @"detailImageFile",
                  @"salesImageFile",
                  @"bankSeqImageFile",
                  @"financialImageFile",
                  @"dueImageFile"];
    _cellArray = [NSMutableArray array];
    
}

- (void)configUI{
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTopBarHeight)];
    scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, kCellHigh*(titleArray.count + titleArray1.count + 1));
    centPoint = scrollView.center;
    for (int i = 0; i<titleArray.count; i++) {
        ReportTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ReportTableViewCell" owner:self options:nil] lastObject];
        cell.hbTitleLabel.text = titleArray[i];
        cell.frame = CGRectMake(0, kCellHigh*i, kSCREEN_WIDTH, kCellHigh);
        
//        keyArray = titleArray;
        cell.keyString = keyArray[i];
        
        if ([cell.keyString isEqualToString:@"operationType"]) {
            //经营类型
            cell.changeArray = @[@"生产型",
                                 @"贸易型"];
            [cell showLabelView];
        }else if([cell.keyString isEqualToString:@"nowState"]){
            //实际用途
            cell.changeArray = @[@"保存完好",
                                 @"出现损坏",
                                 @"已经灭失"
                                 ];
            [cell showLabelView];
            
            
        }else if([cell.keyString isEqualToString:@"actualPayMethod"]){
            //实际付款方式
            cell.changeArray = @[@"贷款人受托支付",@"借款人自主支付"];
            [cell showLabelView];
            
        }else if([cell.keyString isEqualToString:@"payMethod"]){
            //实际用途
            cell.changeArray = @[@"贷款人受托支付",
                                 @"借款人自主支付",
                                 @"受托支付+自主支付",
                                 ];
            [cell showLabelView];
        }else  if ([cell.keyString isEqualToString:@"guarPay"]) {
            //经营类型
            cell.changeArray = @[@"信用",
                                 @"抵押",
                                 @"质押",
                                 @"保证",
                                 @"其它"];
            cell.subKeyString = @"guarPayOther";

            [cell showLabelView];
        }
        else{
           
                [cell showTextField];

        }
        
        cell.vc = self;
        
        [cell setValuetext:[self.userDic objectForKey:cell.keyString]];
        cell.subValueString = [self.userDic objectForKey:cell.subKeyString];
        [cell setTextLength:textLengthArray[i]];
        
        [_cellArray addObject:cell];
        [scrollView addSubview:cell];
    }
    
    for (int i = 0; i < titleArray1.count; i++) {
        ReportPicCell *picCell = [[[NSBundle mainBundle] loadNibNamed:@"ReportPicCell" owner:nil options:nil] lastObject];
        picCell.frame = CGRectMake( 0, (titleArray.count + i) *kCellHigh , kSCREEN_WIDTH , kCellHigh );
        picCell.nameLabel.text = titleArray1[i];
        picCell.keyString = keyArray1[i];
        
        if (self.userDic[picCell.keyString]) {
            [picCell setPicString:self.userDic[picCell.keyString]];
        }
        
        [_cellArray addObject:picCell];
        [scrollView addSubview:picCell];
    }
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setFrame:CGRectMake(10, (titleArray.count+titleArray1.count)*kCellHigh + 5, kSCREEN_WIDTH - 20, kCellHigh - 10)];
    [btn addTarget:self action:@selector(nextStep) forControlEvents:(UIControlEventTouchUpInside)];
    [btn setBackgroundColor:RGBACOLOR(0, 93, 57, 1)];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [scrollView addSubview:btn];
    [self.view addSubview:scrollView];
    [self getScrollClicked];

}

- (void)nextStep{
    HBAllCheckNextViewController *vc = [[HBAllCheckNextViewController alloc] init];
    [self getAllParams];
    vc.userDic = _paramDic;
    [vc setBackEvent:^(NSMutableDictionary *dataDic) {
        _paramDic = dataDic;
    }];
    [self pushCheckNextVC:vc];
}

//处理特殊字段
- (void)handleSpecial{
    
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType18] forKey:@"licenseInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType19] forKey:@"orgaInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType1] forKey:@"surfaceInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType2] forKey:@"addressInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType16] forKey:@"productInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType20] forKey:@"detailInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType21] forKey:@"salesInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType22] forKey:@"bankSeqInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType23] forKey:@"financialInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType24] forKey:@"dueInfo"];
}
@end

