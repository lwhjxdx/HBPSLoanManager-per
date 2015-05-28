//
//  HBPayBackCheckFirstViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/20.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPayBackCheckFirstViewController.h"
#import "HBPBCheckNextViewController.h"
#import "ReportTableViewCell.h"
#import "ReportPicCell.h"

@interface HBPayBackCheckFirstViewController ()<UIGestureRecognizerDelegate>
{
    NSArray *titleArray;
    NSMutableArray *cellArray;
    NSArray *titleArray1;
    NSArray *keyArray;
    NSArray *keyArray1;
    NSArray *textLengthArray;
}
@end

@implementation HBPayBackCheckFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"还款资金落实情况检查";
    self.backButton.hidden = NO;
    [self loadData];
    [self configUI];
    
    
}

- (void)loadData{
    
    titleArray = @[@"客户编号",
                   @"客户名称",
                   @"合同编号",
                   @"借据编号",
                   @"授信业务种类",
                   @"授信金额",
                   @"授信余额",
                   @"授信期限",
                   @"还款阶段",
                   @"还款意愿",

                   @"还款方式",
                   @"还款日期",
                   @"还款金额",
                  
                   @"预计还款/付息时间"];
    
    
    keyArray = @[  @"custId",
                   @"custName",
                   @"conNo",
                   @"dueNum",
                   @"creditProductCd",
                   @"creditExtensionAmt",
                   @"creditExtensionBalance",
                   @"creditExtensionPeriod",
                   @"repayTimes", //还款阶段
                   @"repayMean", //还款意愿
                   @"repayType",
                   @"repayDate",
                   @"repayAmt",
                   
                   @"repayTime"];
    
    textLengthArray = @[
                        [NSNumber numberWithInteger:30],
                        [NSNumber numberWithInteger:100],
                        [NSNumber numberWithInteger:30],
                        [NSNumber numberWithInteger:30],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:20],
                        [NSNumber numberWithInteger:8],
                       
                        [NSNumber numberWithInteger:1],
                        [NSNumber numberWithInteger:1],

                        [NSNumber numberWithInteger:10],
                        [NSNumber numberWithInteger:8],
                        [NSNumber numberWithInteger:20],
                       
                        [NSNumber numberWithInteger:8]];
    
    titleArray1 = @[@"客户经营场所外观",
                    @"企业经营场地或生产车间",
                    ];
    
    
    keyArray1 = @[@"surfaceImageFile",
                  @"addressImageFile",
                  ];
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
        
        if ([cell.keyString isEqualToString:@"repayTimes"]) {
            //经营类型
            cell.changeArray = @[@"第一阶段还款意愿",
                                 @"第二阶段还款意愿",
                                 @"第三阶段还款意愿"];
            [cell showLabelView];
        }else if([cell.keyString isEqualToString:@"repayMean"]){
            //实际用途
            cell.changeArray = @[@"良好",
                                 @"较差",
                                 @"无"];
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
    HBPBCheckNextViewController *vc = [[HBPBCheckNextViewController alloc] init];
    [self getAllParams];
     vc.userDic = _paramDic;
     [vc setBackEvent:^(NSMutableDictionary *dataDic) {
        _paramDic = dataDic;
    }];
    [self pushCheckNextVC:vc];
    

}

//处理特殊字段
- (void)handleSpecial{
    [_paramDic setObject:[NSString stringWithFormat:@"%d",(int)ImageType1] forKey:@"surfaceInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%d",(int)ImageType2] forKey:@"addressInfo"];
    
    
    NSInteger i = [[_paramDic objectForKey:@"repayTimes"] integerValue];
    NSInteger x = [[_paramDic objectForKey:@"repayMean"] integerValue];
    switch (i) {
        case 0:
        {
            [_paramDic setObject:[NSString stringWithFormat:@"%d",(int)x] forKey:@"firstCheckStage"];
        }
            break;
        case 1:
        {
            [_paramDic setObject:[NSString stringWithFormat:@"%d",(int)x] forKey:@"secondCheckStage"];
        }
            break;
        case 2:
        {
            [_paramDic setObject:[NSString stringWithFormat:@"%d",(int)x] forKey:@"thirdCheckStage"];
        }
            break;
        default:
            break;
    }
}




@end
