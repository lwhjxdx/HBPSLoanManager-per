//
//  HBRoutineFirstViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/20.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBRoutineFirstViewController.h"
#import "HBRoutineSecondViewController.h"

#import "ReportTableViewCell.h"
#import "ReportPicCell.h"

@interface HBRoutineFirstViewController ()<UIGestureRecognizerDelegate>
{
    NSArray *titleArray;
    NSMutableArray *cellArray;
    NSArray *titleArray1;
    NSArray *keyArray;
    NSArray *keyArray1;
    NSArray *textLengthArray;

}
@end
@implementation HBRoutineFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"例行检查";

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
                   @"抵押物评估价值",
                   @"抵押物地址",
                   @"担保方式",
                   @"检查地点",
                   @"接待人员"];
    
    
    keyArray = @[  @"custId",
                   @"custName",
                   @"conNo",
                   @"creditProductCd",
                   @"loadAmt",
                   @"loadPeriod",
                   @"loadDate",
                   @"busiScope",
                   @"operationAddress",
                   @"legalPerson",
                   @"shareholderInfo",
                   @"accountReceive",
                   @"materialsValue",
                   @"stockValue",
                   @"bankLoadAmt",
                   @"bankDeposit",
                   @"repayType",
                   @"loanPurpose",
                   @"payMethod",
                   @"affirmValue",
                   @"address",
                   @"guarPay",
                   @"checkAddress",
                   @"reception"];

    
    
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
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:500],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:30],
                        [NSNumber numberWithInteger:500],
                        [NSNumber numberWithInteger:30],
                        [NSNumber numberWithInteger:50]];
    
    titleArray1 = @[@"生产经营场所外观",
                    @"企业经营场地或生产车间",
                    @"原材料、库存成品或半成品",
                    @"财务系统截屏/纳税申报表、销售出入库单/销售合同/发票、近两个月银行账户流水/会计凭证"];
    
    keyArray1 = @[@"surfaceImageFile",
                  @"addressImageFile",
                  @"productImageFile",
                  @"financialIamgeFile"];
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
        
        cell.keyString = keyArray[i];
        
        if ([cell.keyString isEqualToString:@"guarPay"]) {
            //经营类型
            cell.changeArray = @[@"信用",
                                 @"抵押",
                                 @"质押",
                                 @"保证",
                                 @"其它"];
            cell.subKeyString = @"guarPayOther";
            
            [cell showLabelView];
        }else if([cell.keyString isEqualToString:@"payMethod"]){
            //实际用途
            cell.changeArray = @[@"贷款人受托支付",
                                 @"借款人自主支付",
                                 @"受托支付+自主支付",
                                 ];
            [cell showLabelView];
            
        }
        else{
            
                [cell showTextField];

        }
        cell.vc = self;
        
        [cell setValuetext:[self.userDic objectForKey:cell.keyString]];
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
    HBRoutineSecondViewController *vc = [[HBRoutineSecondViewController alloc] init];
    [self getAllParams];
    vc.userDic = _paramDic;
    [vc setBackEvent:^(NSMutableDictionary *dataDic) {
        _paramDic = dataDic;
    }];
 
    [self pushCheckNextVC:vc];
}

- (void)getAllParams{
    if (_paramDic == nil) {
        _paramDic = [NSMutableDictionary dictionary];
    }

    for (UIView *view in _cellArray) {
        if (PAT_) {
            NSString *keyString = [view valueForKey:@"keyString"];
            NSString *valueString = [view valueForKey:@"valueString"];
            if (valueString) {
                [_paramDic setObject:valueString forKey:keyString];
            }else{
                [_paramDic setObject:kDefaultValue forKey:keyString];
            }
        }else{
            NSString *keyString = [view valueForKey:@"keyString"];
            if (keyString == nil) {
                keyString = @"1";
            }
            NSString *valueString = [view valueForKey:@"valueString"];
            if (valueString == nil) {
                valueString = @"1";
            }
            [_paramDic setObject:valueString forKey:keyString];
        }

    }
    [self handleSpecial];
    NSLog(@"dic = %@",_paramDic);
}

//处理特殊字段
- (void)handleSpecial{
    [_paramDic setObject:[NSString stringWithFormat:@"%d",ImageType1] forKey:@"surfaceInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%d",ImageType2] forKey:@"addressInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%d",ImageType16] forKey:@"productInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%d",ImageType23] forKey:@"financialInfo"];
    
}




@end
