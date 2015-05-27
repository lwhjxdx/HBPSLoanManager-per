//
//  HBPlanBaseViewController.h
//  HBPSLoanManager
//
//  Created by Nk on 15/5/7.
//  Copyright (c) 2015年 Nk. All rights reserved.
//

#import "HBBaseViewController.h"

@interface HBPlanBaseViewController : HBBaseViewController{

    //新赠分页字段
    NSInteger _startIndex; //1;
    NSInteger _pageSize;  
    BOOL _hasMoreData;
    BOOL _isLoading;
}

@property (strong, nonatomic) NSDictionary *customerDic;

@property (strong, nonatomic) UITableView *topTableView;
@property (strong, nonatomic) NSMutableArray *topArray;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *thisArray;
@property (strong, nonatomic) UITableView *thisTableView;

@property (strong, nonatomic) NSLayoutConstraint *topScvHeightConstraint;
- (NSMutableDictionary *)makeParams;
- (void)requestFromNetWorking;
- (void)reLoadData;
- (void)loadMoreData;
@end
