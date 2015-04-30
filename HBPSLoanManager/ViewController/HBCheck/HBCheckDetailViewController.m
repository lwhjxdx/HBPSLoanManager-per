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
#import "HBSignInController.h"

@interface HBCheckDetailViewController ()
{
    NSArray *conNoList;
    NSString *conNoString;
    NSArray *conPaperIdList;
    NSString *conPaperString;
    UIWebView *phoneCallWebView;
}
@end

@implementation HBCheckDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"检查";
    self.backButton.hidden = NO;
    
    
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
}


//配置参数获取数据编号
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:conNoString forKey:@"conNo"];
    return dic;
}



- (IBAction)callTelphone:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    if (PAT_) {
        [dic setObject:[HBUserModel getUserId] forKey:@"userId"];
        [dic setObject:@"333" forKey:@"destTel"];
        [dic setObject:@"73773" forKey:@"srcTel"];
    }else{
        [dic setObject:@"161" forKey:@"userId"];
        [dic setObject:self.linkManTel.text forKey:@"destTel"];
        [dic setObject:[HBUserModel getUserTel] forKey:@"srcTel"];
    }

    [HBRequest RequestDataJointStr:kSaveVoiceCall parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        
#warning 语音外呼
        NSString *telphoneString ;
        if (receiveJSON[@"cSNumber"]) {
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
//选择合同编号
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
//选择数据编号
- (IBAction)checkPaperID:(id)sender {
    MyCustomPickerView *pick = [[MyCustomPickerView alloc] initWithFrame:CGRectZero];
    pick.contentArray =  [NSMutableArray arrayWithArray:conPaperIdList];
    [pick pickerDataWithCancelBtnBlock:^(UIButton *btn) {
        
    } withDoneBtnBlock:^(NSInteger index, id receiveData) {
        self.paperId.text = conPaperIdList[index];
        conPaperString = self.paperId.text;
    } withChangedEventBlock:^(NSInteger index) {
        
    }];
    [pick showInView:self.view];
}


//从网络请求数据获取第一次检查
- (void)requestFromNetWorkingWithFirstChecked{
    
    NSMutableDictionary *dic = [self markParamsWithFirstChecked];
    if (!dic) {
        return;
    }
    [HBRequest RequestDataJointStr:kInsertIndexCheckModel parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self handleDataFirst:receiveJSON];
        //测试
        self.customerDicWithData = (NSMutableDictionary *)receiveJSON;
        NSLog(@"HBCheckDetailViewController->requestFromNetWorkingWithFirstChecked:%@",receiveJSON);
        
        _dictData = self.customerDicWithData;
        [self pushHBinspectViewController:_dictData];
        NSLog(@"HBCheckDetailViewController->requestFromNetWorkingWithFirstChecked->customerDicWithData:%@",_dictData);
        
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


//检查报告录入
- (IBAction)repCheckClicked:(id)sender {

    [self requestFromNetWorkingWithFirstChecked];
}
-(void)pushHBinspectViewController:(NSDictionary*)dic
{
    HBinspectViewController *inspectVC = [[HBinspectViewController alloc] init];
    inspectVC.nextDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self pushViewController:inspectVC animated:YES];
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
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:@"YES"];
}

- (void)viewDidAppear:(BOOL)animated{
    [self configUIWithDic];
    [self requestFromNetWorking];
}

- (void)configUIWithDic{
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
