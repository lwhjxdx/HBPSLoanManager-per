//
//  ShowImageItemCollectionViewCell.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "ShowImageItemCollectionViewCell.h"

@implementation ShowImageItemCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.cornerRadius = 2.f;
}

@end
