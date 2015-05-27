//
//  HBPersonalVehiclesDailyMortgageChecksViewController.m
//  HBPSLoanManager
//
//  Created by diudiu on 15/4/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPersonalVehiclesDailyMortgageChecksViewController.h"
#import "ReportTableViewCell.h"
#import "HBPVDailyMortgageCheckNextViewController.h"
#import "ReportPicCell.h"
#import "ZipTool.h"

@interface HBPersonalVehiclesDailyMortgageChecksViewController ()
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

@implementation HBPersonalVehiclesDailyMortgageChecksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = @"个商车辆贷款日常及逾期";
    self.backButton.hidden = NO;
    //初始化数据源
    [self initWithDate];
    //绘制UI界面
    [self createSuViewByPersonalVehiclesDailyMortgageChecks];
    
}

- (void)createSuViewByPersonalVehiclesDailyMortgageChecks
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
        
        if ([cell.keyString isEqualToString:@"prodType"]) {
            //经营类型
            
            //设置pickview中显示的item
            cell.changeArray = @[@"总对总直销模式",
                                 @"总对总经销模式",
                                 @"经销商担保模式",
                                 @"分对总直销模式",
                                 @"分对总经销模式",
                                 @"直客式"];
            
            //设置cell显示为 Label样式
            [cell showLabelView];
            
            //成员变量赋值
            _operationTypeCell = cell;
            
            //贷款人受托支付    	□借款人自主支付        □受托支付+自主支付
        }else if([cell.keyString isEqualToString:@"lendDate"]){
            //实际用途
            cell.changeArray = @[@"先抵押后放款",
                                 @"先放款后抵押"];
            //                [cell showLabelView];
            [cell showTextField];
            _actualPayMethodCell = cell;
            
        }else if([cell.keyString isEqualToString:@"checkMethod"]){
            //实际用途
            cell.changeArray = @[@"电话检查",
                                 @"征信记录查询",
                                 @"实地检查",
                                 @"GPS监控"];
            [cell showLabelView];
            
            //选择其他的情况(弹框)
            //                cell.subKeyString = @"actualPurposeOther";
            
            _actualPurposeCell = cell;
        }else if([cell.keyString isEqualToString:@"checkReason"]){
            //实际用途
            cell.changeArray = @[@"日常检查",
                                 @"逾期检查",
                                 @"实地检查",
                                 @"其他"];
            [cell showLabelView];

            //选择其他的情况(弹框)
            cell.subKeyString = @"actualPurposeOther";
            
            _actualPurposeCell = cell;
            _actualPurposeCell = cell;
        }else if([cell.keyString isEqualToString:@"processAdjust"]){
            //实际用途
            cell.changeArray = @[@"1.借款人资信状况正常，保持当前授信情况不变。",
                                 @"2.借款人资信状况出现一些潜在风险，但不影响正常还款，建议予以关注。",
                                 @"3.借款人资信状况或担保物发生重大不利变化，建议采取提前收回贷款、或处置抵质押物、或担保人代偿、或启动司法程序等措施。"];
            [cell showLabelView];
            
            //选择其他的情况(弹框)
            //                cell.subKeyString = @"actualPurposeOther";
            
            _actualPurposeCell = cell;
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
        titleArray = @[@"借款人姓名",
                       @"贷款金额",
                       @"贷款利率",
                       @"贷款起期",
                       @"贷款止期",
                       @"还款方式",
                       @"贷款余额",
                       @"产品模式",
                       @"放款时点",
                       @"检查方式",
                       @"检查原因",
                       @"检查发现问题处理意见"];
    
    keyArray = @[  @"custName",
                   @"loadAmt",
                   @"productRate",
                   @"startDate",
                   @"endDate",
                   @"repayType",
                   @"loanBalance",
                   @"prodType",
                   @"lendDate",
                   @"checkMethod",
                   @"checkReason",
                   @"processAdjust"];
    
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
                            [NSNumber numberWithInteger:50]];
   
        //用来设置 pickview 的显示的数组
        
    titleArray1 = @[@"车辆"];
    
    //图片上传cell的key值 数组
    keyArray1 = @[@"carImageFile"];
    _cellArray = [NSMutableArray array];

}

//点击下一步事件
- (void)nextStep{
    HBPVDailyMortgageCheckNextViewController *vc = [[HBPVDailyMortgageCheckNextViewController alloc] init];
    
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
    
    [self pushCheckNextVC:vc];
}

//处理特殊字段
- (void)handleSpecial{
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType1] forKey:@"surfaceInfo"];
    [_paramDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)ImageType2] forKey:@"addressInfo"];
    [_paramDic setObject:[self getOtherInfoType] forKey:@"otherInfo"];
}

//获取传送影像类型
- (NSString *)getOtherInfoType{
    
    NSString *resultString = [NSString stringWithFormat:@"%@%@%@",_actualPurposeCell.valueString,_operationTypeCell.valueString,_actualPayMethodCell.valueString];
    
    //实际用途：■采购货物/采购机器、设备、车辆等 0 2   经营类型：■贸易型     1 贷款支付方式：■贷款人受托支付 0
    
    if ([resultString isEqualToString:@"010"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType3];
    }
    //"实际用途：■采购货物/采购机器、设备、车辆等 0 2    经营类型：■贸易型 0贷款支付方式：■借款人自主支付" 1
    if ([resultString isEqualToString:@"001"]||[resultString isEqualToString:@"201"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType4];
    }
    //"约定用途：■装修经营场地  4  经营类型：■贸易型   1 贷款支付方式：■贷款人受托支付"0
    if ([resultString isEqualToString:@"410"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType5];
    }
    //"约定用途：■装修经营场地 4    经营类型：■贸易型   1 贷款支付方式：■借款人自主支付" 1
    if ([resultString isEqualToString:@"411"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType6];
    }
    //"约定用途：■发工资   5 经营类型：■贸易型/■生产型  0 1  贷款支付方式：■借款人自主支付" 1
    if ([resultString isEqualToString:@"501"]||[resultString isEqualToString:@"511"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType7];
    }
    //"约定用途：■购买原材料或辅料/■采购机器、设备等   1 2  经营类型：■生产型 0   贷款支付方式：■贷款人受托支付" 0
    if ([resultString isEqualToString:@"100"]||[resultString isEqualToString:@"200"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType8];
    }
    //"约定用途：■购买原材料或辅料/■采购机器、设备等  1 2  经营类型：■生产型  0   贷款支付方式：■借款人自主支付" 1
    if ([resultString isEqualToString:@"101"]||[resultString isEqualToString:@"201"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType9];
    }
    //"约定用途：■修建车间、厂房/■维修车间、厂房   3 7  经营类型：■生产型  0   贷款支付方式：■贷款人受托支付" 0
    if ([resultString isEqualToString:@"300"]||[resultString isEqualToString:@"700"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType10];
    }
    //"约定用途：■修建车间、厂房/■维修车间、厂房  3 7   经营类型：■生产型  0  贷款支付方式：■借款人自主支付" 1
    if ([resultString isEqualToString:@"301"]||[resultString isEqualToString:@"701"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType11];
    }
    //"约定用途：■维修设备/■维修车间、厂房   6 7  经营类型：■生产型   0 贷款支付方式：■贷款人受托支付" 0
    if ([resultString isEqualToString:@"600"]||[resultString isEqualToString:@"700"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType12];
    }
    //"约定用途：■维修设备/■维修车间、厂房   6 7  经营类型：■生产型  0  贷款支付方式：■借款人自主支付" 1
    if ([resultString isEqualToString:@"601"]||[resultString isEqualToString:@"701"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType13];
    }
    //"约定用途：■维修设备/■维修车间、厂房、库房 6 7    经营类型：■贸易型 1    贷款支付方式：■贷款人受托支付" 0
    if ([resultString isEqualToString:@"610"]||[resultString isEqualToString:@"710"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType14];
    }
    //"约定用途：■维修设备/■维修车间、厂房、库房  6 7  经营类型：■贸易型    1贷款支付方式：■借款人自主支付" 1
    if ([resultString isEqualToString:@"611"]||[resultString isEqualToString:@"711"]) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)ImageType15];
    }
    
    return @"-1";
}

@end
