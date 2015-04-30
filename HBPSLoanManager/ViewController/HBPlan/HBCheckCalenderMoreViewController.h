//
//  HBCheckCalenderMoreViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/12.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"

typedef NS_ENUM(NSUInteger, CheckButtonTag) {
    alreadyCheck,
    noCheck
};

@interface HBCheckCalenderMoreViewController : HBBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *hbAlreadyCheckLabel;

@property (weak, nonatomic) IBOutlet UILabel *hbNoCheckLabel;

@property (weak, nonatomic) IBOutlet UIView *hbColorView;

@property (weak, nonatomic) IBOutlet UITableView *hbCheckTableView;


@property (nonatomic,copy) NSString *conNoString;

- (IBAction)hbAlreadyCheckClicked:(id)sender;

- (IBAction)hbNoCheckClicked:(id)sender;

@end
