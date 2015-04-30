//
//  HBIClCreditDailyCheckNextViewController.m
//  HBPSLoanManager
//
//  Created by diudiu on 15/4/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBIClCreditDailyCheckNextViewController.h"
#import "HBNextStepChangeCell.h"
#import "HBCTextFeildTableViewCell.h"

@interface HBIClCreditDailyCheckNextViewController ()
{
    NSArray *_titleArray;
    NSArray *_itemArray1;
    NSArray *_itemArray2;
    NSArray *_itemArray3;
    NSArray *_keyArray;
}

@end

@implementation HBIClCreditDailyCheckNextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = @"个商贷款日常检查";
    self.backButton.hidden = NO;
    
    self.checkType = individualCommercialCreditDailyCheck;
    self.requestUrl = kInsertPersonalComModel;
    
    //初始化数据源
    [self initWithDate];
    //绘制UI界面
    [self createSuViewByICCreditDailyNextView];
    
}

- (void)createSuViewByICCreditDailyNextView
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
                [cell setSelectIndex:1];
                //当点击 下标为  1 时的 按钮时  弹出  输入框
//                cell.needAdd = 1;
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
            case 6:
            {
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                [cell setSelectIndex:1];
                cell.needAdd = 0;
            }
                break;
            case 7:
            {
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                [cell setSelectIndex:1];
                cell.needAdd = 0;
            }
                break;
            case 8:
            {
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                [cell setSelectIndex:1];
                cell.needAdd = 0;
            }
                break;
            case 9:
            {
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                [cell setSelectIndex:1];
                cell.needAdd = 0;
            }
                break;
            case 10:
            {
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                [cell setSelectIndex:1];
                cell.needAdd = 0;
            }
                break;case 11:
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

- (void)initWithDate
{
    //标题
    _titleArray = @[
                    @"检查配合程度",
                    @"当前贷款状况，是否出现逾期",
                    @"借款人所处经营环境、行业前景是否发生重大变动",
                    @"经营实体实际控制人、主要股东及主要管理人员是否发生变动",
                    @"经营实体生产经营场所是否发生或即将发生变动",
                    @"经营实体生产经营是否出现异常情况（停产、半停产、员工数量骤减、设备开工率不足等）",
                    @"经营实体财务状况，现金流、营业收入是否出现异动",
                    @"借款人或其经营实体是否存在大额对外担保",
                    @"借款人或其经营实体是否存在对外大额投资，或偏离主业对外投资",
                    @"借款人信用状况、还款意愿是否发生不利变化",
                    @"借款人是否有其他方面的金融服务需求",
                    @"是否存在风险预警信号"];
    
    //选项
    _itemArray2 = @[@"是",@"否"];
    
    _itemArray3 = @[@"配合",@"一般",@"不配合"];
    
    
    //key 的 数组
    _keyArray = @[
                  @"checkCoop",
                  @"isOverdue",
                  @"isEnvironmentChange",
                  @"isManagerChange",
                  @"isRunAddress",
                  @"isMgrErr",
                  @"isFinanceChange",
                  @"isForeignGuar",
                  @"isInvestment",
                  @"isAdverseChange",
                  @"isService",
                  @"isRiskFlag"];
    
    //弹出 textField 的 key值数组   如果 为   @"" 则表示 不需要弹出任何输入框
    _infoArray = @[
                   @"",
                   @"overrdueInfo",
                   @"environmectChangeInfo",
                   @"managerChangeInfo",
                   @"runAddressInfo",
                   @"mgrErrInfo",
                   @"financeChangeInfo",
                   @"foreignGuarInfo",
                   @"investmentInfo",
                   @"adverseChangeInfo",
                   @"serviceInfo",
                   @"riskInputInfo"];
    
    //"3000" 1000 1000 100
    
    //弹出textfield 的输入最大长度
    _textLengthArray = @[[NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:1000],
                         [NSNumber numberWithInteger:100]];
    viewArray = [NSMutableArray array];
    cellArray = [NSMutableArray array];
    
    
    //需要 上传 zip 的 字段名称 数组
    valueArrays = @[@"surfaceImageFile",
                    @"addressImageFile",
                    @"productImageFile"];

}

@end



























