//
//  HBPlanComInfoCell.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/17.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPlanComInfoCell.h"

@implementation HBPlanComInfoCell

- (void)awakeFromNib {
    self.importBtn.layer.cornerRadius = 3;
    self.importBtn.layer.masksToBounds = YES;
    self.importBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.importBtn.layer.borderWidth = 1.0f;
    [self.importBtn addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData:(NSMutableDictionary *)dic{
    _userDic = dic;

    NSInteger checkType = [[_userDic objectForKey:@"checkType"] integerValue];

    self.checkType.text = [self chectStringWithType:checkType];
    self.startDate.text = [_userDic objectForKey:@"checkBeginTime"];
    self.endData.text = [_userDic objectForKey:@"checkEndTime"];
}
- (NSString*)chectStringWithType:(NSInteger)type
{
    if (type>8) {
        return @"";
    }
    NSArray *tempArr = @[@"半年检查",
                         @"首次检查",
                         @"例行检查",
                         @"逾期催收",
                         @"还款落实检查",
                         @"额度年检",
                         @"抽查",
                         @"全面检查"];
//    switch (type) {
//        case 1:
//        {
//            checkString = @"首次检查";
//        }
//            break;
//        case 2:
//        {
//            checkString = @"例行检查";
//        }
//            break;
//            
//        case 3:
//        {
//            checkString = @"全面检查";
//        }
//            break;
//            
//        case 4:
//        {
//            checkString = @"跟踪检查";
//        }
//            break;
//        case 5:
//            checkString = @"现场催收";
//            break;
//            
//        case 6:
//        {
//            checkString = @"例行检查";
//        }
//            break;
//            
//        case 7:
//        {
//            checkString = @"全面检查";
//        }
//            break;
//            
//        case 8:
//        {
//            checkString = @"跟踪检查";
//        }
//            break;
//        default:
//            break;
//    }
    return tempArr[type-1];
}
- (void)setComInfoClicked:(HBPlanComInfoBtnClicked)click{
    _click = click;
}

- (void)clicked:(UIButton *)btn{
    if (_click) {
        _click(_userDic);
    }
}



@end
