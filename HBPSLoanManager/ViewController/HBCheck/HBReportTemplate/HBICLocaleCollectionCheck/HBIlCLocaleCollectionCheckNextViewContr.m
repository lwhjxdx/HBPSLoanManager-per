//
//  HBIlCLocaleCollectionCheckNextViewContr.m
//  HBPSLoanManager
//
//  Created by diudiu on 15/4/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBIlCLocaleCollectionCheckNextViewContr.h"
#import "HBNextStepChangeCell.h"
#import "HBCTextFeildTableViewCell.h"

@interface HBIlCLocaleCollectionCheckNextViewContr ()
{
    NSArray *_titleArray;
    NSArray *_itemArray1;
    NSArray *_itemArray2;
    NSArray *_itemArray3;
    NSArray *_keyArray;
}

@end

@implementation HBIlCLocaleCollectionCheckNextViewContr

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = @"个商现场催收";
    self.backButton.hidden = NO;
    
    self.checkType = individualCommercialLocaleCollect;
    self.requestUrl = kInsertPersonalCollectionModel;
    
    //初始化数据源
    [self initWithDate];
    //绘制UI界面
    [self createSuViewByIlCLocaleCollectionCheckNextView];
    
}

- (void)createSuViewByIlCLocaleCollectionCheckNextView
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
            switch (i)
            {
                case 0:
                {
                    [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                    
                    //设置 cell 默认选中  0
                    [cell setSelectIndex:1];
                    //当点击 下标为  1 时的 按钮时  弹出  输入框
                    cell.needAdd = 1;
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
        _titleArray = @[@"是否存在风险预警信息"];
        
        //选项
        _itemArray2 = @[@"是",@"否"];
        
        
        //key 的 数组
        _keyArray = @[@"isRiskFlag"];
        
        //弹出 textField 的 key值数组   如果 为   @"" 则表示 不需要弹出任何输入框
        _infoArray = @[@""];
        
        //"3000" 1000 1000 100
        
        //弹出textfield 的输入最大长度
        _textLengthArray = @[[NSNumber numberWithInteger:100]];
    
        viewArray = [NSMutableArray array];
        cellArray = [NSMutableArray array];
        
        
        //需要 上传 zip 的 字段名称 数组
        valueArrays = @[@"surfaceImageFile",
                        @"addressImageFile"];
}

//添加最后一个框
- (void)addSupportText{
    HBCTextFeildTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBCTextFeildTableViewCell" owner:nil options:nil] lastObject];
    cell.frame = CGRectMake(0,cellArray.count*kNextStepCellHigh, kSCREEN_WIDTH, kTextFieldHigh);
    cell.keyString = @"processAdjust";
    [cell setTextLength:[NSNumber numberWithInteger:3000]];
    cell.infoTextField.placeholder = @"催收处理意见";
    [viewArray addObject:cell];
    [scrollView addSubview:cell];
}
    

@end
