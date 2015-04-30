//
//  HBICRepaymentConditionNextViewController.m
//  HBPSLoanManager
//
//  Created by diudiu on 15/4/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBICRepaymentConditionNextViewController.h"
#import "HBNextStepChangeCell.h"
#import "HBCTextFeildTableViewCell.h"

@interface HBICRepaymentConditionNextViewController ()
{
    NSArray *_titleArray;
    NSArray *_itemArray1;
    NSArray *_itemArray2;
    NSArray *_itemArray3;
    NSArray *_itemArray4;
    NSArray *_keyArray;
}

@end

@implementation HBICRepaymentConditionNextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = @"个商还款情况";
    self.backButton.hidden = NO;
    
    self.checkType = iCRepaymentCondition;
    self.requestUrl = kInsertPersonalRepayModel;
    
    //初始化数据源
    [self initWithDate];
    //绘制UI界面
    [self createSuViewByICRepaymentConditionNextView];
    
}

- (void)createSuViewByICRepaymentConditionNextView
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
                    [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray4];
                    [cell setSelectIndex:1];
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
//        [self addSupportText];
        
        
        //添加   保存草稿箱   上传 按钮
        [self addTwoBtn];
        
        [self.view addSubview:scrollView];
        
        [self getScrollClicked];
}

- (void)initWithDate
{
        //标题
        _titleArray = @[
                        
                        @"还款资金来源",
                        @"是否存在风险预警信息"];
        
        //选项
        _itemArray2 = @[@"是",@"否"];
        _itemArray4 = @[@"有",@"无"];
    
        _itemArray3 = @[@"良好",@"较差",@"无"];
        
        
        //key 的 数组
        _keyArray = @[
                     
                      @"ifSource",
                      @"isRiskFlag"];
        
        //弹出 textField 的 key值数组   如果 为   @"" 则表示 不需要弹出任何输入框
        _infoArray = @[
                  
                       @"reimbSource",
                       @"riskInputInfo"];
        
        //"3000" 1000 1000 100
        
        //弹出textfield 的输入最大长度
        _textLengthArray = @[
                             [NSNumber numberWithInteger:1000],
                             [NSNumber numberWithInteger:100]];
    
        viewArray = [NSMutableArray array];
        cellArray = [NSMutableArray array];
        
        
        //需要 上传 zip 的 字段名称 数组
    valueArrays = @[@"surfaceImageFile",
                    @"addressImageFile"];
}

@end
