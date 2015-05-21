//
//  HaveDelImageView.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/19.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HaveDelImageView.h"
#import "Masonry.h"
@implementation HaveDelImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)awakeFromNib
{
    // Drawing code
    [self addSubview:self.delBtn];
    CGFloat wigth = 22;
    [_delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(wigth/2);
        make.top.equalTo(self.mas_top).offset(-wigth/2);
        make.size.mas_equalTo(CGSizeMake(wigth, wigth));
    }];
    _delBtn.layer.cornerRadius = wigth / 2;
    _delBtn.layer.masksToBounds = YES;
}
-(UIButton*)delBtn
{
    if (!_delBtn) {
        self.delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delBtn setBackgroundImage:[UIImage imageNamed:@"ic_clear_image_pressed"] forState:UIControlStateNormal];
        _delBtn.backgroundColor = [UIColor redColor];
    }
    return _delBtn;
}
@end
