//
//  MainColecthionTableViewCell.h
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectItemBlock)(NSDictionary *dic,NSInteger selectIndex);
@interface MainColecthionTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray *itemArr;
@property(nonatomic,copy)SelectItemBlock selecBlock;
//-(void)setSelectItemBlock:(SelectItemBlock)block;
@end
