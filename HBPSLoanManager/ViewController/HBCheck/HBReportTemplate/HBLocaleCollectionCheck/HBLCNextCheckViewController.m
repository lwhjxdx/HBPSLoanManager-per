//
//  HBLCNextCheckViewController.m
//  HBPSLoanManager
//
//  Created by diudiu on 15/4/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBLCNextCheckViewController.h"
#import "HBNextStepChangeCell.h"
#import "HBCTextFeildTableViewCell.h"

@interface HBLCNextCheckViewController ()
{
    NSArray *_titleArray;
    NSArray *_itemArray1;
    NSArray *_itemArray2;
    NSArray *_itemArray3;
    NSArray *_keyArray;
}

@end

@implementation HBLCNextCheckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"现场催收";
    self.backButton.hidden = NO;
    
    self.checkType = localeCollectionCheck;
    self.requestUrl = kInsertCollectionCheckModel;
    //初始化数据源
    [self initWithDate];
    //绘制UI界面
    [self createSuViewByFirstLocaleCollectionCheckView];
    [self addSupportText];
}

#pragma mark - 绘制UI界面
//绘制UI界面
- (void)createSuViewByFirstLocaleCollectionCheckView
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
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray3];
                
                //设置 cell 默认选中  0
                [cell setSelectIndex:0];
                //当点击 下标为  1 时的 按钮时  弹出  输入框
                cell.needAdd = 1;
            }
                break;
            case 1:
            {
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray3];
                [cell setSelectIndex:0];
            }
                break;
                
            case 2:
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
//    [self addSupportText];
    
    //添加   保存草稿箱   上传 按钮
    [self addTwoBtn];
    
    [self.view addSubview:scrollView];
    
    [self getScrollClicked];

}

#pragma mark - 初始化数据源
//初始化数据源
- (void)initWithDate
{
    //标题
    _titleArray = @[
                    @"借款人/申请人还款意愿",
                    @"保证人/抵押人/质押人履行担保义务的意愿",
                    @"是存在风险预警信号"];
    
    //选项
    _itemArray2 = @[@"是",@"否"];
    
    _itemArray3 = @[@"良好",@"较差"];
    
    
    //key 的 数组
    _keyArray = @[
                  @"repayIdea",
                  @"guraObli",
                  @"isRiskFlag"];
    
    //弹出 textField 的 key值数组   如果 为   @"" 则表示 不需要弹出任何输入框
    _infoArray = @[
                   @"",
                   @"",
                   @"riskInputInfo"];
    
    //"3000" 1000 1000 100
    
    //弹出textfield 的输入最大长度
    _textLengthArray = @[[NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:100]];
    viewArray = [NSMutableArray array];
    cellArray = [NSMutableArray array];
    
    
    //需要 上传 zip 的 字段名称 数组
    valueArrays = @[@"surfaceImageFile",
                    @"addressImageFile"
                   ];
}

//添加最后一个框
- (void)addSupportText{
    HBCTextFeildTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HBCTextFeildTableViewCell" owner:nil options:nil] lastObject];
    cell.frame = CGRectMake(0,cellArray.count*kNextStepCellHigh, kSCREEN_WIDTH, kTextFieldHigh);
    cell.keyString = @"suggest";
    [cell setTextLength:[NSNumber numberWithInteger:3000]];
    cell.infoTextField.placeholder = @"建议与意见";
    [viewArray addObject:cell];
    [scrollView addSubview:cell];
}

@end
