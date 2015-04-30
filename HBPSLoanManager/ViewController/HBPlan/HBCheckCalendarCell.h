//
//  HBCheckCalendarCell.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HBCheckCalendarDelegate <NSObject>

- (void)hbCheckCalendarMoreClicked:(NSDictionary *)dic;

@end

@interface HBCheckCalendarCell : UITableViewCell
{
    NSDictionary *dataDic;
}
@property (nonatomic,weak) id<HBCheckCalendarDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *kindLabel;

@property (weak, nonatomic) IBOutlet UILabel *checkTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

- (void)setParams:(NSDictionary *)dic;

@end
