//
//  ImageWithDelCollectionViewCell.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/19.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "ImageWithDelCollectionViewCell.h"
#import "Masonry.h"
@implementation ImageWithDelCollectionViewCell
-(instancetype)init
{
    if (self= [super init]) {
        [self.contentView addSubview:self.midleImageView];
        [self.contentView addSubview:self.delBtn];
        [_midleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}
-(UIImageView *)midleImageView
{
    if (!_midleImageView) {
        self.midleImageView = [[UIImageView alloc]init];
    }
    return _midleImageView;
}
@end
