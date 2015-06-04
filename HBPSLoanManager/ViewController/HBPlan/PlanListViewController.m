//
//  PlanListViewController.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/6/4.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "PlanListViewController.h"
#import "HBPlanComInfoCell.h"

@interface PlanListViewController ()

@end

@implementation PlanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBaseTableView];
}
//-(void)setListArray:(NSArray *)listArray
//{
//    _listArray = listArray;
//    if (self.baseTableView) {
//        [self.baseTableView reloadData];
//    }
//}
-(void)initBaseTableView
{
    self.baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    [self.view addSubview:self.baseTableView];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(44, 0, 0, 0));
    }];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *spacingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
    NSArray *titleArray = @[@"检查类型",@"开始日期",@"结束日期",@"检查方式",@"操作"];
    for (int i = 0; i < titleArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( i*(kSCREEN_WIDTH)/titleArray.count, 0, (kSCREEN_WIDTH)/titleArray.count, 20)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:titleArray[i]];
        [label setTextColor:[UIColor whiteColor]];
        label.backgroundColor = RGBACOLOR(0, 88, 64, 1);
        [label setFont:[UIFont systemFontOfSize:13]];
        [spacingView addSubview:label];
        if (i>1&&i<4) {
            label.textAlignment = NSTextAlignmentRight;
        }
    }
    spacingView.backgroundColor = KMainColor;
    return spacingView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_listArray) {
        return _listArray.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBPlanComInfoCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([HBPlanComInfoCell class])];
    
    HBPlanComInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBPlanComInfoCell class]) forIndexPath:indexPath];
    [cell loadData:_listArray[indexPath.row]];
    
    [((HBPlanComInfoCell *)cell) setComInfoClicked:^(NSDictionary *dic) {
//        [self requestFromNetWorkingToJump:dic];
    }];

    return cell;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
