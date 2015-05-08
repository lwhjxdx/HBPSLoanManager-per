//
//  HBPersonInfoViewController.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/8.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPersonInfoViewController.h"
#import "HBPlanComInfoCell.h"
#import "MyCustomPickerView.h"

@interface HBPersonInfoViewController ()

@end

@implementation HBPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView != self.topTableView) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 35;
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.topTableView) {
        return self.topArray.count;
    }else{
        if (self.thisArray) {
            return self.thisArray.count;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    if (tableView == self.topTableView) {
        
        NSString *cellString = [NSString stringWithFormat:@"%@",indexPath];
        cell = [tableView dequeueReusableCellWithIdentifier:cellString];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellString];
        }
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        cell.contentView.backgroundColor = RGBACOLOR(247, 247, 247, 1);
        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:13]];
        [cell.detailTextLabel setTextColor:[UIColor grayColor]];
        
//        
//        for (UIView *view in [cell.contentView subviews]) {
//            [view removeFromSuperview];
//        }
        cell.textLabel.text = self.topArray[indexPath.row];
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\t\t",self.topArray[indexPath.row]];
            
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 30, cell.frame.size.height/2 - 10, 25, 20)];
            view.image = [UIImage imageNamed:@"dot3"];
            [cell.contentView addSubview:view];
        }else{
            cell.detailTextLabel.text = self.topArray[indexPath.row];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"IDE1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HBPlanComInfoCell" owner:self options:nil] lastObject];
        }
        [((HBPlanComInfoCell *)cell) loadData:self.thisArray[indexPath.row]];
        
        [((HBPlanComInfoCell *)cell) setComInfoClicked:^(NSDictionary *dic) {
//            [self requestFromNetWorkingToJump:dic];
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
