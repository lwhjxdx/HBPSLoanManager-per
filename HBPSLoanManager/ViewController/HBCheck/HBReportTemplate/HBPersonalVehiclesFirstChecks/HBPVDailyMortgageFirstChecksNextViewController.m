//
//  HBPVDailyMortgageFirstChecksNextViewController.m
//  HBPSLoanManager
//
//  Created by diudiu on 15/4/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPVDailyMortgageFirstChecksNextViewController.h"
#import "HBNextStepChangeCell.h"
#import "HBCTextFeildTableViewCell.h"

@interface HBPVDailyMortgageFirstChecksNextViewController ()
{
    NSArray *_titleArray;
    NSArray *_itemArray1;
    NSArray *_itemArray2;
    NSArray *_itemArray3;
    NSArray *_keyArray;
}

@end

@implementation HBPVDailyMortgageFirstChecksNextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = @"个商车辆贷款首次检查";
    self.backButton.hidden = NO;
    
    self.checkType = pVDailyMortgageFirstChecks;
    self.requestUrl = kInsertCarIndexModel;

    
    //初始化数据源
    [self initWithDate];
    //绘制UI界面
    [self createSuViewByPVDailyMortgageFirstChecksNextView];
    
}

- (void)createSuViewByPVDailyMortgageFirstChecksNextView
{
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTopBarHeight)];
        
        for (int i = 0; i<_titleArray.count; i++) {
            HBNextStepChangeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBNextStepChangeCell" owner:nil options:nil] lastObject];
            cell.frame = CGRectMake(0, i*kNextStepCellHigh, kSCREEN_WIDTH, kNextStepCellHigh);
            
            
            //记录  cell 是第几个
            cell.index = i;
            cell.keyString = _keyArray[i];
            cell.needAdd = 1;
            [cell setSelectIndex:0];
            switch (i) {
                case 0:
                {
                    [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                    
                    //设置 cell 默认选中  0
                    [cell setSelectIndex:1];
                    //当点击 下标为  1 时的 按钮时  弹出  输入框
                    cell.needAdd = 0;
                }
                    break;
                case 1:
                {
                    [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                    [cell setSelectIndex:1];
                    cell.needAdd = 0;
                }
                    break;
                    
                case 2:
                {
                    [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                    [cell setSelectIndex:1];
                    cell.needAdd = 0;
                }
                    break;
                    
                case 3:
                {
                    [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                    [cell setSelectIndex:1];
                    cell.needAdd = 0;
                }
                    break;
                case 4:
                {
                    [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                    [cell setSelectIndex:1];
                    cell.needAdd = 0;
                }
                    break;
                default:
                    break;
            }
            
            cell.vc = self;
            
            [cellArray addObject:cell];
            [viewArray addObject:cell];
            [scrollView addSubview:cell];
        }
        
        /**
         根据需求调整
         [self addSupportText];
         
         放在这里 是为了  添加到最后
         */
        //添加 建议与意见输入框
        [self addSupportText];
        
        
        //添加   保存草稿箱   上传 按钮
        [self addTwoBtn];
        
        [self.view addSubview:scrollView];
        
        [self getScrollClicked];
}

- (void)initWithDate
{
        //标题
        _titleArray = @[
                        @"若放款时点为“先放款后抵押”，抵押手续是否办理完毕，且相关单证已交我行保管？",
                        @"贷款实际用途是否合规、真实？购买车辆型号、数量是否与合同一致？（检查相关凭证）",
                        @"车辆的实际使用情况是否正常（车辆是否在抵押后私自改装；是否安装GPS以及GPS监控功能是否可用；是否擅自转让、赠与等；是否出现毁损等）？",
                        @"借款人的经营及财务情况是否正常（核实借款人经营、还款能力是否发生重大不利变化）？",
                        @"挂靠单位的生产经营状况（如有）是否正常？"];
        
        //选项
        _itemArray2 = @[@"是",@"否"];
    
        //key 的 数组
        _keyArray = @[
                      @"isDocumentCare",
                      @"isCheckProof",
                      @"isDamag",
                      @"isAffairs",
                      @"isLineOperation"];
        
        //弹出 textField 的 key值数组   如果 为   @"" 则表示 不需要弹出任何输入框
        _infoArray = @[
                       @"documentCareInfo",
                       @"checkProofInfo",
                       @"damageInfo",
                       @"affairsInfo",
                       @"lineOperationInfo"];
        
        //"3000" 1000 1000 100
        
        //弹出textfield 的输入最大长度
        _textLengthArray = @[[NSNumber numberWithInteger:1000],
                             [NSNumber numberWithInteger:1000],
                             [NSNumber numberWithInteger:1000],
                             [NSNumber numberWithInteger:1000],
                             [NSNumber numberWithInteger:100]];
        viewArray = [NSMutableArray array];
        cellArray = [NSMutableArray array];
        
        
        //需要 上传 zip 的 字段名称 数组
        valueArrays = @[@"surfaceImageFile",
                        @"addressImageFile",
                        @"otherImageFile"];
}

//添加最后一个框
- (void)addSupportText{
    HBCTextFeildTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBCTextFeildTableViewCell" owner:nil options:nil] lastObject];
    cell.frame = CGRectMake(0,cellArray.count*kNextStepCellHigh, kSCREEN_WIDTH, kTextFieldHigh);
    cell.keyString = @"processAdjust";
    [cell setTextLength:[NSNumber numberWithInteger:3000]];
    cell.infoTextField.placeholder = @"处理意见";
    [viewArray addObject:cell];
    [scrollView addSubview:cell];
    
    HBCTextFeildTableViewCell *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"HBCTextFeildTableViewCell" owner:nil options:nil] lastObject];
    cell1.frame = CGRectMake(0,cellArray.count*kNextStepCellHigh+kTextFieldHigh, kSCREEN_WIDTH, kTextFieldHigh);
    cell1.keyString = @"checkOut";
    [cell1 setTextLength:[NSNumber numberWithInteger:3000]];
    cell1.infoTextField.placeholder = @"检查发现的问题";
    [viewArray addObject:cell1];
    [scrollView addSubview:cell1];
}


@end
