//
//  HBCheckDetailViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/10.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckDetailViewController.h"
#import "HBRepeatListViewController.h"
#import "MyCustomPickerView.h"
#import "HBUserModel.h"
#import "HBinspect/HBinspectViewController.h"
#import "HBCFirstViewController.h"
//#import "HBRepeatListViewController.h"

@interface HBCheckDetailViewController ()
{
    NSArray *planNoList;
    NSString *planNoString;
    NSArray *conNoList;
    NSString *conNoString;
    NSArray *conPaperIdList;
    NSString *conPaperString;
    UIWebView *phoneCallWebView;
    NSString *interfaceString;
}
@property (strong, nonatomic) IBOutlet UILabel *lable1;
@property (strong, nonatomic) IBOutlet UILabel *lable2;
@property (strong, nonatomic) IBOutlet UILabel *lable3;
@property (strong, nonatomic) IBOutlet UILabel *lable4;
@property (strong, nonatomic) IBOutlet UILabel *lable7;
@property (strong, nonatomic) IBOutlet UILabel *lable8;
@property (strong, nonatomic) IBOutlet UILabel *lable9;
@property (strong, nonatomic) IBOutlet UILabel *lable10;
@property (strong, nonatomic) IBOutlet UILabel *planNoLable;
- (IBAction)planNoSelctAction:(id)sender;

@end

@implementation HBCheckDetailViewController
#pragma mark - 初始化界面，回调网络数据，时时更新
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"检查";
    self.backButton.hidden = NO;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configUIWithDic];
    [self requestFromNetWorking];
}
- (void)configUIWithDic{
    if (_checkType==CheckTypeXiaoqiyefaren) {
        if (self.customerDic) {
            self.enterpriseName.text = self.customerDic[@"enterpriseName"];
            self.enterpriseAddr.text = self.customerDic[@"enterpriseAddr"];
            self.legalPerson.text = self.customerDic[@"legalPerson"];
            self.legalPersonTel.text = self.customerDic[@"legalPersonTel"];
            self.enterpriseLink.text = self.customerDic[@"enterpriseLink"];
            self.linkManTel.text = self.customerDic[@"linkManTel"];
            self.danger.text = self.customerDic[@"danger"];
            self.mainBiz.text = self.customerDic[@"mainBiz"];
            conNoList = [self.customerDic[@"conNo"] componentsSeparatedByString:@","];
            self.conNo.text = conNoList[0];
            conNoString = self.conNo.text;
        }
    }else{
        self.lable1.text = @"姓名";
        self.lable2.text = @"证件类型";
        self.lable3.text = @"证件号码";
        self.lable4.text = @"身份地址";
        self.lable8.text = @"联系电话";
        self.lable7.text = @"额度种类";
        self.lable9.text = @"贷款种类";
        self.lable10.text = @"授信额度";
        if (self.customerDic) {
            self.enterpriseName.text = self.customerDic[@"cusName"];
            self.enterpriseAddr.text = @"身份证";
            self.legalPerson.text = self.customerDic[@"certNo"];
            self.linkManTel.text = self.customerDic[@"mobilePhone"];
            self.legalPersonTel.text = self.customerDic[@"nativePlace"];
            
            
            
            conNoList = [self.customerDic[@"conNo"] componentsSeparatedByString:@","];
            self.conNo.text = conNoList[0];
            conNoString = self.conNo.text;
            
        }
    }
 
    
}

-(void)setCheckType:(CheckType)checkType
{
    _checkType = checkType;
    interfaceString = kfindGetParperInfo;
    switch (checkType) {
        case ChechTypeGerenchedai:
            interfaceString = kQueryCarBaseInfo;
            break;
        case CheckTypeGerenshangdai:
            interfaceString = kQueryPersonalBaseInfo;
            break;
            case CheckTypeXiaoqiyefaren:
            interfaceString = kInsertIndexCheckModel;
            break;
        default:
            break;
    }
}



#pragma mark - 界面点击事件
- (IBAction)callTelphone:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[HBUserModel getUserId] forKey:@"userId"];
    [dic setObject:self.linkManTel.text forKey:@"destTel"];
    [dic setObject:[HBUserModel getUserTel] forKey:@"srcTel"];

//    if (PAT_) {
//        [dic setObject:[HBUserModel getUserId] forKey:@"userId"];
//        [dic setObject:@"333" forKey:@"destTel"];
//        [dic setObject:@"73773" forKey:@"srcTel"];
//    }else{
//        [dic setObject:[HBUserModel getUserId] forKey:@"userId"];
//        [dic setObject:self.linkManTel.text forKey:@"destTel"];
//        [dic setObject:[HBUserModel getUserTel] forKey:@"srcTel"];
//    }

    [HBRequest RequestDataJointStr:kSaveVoiceCall parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
#warning 语音外呼
        NSString *telphoneString ;
        if (receiveJSON[@"restCallNum"]) {
            telphoneString = [NSString stringWithFormat:@"tel:%@",receiveJSON[@"restCallNum"]];
        }else{
            telphoneString = @"tel:400";
        }
        
        NSString *phoneNum = telphoneString;// 电话号码
        
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",phoneNum]];
        
        if ( !phoneCallWebView ) {
            
            phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的网页 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
        }
        
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        
    } failBlock:^(NSError *error) {
        
    }];
    
    
   
}
/**
 *  选择合同编号
 */
- (IBAction)changeCart:(id)sender {
    MyCustomPickerView *pick = [[MyCustomPickerView alloc] initWithFrame:CGRectZero];
    pick.contentArray =  [NSMutableArray arrayWithArray:conNoList];
    [pick pickerDataWithCancelBtnBlock:^(UIButton *btn) {
        
    } withDoneBtnBlock:^(NSInteger index, id receiveData) {
        self.conNo.text = conNoList[index];
        conNoString = self.conNo.text;
    } withChangedEventBlock:^(NSInteger index) {
        
    }];
    [pick showInView:self.view];
}
/**
 *  选择数据编号
*/
- (IBAction)checkPaperID:(id)sender {
    MyCustomPickerView *pick = [[MyCustomPickerView alloc] initWithFrame:CGRectZero];
    pick.contentArray =  [NSMutableArray arrayWithArray:conPaperIdList];
    [pick pickerDataWithCancelBtnBlock:^(UIButton *btn) {
        
    } withDoneBtnBlock:^(NSInteger index, id receiveData) {
        self.paperId.text = conPaperIdList[index];
        conPaperString = self.paperId.text;
        [self requestFromNetWorkingGettingPlanNo];
    } withChangedEventBlock:^(NSInteger index) {
        
    }];
    [pick showInView:self.view];
}




//检查报告录入
- (IBAction)repCheckClicked:(id)sender {

    [self requestFromNetWorkingWithFirstChecked];
}
-(void)pushHBinspectViewController:(NSDictionary*)dic
{
    if (_checkType == CheckTypeXiaoqiyefaren) {
        [self pushXiaoqiyefaren:dic];
    }else{
        [self pushGerenshangdai:dic];
    }
}

#pragma mark - 根据不同类型推向不同界面

-(void)pushXiaoqiyefaren:(NSDictionary*)dic
{
    
    HBinspectViewController *inspectVC = [[HBinspectViewController alloc] init];
    inspectVC.nextDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self pushViewController:inspectVC animated:YES];
}
-(void)pushGerenshangdai:(NSDictionary*)dic
{
    
    HBRepeatListViewController *inspectVC = [[HBRepeatListViewController alloc] init];
    inspectVC.customerDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    inspectVC.checkType = self.checkType;
    [self pushViewController:inspectVC animated:YES];
}
//-(void)pushGerenchedai:(NSDictionary*)dic
//{
//    
//    HBinspectViewController *inspectVC = [[HBinspectViewController alloc] init];
//    inspectVC.nextDic = [NSMutableDictionary dictionaryWithDictionary:dic];
//    [self pushViewController:inspectVC animated:YES];
//}
#pragma mark - 发送网络请求，处理相关数据
//从网络请求数据获取第一次检查
- (void)requestFromNetWorkingWithFirstChecked{
    
    NSMutableDictionary *dic = [self markParamsWithFirstChecked];
    if (!dic) {
        return;
    }
    [HBRequest RequestDataJointStr:interfaceString parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self handleDataFirst:receiveJSON];
        //测试
        self.customerDicWithData = (NSMutableDictionary *)receiveJSON;
//        NSLog(@"HBCheckDetailViewController->requestFromNetWorkingWithFirstChecked:%@",receiveJSON);
        
        _dictData = self.customerDicWithData;
        [self pushHBinspectViewController:_dictData];
//        NSLog(@"HBCheckDetailViewController->requestFromNetWorkingWithFirstChecked->customerDicWithData:%@",_dictData);
        
    } failBlock:^(NSError *error) {
        [self handleDataFirst:nil];
        
    }];
}


//配置参数获取第一次检查{"custId":"007","dueNum":"123","conNo":"2"}
- (NSMutableDictionary *)markParamsWithFirstChecked{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.customerDic[@"cusId"] forKey:@"custId"];
    [dic setObject:conPaperString forKey:@"dueNum"];
    [dic setObject:conNoString forKey:@"conNo"];
    return dic;
}


//处理数据
- (void)handleDataFirst:(NSDictionary *)FirstDic{
    NSMutableDictionary *tempFDic = [NSMutableDictionary dictionaryWithDictionary: self.customerDic];
    
    for (NSString *key in [FirstDic allKeys]) {
        [tempFDic setObject:[FirstDic objectForKey:key] forKey:key];
    }

}

//从网络请求数据获取数据编号
- (void)requestFromNetWorking{
    
    NSMutableDictionary *dic = [self markParams];
    if (!dic) {
        return;
    }
    [HBRequest RequestDataJointStr:kfindGetParperInfo parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self handleData:receiveJSON];
    } failBlock:^(NSError *error) {
        [self handleData:nil];
        
    }];
    if (_checkType!=CheckTypeXiaoqiyefaren) {
        [HBRequest RequestDataJointStr:@"/customerAction/getLoanInfo.do" parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
            [self handleData:receiveJSON[@"tCustomInfo"]];
        } failBlock:^(NSError *error) {
            [self handleData:nil];
            
        }];
    }
}


//配置参数获取数据编号
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:conNoString forKey:@"conNo"];
    return dic;
}
//处理数据
- (void)handleData:(NSDictionary *)dic{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary: self.customerDic];
    for (NSString *key in [dic allKeys]) {
        [tempDic setObject:[dic objectForKey:key] forKey:key];
    }
    self.customerDic = tempDic;
    conPaperIdList = [self.customerDic[@"dueNUM"] componentsSeparatedByString:@","];
    self.paperId.text = conPaperIdList[0];
    conPaperString  = self.paperId.text;
    self.enterpriseLink.text = self.customerDic[@"appOpName"];
    self.danger.text = self.customerDic[@"isNeedLimit"];
    self.mainBiz.text = self.customerDic[@"lineAmount"];
    [self requestFromNetWorkingGettingPlanNo];
}

- (NSNumber*)productType
{
    if (_checkType==CheckTypeXiaoqiyefaren) {
        return @1;
    }else if(_checkType == CheckTypeGerenshangdai){
        return @2;
    }else{
        return @3;
    }
}
- (NSMutableDictionary *)makePlanNoParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (PAT_) {
        [dic setObject:[HBUserModel getUserId] forKey:@"userNo"];
        if (![conNoString isEqualToString:@"全部"]) {
            [dic setObject:conNoString forKey:@"conNo"];
        }
//        if (![conPaperString isEqualToString:@"全部"]) {
//            [dic setObject:conPaperString forKey:@"dueNum"];
//        }
        [dic setObject:self.customerDic[@"cusId"] forKey:@"cusId"];
    }else{
        [dic setObject:@"161" forKey:@"userNo"];
    }
    [dic setObject:[self productType] forKey:@"productType"];
    [dic setObject:@0 forKey:@"checkPlanType"];
    [dic setObject:@(1) forKey:@"page"];
    [dic setObject:@(20) forKey:@"pageNo"];
    [dic setObject:@(0) forKey:@"checked"];
    [dic setObject:[HBUserModel getRoleName] forKey:@"roleName"];
    [dic setObject:[HBUserModel getUserInstitution] forKey:@"userInstitution"];
    [dic setObject:[self starStringfromDate] forKey:@"beginTime"];
    [dic setObject:[self endStringfromDate] forKey:@"endTime"];
    return dic;
}
- (void)requestFromNetWorkingGettingPlanNo{
    NSMutableDictionary *dic = [self makePlanNoParams];
    [HBRequest RequestDataJointStr:kGetCheckPlanList parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        if (!receiveJSON[@"planNO"]) {
            return;
        }
        planNoList = [receiveJSON[@"planNO"] componentsSeparatedByString:@","];
        planNoString = planNoList[0];
        self.planNoLable.text = planNoList[0];
    } failBlock:^(NSError *error) {

    }];
}

-(NSString*)starStringfromDate
{
    NSDateComponents *com = [self ca];
    return [NSString stringWithFormat:@"%@-%@-%@",@(com.year),@(com.month),@01];
}
-(NSString*)endStringfromDate
{
    NSCalendar *calenar = [NSCalendar currentCalendar];
    NSRange ra = [calenar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    NSDateComponents *com = [self ca];
    return [NSString stringWithFormat:@"%@-%@-%@",@(com.year),@(com.month),@(ra.length)];
}
- (NSDateComponents*)ca{
    NSCalendar *calenar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *coms = [calenar components:unitFlags fromDate:[NSDate date]];
    return coms;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)planNoSelctAction:(id)sender {
    if (planNoList) {
        MyCustomPickerView *pick = [[MyCustomPickerView alloc] initWithFrame:CGRectZero];
        pick.contentArray =  [NSMutableArray arrayWithArray:planNoList];
        [pick pickerDataWithCancelBtnBlock:^(UIButton *btn) {
            
        } withDoneBtnBlock:^(NSInteger index, id receiveData) {
            self.planNoLable.text = planNoList[index];
            planNoString = self.planNoLable.text;
        } withChangedEventBlock:^(NSInteger index) {
            
        }];
        [pick showInView:self.view];
    }
}
@end
