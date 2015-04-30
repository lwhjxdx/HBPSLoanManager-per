//
//  HBCheckCalenderMoreCell.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBCheckCalenderMoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *checkTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

- (void)setParams:(NSDictionary *)dic;

@end
