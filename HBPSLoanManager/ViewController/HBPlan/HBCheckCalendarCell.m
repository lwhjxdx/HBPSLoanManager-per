//
//  HBCheckCalendarCell.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//  检查日历

#import "HBCheckCalendarCell.h"

@implementation HBCheckCalendarCell

- (void)awakeFromNib {
    self.moreButton.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)moreClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(hbCheckCalendarMoreClicked:)]) {
        [self.delegate hbCheckCalendarMoreClicked:dataDic];
    }

}

- (void)setParams:(NSDictionary *)dic{
    dataDic = dic;
    self.companyNameLabel.text = dic[@"custName"];
    self.kindLabel.text = dic[@"amountType"];

    self.typeLabel.text = dic[@"checkType"];
    self.startTimeLabel.text = dic[@"checkBeginTime"];
    self.endTimeLabel.text = dic[@"checkEndTime"];
    self.checkTypeLabel.text = dic[@"checkPlanType"];
    
}




@end
