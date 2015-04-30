//
//  HBPBCheckNextViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/20.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPBCheckNextViewController.h"
#import "HBNextStepChangeCell.h"
#import "HBCTextFeildTableViewCell.h"
@interface HBPBCheckNextViewController ()
{
    NSArray *_titleArray;
    NSArray *_itemArray1;
    NSArray *_itemArray2;
    NSArray *_itemArray3;
    NSArray *_keyArray;
}
@end

@implementation HBPBCheckNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"还款资金落实情况检查";
    self.requestUrl = kInsertRepayCheckModel;
    self.checkType = payBackCheck;

    [self loadData];
    [self configUI];
}

- (void)loadData{
    _titleArray = @[
                    @"是否有还款资金来源",
                    @"是否存在风险预警信息"];
    
    _itemArray2 = @[@"是",@"否"];
    _itemArray3 = @[@"有",@"无"];
    _keyArray = @[
                  @"ifSource",
                  @"isRiskFlag"];
    
    _infoArray = @[
                   @"reimbSource",
                   @"riskInputInfo"];
    

    _textLengthArray = @[[NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000]];
        
    viewArray = [NSMutableArray array];
    cellArray = [NSMutableArray array];
    valueArrays = @[@"surfaceImageFile",
                    @"addressImageFile"];
}

- (void)configUI{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTopBarHeight)];
    centPoint = scrollView.center;
    
    for (int i = 0; i<_titleArray.count; i++) {
        HBNextStepChangeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBNextStepChangeCell" owner:nil options:nil] lastObject];
        cell.frame = CGRectMake(0, i*kNextStepCellHigh, kSCREEN_WIDTH, kNextStepCellHigh);
        cell.index = i;
        cell.keyString = _keyArray[i];
        cell.needAdd = 1;
        
        switch (i) {
            case 0:
            {
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray3];
                [cell setSelectIndex:0];
                cell.needAdd = 1;
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
    
    [self addTwoBtn];
    [self.view addSubview:scrollView];
    [self getScrollClicked];
}


//处理特殊字段
- (void)handleSpecial{
    
}

@end
