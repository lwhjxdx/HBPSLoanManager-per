//
//  HBBaseSearchTableViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/10.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"
#define kSearchBarHigh 40

typedef void (^SearchData)(NSString *searchString);
@interface HBBaseSearchTableViewController : HBBaseViewController<UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,copy) SearchData search;

//初始化SearchBar
- (void)initSearchView:(NSString *)placeholder SearchClicked:(SearchData)s;



//初始化Tableview
- (void)initTableViewForResult:(CGRect)rect;

@end
