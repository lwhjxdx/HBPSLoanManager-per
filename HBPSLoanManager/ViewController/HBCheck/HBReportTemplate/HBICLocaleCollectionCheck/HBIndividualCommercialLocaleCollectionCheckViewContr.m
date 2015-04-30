//
//  HBIndividualCommercialLocaleCollectionCheckViewContr.m
//  HBPSLoanManager
//
//  Created by diudiu on 15/4/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBIndividualCommercialLocaleCollectionCheckViewContr.h"
#import "ReportTableViewCell.h"
#import "HBIlCLocaleCollectionCheckNextViewContr.h"
#import "ReportPicCell.h"
#import "ZipTool.h"

@interface HBIndividualCommercialLocaleCollectionCheckViewContr ()
{
    NSArray *titleArray;
    NSMutableArray *cellArray;
    NSArray *titleArray1;
    NSArray *keyArray;
    NSArray *keyArray1;
    NSArray *textLengthArray;
    
    //因为需要进行相应的判断 所有将下面cell 提出作为成员变量
    
    ReportTableViewCell *_operationTypeCell;//经营类型Cell
    
    ReportTableViewCell *_actualPayMethodCell;//实际支付方式Cell
    
    ReportTableViewCell *_actualPurposeCell;//实际用途Cell
}

@end

@implementation HBIndividualCommercialLocaleCollectionCheckViewContr

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = @"个商现场催收";
    self.backButton.hidden = NO;
    //初始化数据源
    [self initWithDate];
    //绘制UI界面
    [self createSuViewByIndividualCommercialLocaleCollectionView];
    
}

- (void)createSuViewByIndividualCommercialLocaleCollectionView
{
        //最外层为一层 scrollView
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTopBarHeight)];
        
        //设置 scrollView.contentSize （LabelCell 的 count 加上 picCell 的count 加上 下一步按钮 的高度）
        scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, kCellHigh*(titleArray.count + keyArray1.count + 1));
        
        //for循环创建cell
        for (int i = 0; i<titleArray.count; i++) {
            ReportTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ReportTableViewCell" owner:self options:nil] lastObject];
            
            //设置cell左边显示 的文字
            cell.hbTitleLabel.text = titleArray[i];
            
            //设置cell的frame
            cell.frame = CGRectMake(0, kCellHigh*i, kSCREEN_WIDTH, kCellHigh);
            
            //设置cell的keyString
            cell.keyString = keyArray[i];
            
            /**
             由于部分cell为 点击显示pickerView的样式
             故需要进行判断
             
             */
    
            if ([cell.keyString isEqualToString:@"repayWilling"]) {
                //经营类型
                
                //设置pickview中显示的item
                cell.changeArray = @[@"良好",
                                     @"较差"];
                
                //设置cell显示为 Label样式
                [cell showLabelView];
                
                //成员变量赋值
                _operationTypeCell = cell;
                
                //贷款人受托支付    	□借款人自主支付        □受托支付+自主支付
            }else if([cell.keyString isEqualToString:@"obligationSuggest"]){
                //实际用途
                cell.changeArray = @[@"良好",
                                     @"交差"];
                [cell showLabelView];
                _actualPayMethodCell = cell;
                
            }
            else{
                //其他的全部为 textfield框样式
                [cell showTextField];
                
            }
            
            //设置cell的 vc为本controller 主要是为了显示 pickview
            cell.vc = self;
            
            //根据字典中的值给cell赋值
            
            [cell setValuetext:[self.userDic objectForKey:cell.keyString]];
            cell.subValueString = [self.userDic objectForKey:cell.subKeyString];
            
            
            
            //设置cell 输入框的最大长度
            [cell setTextLength:textLengthArray[i]];
            
            //将cell添加 到_cellArray 中
            [_cellArray addObject:cell];
            
            //将cell添加 到 scrollViews 上
            [scrollView addSubview:cell];
        }
        
        
        //配置 picCell  逻辑同上
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
        
        //配置下一步按钮
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
        
        
        
        //添加Scroll点击事件 判断键盘显示  必须加上
        [self getScrollClicked];
}

- (void)initWithDate
{
        /**
         titleArray 为显示在最左边的Label需要显示的文字
         keyArray 为 cell 的key值的数组
         textLengthArray 为cell 的textField输入的最长位数
         
         */
        titleArray = @[@"客户名称",
                       @"授信业务种类",
                       @"贷款金额",
                       @"贷款起期",
                       @"贷款止期",
                       @"贷款五级分类状态",
                       @"逾期本金",
                       @"逾期时间",
                       @"本次催收时间",
                       @"上次催收时间",
                       @"催收人",
                       @"催收地址",
                       @"催收方式",
                       @"借款人/申请人还款计划",
                       @"借款人/申请人还款意愿",
                       @"借款人/申请人还款能力变化情况",
                       @"借款人/申请人还款计划",
                       @"保证人/抵押人/质押人履行担保义务的意愿",
                       @"保证人保证能力变化情况",
                       @"抵押物价值变化情况",
                       @"影响我行债权实现的其它情况",
                       @"上一次达成的还款协议及执行情况",
                       @"本次达成的还款协议"];
        
        keyArray = @[  @"custName",
                       @"operationType",
                       @"loadAmt",
                       @"startDate",
                       @"endDate",
                       @"levelStatus",
                       @"overdueCorpus",
                       @"overdueDatetime",
                       @"collectTime",
                       @"preCollectTime",
                       @"urge",
                       @"urgeAddress",
                       @"urgeMethod",
                       @"repayPlan",
                       @"repayWilling",
                       @"repayAbility",
                       @"onlineRepayPlan",
                       @"obligationSuggest",
                       @"donaAbility",
                       @"valueChange",
                       @"otherInfo",
                       @"implementInfo",
                       @"repayAgree"];
        
        
        textLengthArray = @[[NSNumber numberWithInteger:30],
                            [NSNumber numberWithInteger:30],
                            [NSNumber numberWithInteger:100],
                            [NSNumber numberWithInteger:50],
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
                            [NSNumber numberWithInteger: 10],
                            [NSNumber numberWithInteger:10],
                            [NSNumber numberWithInteger:30],
                            [NSNumber numberWithInteger:50],
                            [NSNumber numberWithInteger:100],
                            [NSNumber numberWithInteger:500]];
        
        //用来设置 pickview 的显示的数组
        
        titleArray1 = @[@"生产经营场所外观",
                        @"企业经营场地或生产车间"];
        
        
        
        //图片上传cell的key值 数组
        keyArray1 = @[@"surfaceImageFile",
                      @"addressImageFile"];
        _cellArray = [NSMutableArray array];

}

//点击下一步事件
- (void)nextStep{
    HBIlCLocaleCollectionCheckNextViewContr *vc = [[HBIlCLocaleCollectionCheckNextViewContr alloc] init];
    
    //将数据收集到_paramDic 中
    [self getAllParams];
    
    //将_paramDic赋值给 vc.userDic
    vc.userDic = _paramDic;
    
    //当返回时 _paramDic 为 第二界面传回来的值加 第一个界面的值  的 集合
    [vc setBackEvent:^(NSMutableDictionary *dataDic) {
        //dataDic 为 本controller _paramDic 与 第二个界面输入的值的集合
        
        //重新赋值给_paramDic ，方便 下一步 还原上次填写的值
        _paramDic = dataDic;
    }];
    
    [self pushViewController:vc animated:YES];
}

@end
