//
//  HBPlanComInfoCell.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/17.
//  Copyright (c) 2015年 YM. All rights reserved.
//

typedef void (^HBPlanComInfoBtnClicked)(NSDictionary *dic) ;

#import <UIKit/UIKit.h>


@interface HBPlanComInfoCell : UITableViewCell

{
    NSDictionary *_userDic;
    HBPlanComInfoBtnClicked _click;
}
@property (weak, nonatomic) IBOutlet UIButton *importBtn;
@property (weak, nonatomic) IBOutlet UILabel *checkType;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endData;

- (void)loadData:(NSMutableDictionary *)dic;

- (void)setComInfoClicked:(HBPlanComInfoBtnClicked)click;

@end
