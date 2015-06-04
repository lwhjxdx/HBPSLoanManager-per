//
//  TableInfoTableViewCell.h
//  HBPSLoanManager
//
//  Created by MC700 on 15/6/4.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *title = @"titleString";
static NSString *titleColor = @"titleColor";
@interface TableInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *changeIconLable;
@property (strong, nonatomic) IBOutlet UILabel *changeTileLable;
- (void)changeValueWithDic:(NSDictionary*)dic;
@end
