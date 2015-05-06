//
//  HBDraftBoxTableViewCell.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/14.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBDraftBoxTableViewCell.h"

@implementation HBDraftBoxTableViewCell

- (void)awakeFromNib {

  
    [self.selectBtn addTarget:self action:@selector(chageImage:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)chageImage:(UIButton *)btn{
    self.isSelect = !self.isSelect;
    if (self.isSelect) {
        [btn setImage:[UIImage imageNamed:@"checked"] forState:(UIControlStateNormal)];
        _model.isSelect = @"YES";
    }else{
        [btn setImage:[UIImage imageNamed:@"unChecked"] forState:(UIControlStateNormal)];
        _model.isSelect = @"NO";
    }
    ;

    if ([[DBManager shareManager] updateWithModel:_model]&&[self.delegate respondsToSelector:@selector(cellChangeClicked:)]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self forKey:@"cell"];
        [self.delegate cellChangeClicked:dic];
    }
}


- (void)configerCellWithData:(HBReportModel *)model{
    
    self.model = model;
    self.hbtitleLabel.text = model.titleString;
    self.hbContentLabel.text = model.contentString;
    if ([model.isSelect isEqualToString:@"YES"]) {
        self.isSelect = YES;
        [self.selectBtn setImage:[UIImage imageNamed:@"checked"] forState:(UIControlStateNormal)];
    }else{
        self.isSelect = NO;
        [self.selectBtn setImage:[UIImage imageNamed:@"unChecked"] forState:(UIControlStateNormal)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
