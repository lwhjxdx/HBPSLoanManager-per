//
//  HBCheckDetailViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/10.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"
#import "HBType.h"

@interface HBCheckDetailViewController : HBBaseViewController

- (IBAction)callTelphone:(id)sender;

@property (nonatomic,copy) NSMutableDictionary *customerDic;
@property (nonatomic,copy) NSMutableDictionary *customerDicWithData;
@property (nonatomic,copy) NSDictionary *dictData;
@property (nonatomic,assign)CheckType checkType;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseAddr;

@property (weak, nonatomic) IBOutlet UILabel *legalPerson;

@property (weak, nonatomic) IBOutlet UILabel *legalPersonTel;

@property (weak, nonatomic) IBOutlet UILabel *conNo;

@property (weak, nonatomic) IBOutlet UILabel *enterpriseLink;
@property (weak, nonatomic) IBOutlet UILabel *linkManTel;
@property (weak, nonatomic) IBOutlet UILabel *danger;
@property (weak, nonatomic) IBOutlet UILabel *mainBiz;
@property (weak, nonatomic) IBOutlet UILabel *paperId;

@end
