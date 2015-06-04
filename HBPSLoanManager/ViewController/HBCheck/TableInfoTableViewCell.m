//
//  TableInfoTableViewCell.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/6/4.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "TableInfoTableViewCell.h"

@implementation TableInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.changeIconLable.layer.cornerRadius = 17.f;
    self.changeIconLable.layer.masksToBounds = YES;
}
- (void)changeValueWithDic:(NSDictionary*)dic{
    _changeIconLable.backgroundColor = dic[titleColor];
    _changeTileLable.textColor = dic[titleColor];
    _changeTileLable.text = dic[title];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
