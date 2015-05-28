//
//  HBCheckCalenderMoreViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckCalenderMoreViewController.h"
#import "HBCheckCalenderMoreCell.h"
@interface HBCheckCalenderMoreViewController ()
{
    NSMutableArray *dataArray;
}
@end

@implementation HBCheckCalenderMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"检查日历";

    self.hbCheckTableView.delegate = self;
    self.hbCheckTableView.dataSource =self;
    self.hbCheckTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backButton.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBCheckCalenderMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDE"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HBCheckCalenderMoreCell" owner:self options:nil] lastObject];
    }
    [cell setParams:[dataArray objectAtIndex:(int)indexPath.row]];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row];;
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    return cell;
}


- (IBAction)hbAlreadyCheckClicked:(id)sender {
    [self changeImage:alreadyCheck];
}

- (IBAction)hbNoCheckClicked:(id)sender {
    [self changeImage:noCheck];
}

- (void)changeImage:(CheckButtonTag)tag{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (PAT_) {
        [dic setObject:[HBUserModel getUserId] forKey:@"userNo"];
    }else{
        [dic setObject:@"161" forKey:@"userNo"];
    }

    if(tag == alreadyCheck){
        self.hbAlreadyCheckLabel.textColor = RGBACOLOR(122, 153, 136, 1);
        self.hbNoCheckLabel.textColor = RGBACOLOR(178, 178, 178, 1);
        CGRect rect  = self.hbColorView.frame;
        rect.origin.x  = 20;
        [UIView animateWithDuration:0.3 animations:^{
            self.hbColorView.frame = rect;
        }];
        [dic setObject:@"1" forKey:@"checked"];
    }
    else if(tag == noCheck){
        self.hbAlreadyCheckLabel.textColor = RGBACOLOR(178, 178, 178, 1);
        self.hbNoCheckLabel.textColor = RGBACOLOR(122, 153, 136, 1);
        CGRect rect  = self.hbColorView.frame;
        rect.origin.x  = kSCREEN_WIDTH/2;
        [UIView animateWithDuration:0.3 animations:^{
            self.hbColorView.frame = rect;
        }];
        [dic setObject:@"0" forKey:@"checked"];
    }
    
    if (self.conNoString) {
        [dic setObject:self.conNoString forKey:@"conNo"];
    }
    
    [HBRequest RequestDataJointStr:kGetCheckPlanList parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self handleData:receiveJSON];

    } failBlock:^(NSError *error) {
        [self handleData:nil];
    }];
}


////从网络请求数据
//- (void)requestFromNetWorking{
//    NSMutableDictionary *dic = [self markParams];
//    if (!dic) {
//        return;
//    }
//    [HBRequest RequestDataJointStr:kFindCustInfo parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
//        [self handleData:receiveJSON];
//        
//    } failBlock:^(NSError *error) {
//        
//    }];
//    
//    
//}
//
////配置参数
//- (NSMutableDictionary *)markParams{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    return dic;
//}

//处理数据
- (void)handleData:(NSDictionary *)jsonDic{
    
    if (dataArray == nil) {
        dataArray = [NSMutableArray array];
    }
    
    if (jsonDic[@"checkPlanList"]) {
        dataArray = [NSMutableArray arrayWithArray: jsonDic[@"checkPlanList"]];
    }
    [self.hbCheckTableView reloadData];
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeImage:alreadyCheck];
}


@end
