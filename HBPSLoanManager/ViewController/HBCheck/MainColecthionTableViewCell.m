//
//  MainColecthionTableViewCell.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "MainColecthionTableViewCell.h"
#import "ShowImageItemCollectionViewCell.h"

@interface MainColecthionTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *layoutColection;
@property (strong, nonatomic) IBOutlet UICollectionView *showInfoCollectionView;
@end
@implementation MainColecthionTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    [self.showInfoCollectionView registerClass:[ShowImageItemCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ShowImageItemCollectionViewCell class])];
    [_showInfoCollectionView registerClass:[ShowImageItemCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ShowImageItemCollectionViewCell class])];

    self.showInfoCollectionView.delegate = self;
    self.showInfoCollectionView.dataSource = self;
    self.layoutColection.itemSize = CGSizeMake(kSCREEN_WIDTH / numItemOfRow, itemHeigth);
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([ShowImageItemCollectionViewCell class]) bundle:[NSBundle mainBundle]];
    [self.showInfoCollectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([ShowImageItemCollectionViewCell class])];
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (_itemArr)?_itemArr.count:3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShowImageItemCollectionViewCell *cell = (ShowImageItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShowImageItemCollectionViewCell class]) forIndexPath:indexPath];
    cell.iconImage.image = [UIImage imageNamed:_itemArr[indexPath.item][@"image"]];
    cell.titleLable.text = _itemArr[indexPath.item][@"title"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selecBlock) {
        _selecBlock(_itemArr[indexPath.item],indexPath.item);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
