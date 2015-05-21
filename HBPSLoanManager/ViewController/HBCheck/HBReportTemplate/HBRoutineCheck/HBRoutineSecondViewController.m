//
//  HBRoutineSecondViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/20.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBRoutineSecondViewController.h"
#import "HBNextStepChangeCell.h"
#import "HBCTextFeildTableViewCell.h"


@interface HBRoutineSecondViewController ()<UIGestureRecognizerDelegate>
{
    NSArray *_titleArray;
    NSArray *_itemArray1;
    NSArray *_itemArray2;
    NSArray *_itemArray3;
    NSArray *_keyArray;
}
@end

@implementation HBRoutineSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"例行检查";
    self.checkType = routeCheck;
    
    self.requestUrl = kInsertComCheckModel;
    
    [self loadData];
    [self configUI];
  }

- (void)loadData{
    
    _titleArray = @[@"对我行检查的态度",
                    @"企业实际控制人、主要股东及主要管理人员是否发生变动",
                    @"企业生产经营场所是否发生或即将发生变动",
                    @"企业生产经营是否出现异常情况",
                    @"企业是否有其他方面的金融服务需求",
                    @"是否存在风险预警信号"];
    
    _itemArray2 = @[@"是",@"否"];
    _itemArray3 = @[@"配合",@"一般",@"不配合"];
    _keyArray = @[@"checkCoop",
                  @"isCtrlChange",
                  @"isAddrChange",
                  @"isMgrErr",
                  @"isOtherDeman",
                  @"isRiskFlag"];
    _infoArray = @[@"",
                   @"ctrlChangeInputInfo",
                   @"addrChangeInputInfo",
                   @"mgrErrInputInfo",
                   @"otherDemanInputInfo",
                   @"riskInputInfo"];
    
    //"3000" 1000 1000 100
    _textLengthArray = @[[NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:100]];
    viewArray = [NSMutableArray array];
    cellArray = [NSMutableArray array];
    
    valueArrays = @[@"surfaceImageFile",
                    @"addressImageFile",
                    @"productImageFile",
                    @"financialIamgeFile"];

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
        [cell setSelectIndex:0];
        switch (i) {
            case 0:
            {
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray3];
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
            case 5:
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
    
    
    [self addSupportText];
    
    [self addTwoBtn];
    CGFloat scorllHigh = kTextFieldHigh;
    for (UIView *view in viewArray) {
        scorllHigh += view.frame.size.height;
    }
    scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, scorllHigh);
    
    [self.view addSubview:scrollView];
    [self getScrollClicked];

}

- (void)addSupportText{
    HBCTextFeildTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBCTextFeildTableViewCell" owner:nil options:nil] lastObject];
    cell.frame = CGRectMake(0,cellArray.count*kNextStepCellHigh, kSCREEN_WIDTH, kTextFieldHigh);
    cell.keyString = @"suggest";
    [cell setTextLength:[NSNumber numberWithInteger:3000]];
    cell.infoTextField.placeholder = @"建议与意见";
    [viewArray addObject:cell];
    [scrollView addSubview:cell];
}

- (void)refreshView:(NSMutableDictionary *)dic{
    [self.view endEditing:YES];
    NSInteger index = [dic[@"index"] integerValue];
    
    if ([[_infoArray objectAtIndex:index] isEqualToString:@""]) {
        return;
    }
    if (dic[@"needAdd"]) {
        
        UIView *cellView = [cellArray objectAtIndex:index];
        NSInteger viewIndex = [viewArray indexOfObject:cellView];
        HBCTextFeildTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBCTextFeildTableViewCell" owner:nil options:nil] lastObject];
        cell.frame = CGRectMake(0,cellView.frame.origin.y + cellView.frame.size.height, kSCREEN_WIDTH, kTextFieldHigh);
        cell.keyString = [_infoArray objectAtIndex:index];
        
        [cell setTextLength:_textLengthArray[index]];
        
        [scrollView addSubview:cell];
        
        for (NSUInteger i = viewIndex+1; i<viewArray.count; i++) {
            [UIView animateWithDuration:0.3 animations:^{
                UIView *view = [viewArray objectAtIndex:i];
                CGRect rect = view.frame;
                rect.origin.y += kTextFieldHigh;
                view.frame  = rect;
            }];
        }
        [viewArray insertObject:cell atIndex:viewIndex+1];
        
    }else{
        UIView *cellView = [cellArray objectAtIndex:index];
        NSInteger viewIndex = [viewArray indexOfObject:cellView];
        
        for (NSInteger i = viewIndex+1; i<viewArray.count; i++) {
            [UIView animateWithDuration:0.3 animations:^{
                
                UIView *view = [viewArray objectAtIndex:i];
                CGRect rect = view.frame;
                rect.origin.y -= kTextFieldHigh;
                view.frame  = rect;
            }];
        }
        
        UIView *view = [viewArray objectAtIndex:viewIndex+1];
        [view removeFromSuperview];
        [viewArray removeObjectAtIndex:viewIndex+1];
    }
    
    CGFloat scorllHigh = kTextFieldHigh;
    for (UIView *view in viewArray) {
        scorllHigh += view.frame.size.height;
    }
    scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, scorllHigh);
}

- (void)addTwoBtn{
    saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [saveBtn setFrame:CGRectMake(10, (cellArray.count + 1)*kNextStepCellHigh, kSCREEN_WIDTH/2-20, 40)];
    [saveBtn setTitle:@"保存草稿箱" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:RGBACOLOR(0, 93, 57, 1)];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    saveBtn.layer.cornerRadius = 5;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(save) forControlEvents:(UIControlEventTouchUpInside)];
    [scrollView addSubview:saveBtn];
    [viewArray addObject:saveBtn];
    
    upDataBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [upDataBtn setFrame:CGRectMake(10+kSCREEN_WIDTH/2, (cellArray.count + 1)*kNextStepCellHigh, kSCREEN_WIDTH/2-20, 40)];
    [upDataBtn setBackgroundColor:RGBACOLOR(0, 93, 57, 1)];
    [upDataBtn addTarget:self action:@selector(upData) forControlEvents:(UIControlEventTouchUpInside)];
    
    [upDataBtn setTitle:@"完成" forState:UIControlStateNormal];
    upDataBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    upDataBtn.layer.cornerRadius = 5;
    upDataBtn.layer.masksToBounds = YES;
    [scrollView addSubview:upDataBtn];
    [viewArray addObject:upDataBtn];
}



//处理特殊字段
- (void)handleSpecial{
   
}



@end
