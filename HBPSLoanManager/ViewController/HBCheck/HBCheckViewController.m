//
//  HBCheckViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckViewController.h"
#import "LoanLegalPerson/LoanLegalViewController.h"
#import "LoanPersonage/LoanPersonageController.h"
#import "LoanPersonageCar/LoanPersonageCarController.h"
#import "HBSignInController.h"
@interface HBCheckViewController ()
@end

@implementation HBCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableViewForResult:CGRectZero];
    self.tableView.scrollEnabled = NO;
    self.titleLabel.text = _titleString;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"helloCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _tableViewArr[indexPath.row][0];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushQiandaoVC:NSClassFromString(_tableViewArr[indexPath.row][1])];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
/**
 *  推向签到页面
 *
 *  @param class 签到下一个页面的class，不支持该界面向下一个界面传值，如需传值请想办法
 */
-(void)pushQiandaoVC:(Class)class
{
#warning 暂时关闭定位
//    HBSignInController *qiandaoVC = [[HBSignInController alloc]init];
//    qiandaoVC.isShowNextItem = YES;
//    qiandaoVC.classString = class;
//    [self.navigationController pushViewController:qiandaoVC animated:YES];
    
    
    [self.navigationController pushViewController:[[class alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//dueNum //借据编号
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:NO];
}

@end
