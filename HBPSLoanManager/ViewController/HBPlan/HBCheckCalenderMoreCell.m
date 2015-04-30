//
//  HBCheckCalenderMoreCell.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckCalenderMoreCell.h"

@implementation HBCheckCalenderMoreCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setParams:(NSDictionary *)dic{
    
    self.startTypeLabel.text    = dic[@"checkBeginTime"];
    self.endTypeLabel.text      = dic[@"checkEndTime"];
    self.checkTypeLabel.text    = dic[@"checkPlanType"];
}

@end
