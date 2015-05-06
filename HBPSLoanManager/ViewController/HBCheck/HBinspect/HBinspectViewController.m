//
//  HBinspectViewController.m
//  HBPSLoanManager
//
//  Created by QC on 15-4-23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBinspectViewController.h"
#import "HBCFirstViewController.h"
#import "HBRoutineFirstViewController.h"
#import "HBAllCheckViewController.h"
#import "HBPayBackCheckFirstViewController.h"
#import "HBLocaleCollectionCheckViewController.h"
@interface HBinspectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *infoTableView;
@property (strong, nonatomic)  NSArray *infoTableViewArr;
@end

@implementation HBinspectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.infoTableViewArr = @[@"首次检查",@"例行检查",@"全面检查",@"还款资金落实检查",@"现场催收"];
    self.titleLabel.text = @"检查报告录入";
    self.infoTableView.frame = CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT - 64);
//    _infoTableView.backgroundColor = [UIColor redColor];
//    [self requestFromNetWorking];
    

}
- (IBAction)fristCheck:(id)sender {
    HBCFirstViewController *fristVC = [[HBCFirstViewController alloc] init];
    fristVC.userDic = self.nextDic;
    [self pushViewController:fristVC animated:YES];
}
- (IBAction)routineCheck:(id)sender {
    HBRoutineFirstViewController *routineVC = [[HBRoutineFirstViewController alloc] init];
    routineVC.userDic = self.nextDic;
    [self pushViewController:routineVC animated:YES];
}
- (IBAction)totalCheck:(id)sender {
    HBAllCheckViewController *allVC = [[HBAllCheckViewController alloc] init];
    allVC.userDic = self.nextDic;
    [self pushViewController:allVC animated:YES];
}
- (IBAction)practicableCheck:(id)sender {
    HBPayBackCheckFirstViewController *payVC = [[HBPayBackCheckFirstViewController alloc] init];
    payVC.userDic = self.nextDic;
    [self pushViewController:payVC animated:YES];
}
- (IBAction)collectionCheck:(id)sender {
    HBLocaleCollectionCheckViewController *nextCheckVC = [[HBLocaleCollectionCheckViewController alloc] init];
    nextCheckVC.userDic = self.nextDic;
    [self pushViewController:nextCheckVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//从网络请求数据
- (void)requestFromNetWorking{
    NSMutableDictionary *dic = [self markParams];
    if (!dic) {
        return;
    }
    [HBRequest RequestDataJointStr:kInsertIndexCheckModel parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        
    } failBlock:^(NSError *error) {
        
    }];

    
}

//配置参数
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return dic;
    NSLog(@"%@======",dic);
    
}

////处理数据
//- (NSMutableDictionary *)handleDataToJump:(NSDictionary *)dic withDic:(NSDictionary *)oldDic{
//    
//    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary: oldDic];
//    
//    for (NSString *key in [dic allKeys]) {
//        [tempDic setObject:[dic objectForKey:key] forKey:key];
//    }
//    return tempDic;
//    NSLog(@"=================%@",tempDic);
//}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"%@",indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _infoTableViewArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self fristCheck:nil];
            break;
        case 1:
            [self routineCheck:nil];
            break;
        case 2:
            [self totalCheck:nil];
            break;
        case 3:
            [self practicableCheck:nil];
            break;
        case 4:
            [self collectionCheck:nil];
            break;
            
        default:
            break;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:YES];
}
@end
