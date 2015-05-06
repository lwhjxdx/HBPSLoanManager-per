//
//  HBPVDailyMortgageCheckNextViewController.m
//  HBPSLoanManager
//
//  Created by diudiu on 15/4/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPVDailyMortgageCheckNextViewController.h"
#import "HBNextStepChangeCell.h"
#import "HBCTextFeildTableViewCell.h"

@interface HBPVDailyMortgageCheckNextViewController ()
{
    NSArray *_titleArray;
    NSArray *_itemArray1;
    NSArray *_itemArray2;
    NSArray *_itemArray3;
    NSArray *_keyArray;
}

@end

@implementation HBPVDailyMortgageCheckNextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = @"个商车辆贷款日常及逾期";
    self.backButton.hidden = NO;
    
    self.checkType = personalVehiclesDailyMortgageChecks;
    self.requestUrl = kInsertCarComModel;

    
    //初始化数据源
    [self initWithDate];
    //绘制UI界面
    [self createSuViewByPVDailyMortgageCheckNextView];
    
}

- (void)createSuViewByPVDailyMortgageCheckNextView
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
                break;
            case 11:
            {
                [cell ConfigCellWithTitle:_titleArray[i] itemArray:_itemArray2];
                [cell setSelectIndex:1];
                cell.needAdd = 0;
            }
                break;
            case 12:
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
                    @"当前贷款现状，是否出现逾期？逾期后厂商/经销商垫付情况？",
                    @"借款人的经营及财务情况是否正常（了解借款人的经营收入和资产的变化，了解借款人现金流情况是否与贷款金额成比例）？",
                    @"抵押车辆是否擅自转让、赠与、出租等",
                    @"抵押车辆是否发生过重大交通事故",
                    @"抵押车辆是否经过私自改装",
                    @"保险是否按期购买并确保我行为第一受益人",
                    @"挂靠单位的生产经营状况（如有）是否正常（借款人与挂靠单位是否发生纠纷等）",
                    @"担保人状况是否正常（担保人信用状况、担保能力是否出现变化）？",
                    @"借款人当前信用报告显示是否正常？",
                    @"借款人还款意愿有否变化？",
                    @"借款人是否有能力如期偿还贷款？",
                    @"了解借款人的家庭变化情况，是否会对贷款产生影响？"];
    
    //选项
    _itemArray2 = @[@"是",@"否"];
    
    //key 的 数组
    _keyArray = @[
                  @"isDocumentCare",
                  @"isOverdue",
                  @"isAffairs",
                  @"isTransfer",
                  @"isAccinent",
                  @"isRefitting",
                  @"isBuy",
                  @"isLineOperation",
                  @"isSecurity",
                  @"isCreditNormal",
                  @"isRepayChange",
                  @"isRepayAbility",
                  @"isLoanAffect"];
    
    //弹出 textField 的 key值数组   如果 为   @"" 则表示 不需要弹出任何输入框
    _infoArray = @[
                   @"documentCareInfo",
                   @"overdueInfo",
                   @"affairsInfo",
                   @"transferInfo",
                   @"accinentInfo",
                   @"refittingInfo",
                   @"buyInfo",
                   @"lineOperationInfo",
                   @"securityInfo",
                   @"creditNormalInfo",
                   @"repayChangeInfo",
                   @"repayAbilityInfo",
                   @"loanAffectInfo"];
    
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
    cell.keyString = @"signer";
    [cell setTextLength:[NSNumber numberWithInteger:3000]];
    cell.infoTextField.placeholder = @"客户签字";
    [viewArray addObject:cell];
    [scrollView addSubview:cell];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    scrollView.contentSize = 
}
@end
