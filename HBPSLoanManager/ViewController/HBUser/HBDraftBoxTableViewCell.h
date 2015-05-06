//
//  HBDraftBoxTableViewCell.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/14.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBReportModel.h"
#import "DBManager.h"
@protocol HBDraftBoxCellDelegate <NSObject>

- (void)cellChangeClicked:(NSDictionary *)dic;

@end

@interface HBDraftBoxTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *hbtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hbContentLabel;
@property (nonatomic, assign) id<HBDraftBoxCellDelegate> delegate;

@property BOOL isSelect;

@property (nonatomic,strong) HBReportModel *model;

- (void)configerCellWithData:(HBReportModel *)model;

@end
