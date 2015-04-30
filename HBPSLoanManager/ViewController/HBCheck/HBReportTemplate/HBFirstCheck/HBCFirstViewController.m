//
//  HBCFirstViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/18.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCFirstViewController.h"
#import "ReportTableViewCell.h"
#import "HBCFNextViewController.h"
#import "ReportPicCell.h"
#import "ZipTool.h"
#import "HBCheckDetailViewController.h"

@interface HBCFirstViewController ()
{
    NSArray *titleArray;
    NSMutableArray *cellArray;
    NSArray *titleArray1;
    NSArray *keyArray;
    NSArray *keyArray1;
    NSArray *textLengthArray;
    
    NSMutableDictionary *paramsA;
    
    //因为需要进行相应的判断 所有将下面cell 提出作为成员变量
   
    ReportTableViewCell *_operationTypeCell;//经营类型Cell
    
    ReportTableViewCell *_actualPayMethodCell;//实际支付方式Cell

    ReportTableViewCell *_actualPurposeCell;//实际用途Cell


}
@end

@implementation HBCFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"首次检查";
    self.backButton.hidden = NO;
    [self loadData];
    [self configUI];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:@"conNo" forKey:@"access_token"];
    [params setObject:@"custId"  forKey:@"uid"];
    params = paramsA;
}



//初始化数据
- (void)loadData{
    /**
     titleArray 为显示在最左边的Label需要显示的文字
     keyArray 为 cell 的key值的数组
     textLengthArray 为cell 的textField输入的最长位数
    
     */
    titleArray = @[@"合同编号",
                   @"客户编号",
                   @"客户名称",
                   @"经营类型",
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
                   @"贷款用途",
                   @"贷款支付方式",
                   @"抵押物评估价值",
                   @"抵押物地址",
                   @"实际用途",
                   @"贷款实际支付方式",
                   @"抵质押物目前状况"];
    
    keyArray = @[  @"conNo",
                   @"custId",
                   @"custName",
                   @"operationType",
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
                   @"actualPurpose",
                   @"actualPayMethod",
                   @"nowState"];
    
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
                        [NSNumber numberWithInteger:500],
                        [NSNumber numberWithInteger: 50],
                        [NSNumber numberWithInteger:50],
                        [NSNumber numberWithInteger:50]];
    
    
    /*NSDictionary *dict = 服务器传输过来的数据//@["cusNo","cusId","cussf"];
     for (NSDictionary *object in dict) {
     [dict setValue:keyArray forKey:object];
     }
     }*/
    
    //用来设置 图片选择 cell的数组
    
    titleArray1 = @[@"客户经营场所外观",
                    @"企业经营场地或生产车间",
                    @"其他影像资料"];


    
    //图片上传cell的key值 数组
    keyArray1 = @[@"surfaceImageFile",
                  @"addressImageFile",
                  @"otherImageFile"];
    _cellArray = [NSMutableArray array];
    
    
}


//配置UI
- (void)configUI{
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
        if ([cell.keyString isEqualToString:@"operationType"]) {
            //经营类型
            
            //设置pickview中显示的item
            cell.changeArray = @[@"生产型",
                                 @"贸易型"];
            
            //设置cell显示为 Label样式
            [cell showLabelView];
            
            //成员变量赋值
            _operationTypeCell = cell;
            
            //贷款人受托支付    	□借款人自主支付        □受托支付+自主支付
        }else if([cell.keyString isEqualToString:@"payMethod"]){
            //实际用途
            cell.changeArray = @[@"贷款人受托支付",
                                 @"借款人自主支付",
                                 @"受托支付+自主支付",
                                 ];
            [cell showLabelView];
            _actualPayMethodCell = cell;
            
        }
        
        else if([cell.keyString isEqualToString:@"actualPurpose"]){
            //实际用途
            cell.changeArray = @[@"采购货物",
                                 @"购买原材料或辅料",
                                 @"采购机器、设备、车辆等",
                                 @"修建车间、厂房",
                                 @"装修经营场地",
                                 @"发工资",
                                 @"维修设备",
                                 @"维修车间、厂房",
                                 @"其他"];
            [cell showLabelView];
            
            //选择其他的情况(弹框)
            cell.subKeyString = @"actualPurposeOther";
            
            _actualPurposeCell = cell;
            
        }else if([cell.keyString isEqualToString:@"actualPayMethod"]){
            //实际付款方式
            cell.changeArray = @[@"贷款人受托支付",@"借款人自主支付"];
            [cell showLabelView];
        }else if([cell.keyString isEqualToString:@"nowState"]){
            //目前状况
            
            cell.changeArray = @[@"保存完好",@"出现损坏",@"已经灭失"];
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
//        cell.labelViewLabel.text = [self.userDic objectForKey:cell.keyString];

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

//点击下一步事件
- (void)nextStep{
    HBCFNextViewController *vc = [[HBCFNextViewController alloc] init];

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
