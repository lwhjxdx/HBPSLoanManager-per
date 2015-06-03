//
//  MainColecthionTableViewCell.h
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
//每行显示item个数
#define numItemOfRow 4
//每行item的高度
#define itemHeigth   100
typedef void(^SelectItemBlock)(NSDictionary *dic,NSInteger selectIndex);

@interface MainColecthionTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray *itemArr;
@property(nonatomic,copy)SelectItemBlock selecBlock;
//-(void)setSelectItemBlock:(SelectItemBlock)block;
@end
