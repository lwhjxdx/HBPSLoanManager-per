//
//  HBPlanBaseViewController.m
//  HBPSLoanManager
//
//  Created by 上海高飞 on 15/5/7.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBPlanBaseViewController.h"

@interface HBPlanBaseViewController () <UITableViewDataSource, UITableViewDelegate>{

    CGFloat _topScvMinHeight;
    CGFloat _topScvMaxHeight;
    
}

@property (strong, nonatomic) UILabel *conLabel;
@property (strong, nonatomic) UIView *spacingView;

@end

@implementation HBPlanBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _isLoading = YES;
    self.backButton.hidden = NO;
    _topScvMinHeight = 150;
    _startIndex = 1;
    [self setupSubView];
    [self setupSpacingView];
    [self setupTableView];
    
    [self setupData];
    
    if (self.conLabel.text.length > 0) {
        [self requestFromNetWorking];
    }
}

- (void)setupData{
    
    NSArray  *conNoList = [self.customerDic[@"conNo"] componentsSeparatedByString:@","];
    self.conLabel.text = conNoList[0]?conNoList[0]:@"";
    
}

- (void)setupSubView{

    id navView = self.mBaseNavigationBarView;

    UITableView *tbView = [[UITableView alloc] init];
    tbView.translatesAutoresizingMaskIntoConstraints = NO;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.dataSource = self;
    tbView.delegate = self;
    tbView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:tbView];
    self.topTableView = tbView;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tbView]-0-|"
                                                                      options:NSLayoutFormatAlignAllTrailing
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(tbView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navView]-0-[tbView]"
                                                                      options:NSLayoutFormatAlignAllTrailing
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(navView, tbView)]];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:tbView
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1
                                                                     constant:0];
    bottomConstraint.priority = UILayoutPriorityDefaultLow;
    [self.view addConstraint:bottomConstraint];
    [self.view layoutIfNeeded];
    _topScvMaxHeight = CGRectGetHeight(tbView.frame);
    
    /*
    UILabel *lb = [[UILabel alloc] init];
    lb.translatesAutoresizingMaskIntoConstraints = NO;
    lb.font = [UIFont boldSystemFontOfSize:18.0];
    lb.backgroundColor = [UIColor clearColor];
    lb.textColor = [UIColor blackColor];
    lb.textAlignment = NSTextAlignmentLeft;
    lb.text = @"客户姓名";
    [topScv addSubview:lb];
    
    [topScv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[lb]-15-|"
                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(lb)]];
    
    [topScv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[lb]"
                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(lb)]];
    
    
    UILabel *nameLb = [[UILabel alloc] init];
    nameLb.translatesAutoresizingMaskIntoConstraints = NO;
    nameLb.font = [UIFont systemFontOfSize:16.0];
    nameLb.backgroundColor = [UIColor clearColor];
    nameLb.textColor = [UIColor lightGrayColor];
    nameLb.textAlignment = NSTextAlignmentLeft;
    nameLb.text = @"那扎";
    [topScv addSubview:nameLb];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:nameLb
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:lb
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                        constant:0]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:nameLb
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:lb
                                                       attribute:NSLayoutAttributeBaseline
                                                      multiplier:1.0
                                                        constant:10]];
    
    UIView *hLineView = [[UIView alloc] init];
    hLineView.translatesAutoresizingMaskIntoConstraints = NO;
    hLineView.backgroundColor = [UIColor grayColor];
    [topScv addSubview:hLineView];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:nameLb
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:hLineView
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                        constant:0]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:nameLb
                                                       attribute:NSLayoutAttributeRight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:topScv
                                                       attribute:NSLayoutAttributeRight
                                                      multiplier:1.0
                                                        constant:-10]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nameLb
                                                       attribute:NSLayoutAttributeBaseline
                                                      multiplier:1.0
                                                        constant:10]];
    
    CGFloat hLineWidth = CGRectGetWidth(self.view.frame) - 30;
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:hLineWidth]];

    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:0.5]];
    
    //合同编号
    UILabel *conNumLb = [[UILabel alloc] init];
    conNumLb.translatesAutoresizingMaskIntoConstraints = NO;
    conNumLb.font = [UIFont boldSystemFontOfSize:18.0];
    conNumLb.backgroundColor = [UIColor clearColor];
    conNumLb.textColor = [UIColor blackColor];
    conNumLb.textAlignment = NSTextAlignmentLeft;
    conNumLb.text = @"合同编号";
    [topScv addSubview:conNumLb];
    
    [topScv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[conNumLb]"
                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(conNumLb)]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:conNumLb
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:hLineView
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:15]];

    
    UILabel *conNumTapLb = [[UILabel alloc] init];
    conNumTapLb.translatesAutoresizingMaskIntoConstraints = NO;
    conNumTapLb.font = [UIFont boldSystemFontOfSize:18.0];
    conNumTapLb.backgroundColor = [UIColor clearColor];
    conNumTapLb.textColor = [UIColor blackColor];
    conNumTapLb.textAlignment = NSTextAlignmentLeft;
    //conNumTapLb.text = @"1341313413134131341313413134131341313413134131341313413134131341313413";
    [topScv addSubview:conNumTapLb];
    self.conLabel = conNumTapLb;
    
    [topScv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[conNumLb]-[conNumTapLb]"
                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(conNumLb, conNumTapLb)]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:conNumTapLb
                                                       attribute:NSLayoutAttributeCenterY
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:conNumLb
                                                       attribute:NSLayoutAttributeCenterY
                                                      multiplier:1
                                                        constant:0]];
    
    [topScv layoutIfNeeded];
    CGFloat contentLbWidth = CGRectGetWidth(self.view.frame) - CGRectGetMaxX(conNumLb.frame) - 15;
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:conNumTapLb
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeWidth
                                                      multiplier:1
                                                        constant:contentLbWidth]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:conNumTapLb
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1
                                                        constant:40]];
    
    
    UIButton *iconBtn1 = [[UIButton alloc] init];
    iconBtn1.translatesAutoresizingMaskIntoConstraints = NO;
    iconBtn1.userInteractionEnabled = NO;
    iconBtn1.backgroundColor = [UIColor clearColor];
    [iconBtn1 setBackgroundImage:[UIImage imageNamed:@"showinfo"] forState:UIControlStateNormal];
    [topScv addSubview:iconBtn1];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:iconBtn1
                                                       attribute:NSLayoutAttributeCenterY
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:conNumLb
                                                       attribute:NSLayoutAttributeCenterY
                                                      multiplier:1
                                                        constant:0]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:iconBtn1
                                                       attribute:NSLayoutAttributeRight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:conNumTapLb
                                                       attribute:NSLayoutAttributeRight
                                                      multiplier:1
                                                        constant:-10]];

    
    UIView *hLineView2 = [[UIView alloc] init];
    hLineView2.translatesAutoresizingMaskIntoConstraints = NO;
    hLineView2.backgroundColor = [UIColor grayColor];
    [topScv addSubview:hLineView2];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView2
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:hLineView
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                        constant:0]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView2
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:conNumLb
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:15]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView2
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:hLineWidth]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView2
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:0.5]];
    
    
    //借记号
    UILabel *dueNumLb = [[UILabel alloc] init];
    dueNumLb.translatesAutoresizingMaskIntoConstraints = NO;
    dueNumLb.font = [UIFont boldSystemFontOfSize:18.0];
    dueNumLb.backgroundColor = [UIColor clearColor];
    dueNumLb.textColor = [UIColor blackColor];
    dueNumLb.textAlignment = NSTextAlignmentLeft;
    dueNumLb.text = @"借记号";
    [topScv addSubview:dueNumLb];
    
    [topScv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[dueNumLb]"
                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(dueNumLb)]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:dueNumLb
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:hLineView2
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:15]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:dueNumLb
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:topScv
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:-15]];
    
    UILabel *dueNumTapLb = [[UILabel alloc] init];
    dueNumTapLb.translatesAutoresizingMaskIntoConstraints = NO;
    dueNumTapLb.font = [UIFont boldSystemFontOfSize:18.0];
    dueNumTapLb.backgroundColor = [UIColor clearColor];
    dueNumTapLb.textColor = [UIColor blackColor];
    dueNumTapLb.textAlignment = NSTextAlignmentLeft;
    dueNumTapLb.text = @"1341313413134131341313413134131341313413134131341313413134131341313413";
    [topScv addSubview:dueNumTapLb];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:dueNumTapLb
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:conNumTapLb
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1
                                                        constant:0]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:dueNumTapLb
                                                       attribute:NSLayoutAttributeCenterY
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:dueNumLb
                                                       attribute:NSLayoutAttributeCenterY
                                                      multiplier:1
                                                        constant:0]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:dueNumTapLb
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeWidth
                                                      multiplier:1
                                                        constant:contentLbWidth]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:dueNumTapLb
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1
                                                        constant:40]];
    
    
    UIButton *iconBtn2 = [[UIButton alloc] init];
    iconBtn2.translatesAutoresizingMaskIntoConstraints = NO;
    iconBtn2.userInteractionEnabled = NO;
    iconBtn2.backgroundColor = [UIColor clearColor];
    [iconBtn2 setBackgroundImage:[UIImage imageNamed:@"showinfo"] forState:UIControlStateNormal];
    [topScv addSubview:iconBtn2];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:iconBtn2
                                                       attribute:NSLayoutAttributeCenterY
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:dueNumTapLb
                                                       attribute:NSLayoutAttributeCenterY
                                                      multiplier:1
                                                        constant:0]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:iconBtn2
                                                       attribute:NSLayoutAttributeRight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:dueNumTapLb
                                                       attribute:NSLayoutAttributeRight
                                                      multiplier:1
                                                        constant:-10]];

    
    UIView *hLineView3 = [[UIView alloc] init];
    hLineView3.translatesAutoresizingMaskIntoConstraints = NO;
    hLineView3.backgroundColor = [UIColor grayColor];
    [topScv addSubview:hLineView3];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView3
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:hLineView
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                        constant:0]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView3
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:dueNumLb
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:15]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView3
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:hLineWidth]];
    
    [topScv addConstraint:[NSLayoutConstraint constraintWithItem:hLineView3
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:0.5]];
    
    //计算当前最少scrollview的高度
    [topScv layoutIfNeeded];
    _topScvMinHeight = CGRectGetMaxY(hLineView3.frame);
    
    self.topScvHeightConstraint = [NSLayoutConstraint constraintWithItem:topScv
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1
                                                                constant:_topScvMinHeight];
    [self.view addConstraint:self.topScvHeightConstraint];
    */
    
    self.topScvHeightConstraint = [NSLayoutConstraint constraintWithItem:self.topTableView
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1
                                                                constant:_topScvMinHeight];
    
    [self.view addConstraint:self.topScvHeightConstraint];

}

- (void)setupSpacingView{

    //中间点击视图
    UIView *spacingView = [[UIView alloc] init];
    spacingView.translatesAutoresizingMaskIntoConstraints = NO;
    spacingView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:spacingView];
    self.spacingView = spacingView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionOpenScv:)];
    [spacingView addGestureRecognizer:tap];
    
    UIButton *iconBtn = [[UIButton alloc] init];
    iconBtn.tag = 9;
    iconBtn.translatesAutoresizingMaskIntoConstraints = NO;
    iconBtn.userInteractionEnabled = NO;
    iconBtn.backgroundColor = [UIColor clearColor];
    [iconBtn setBackgroundImage:[UIImage imageNamed:@"showinfo"] forState:UIControlStateNormal];
    [spacingView addSubview:iconBtn];
    
    [spacingView addConstraint:[NSLayoutConstraint constraintWithItem:iconBtn
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:spacingView
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                             constant:0]];
    
    [spacingView addConstraint:[NSLayoutConstraint constraintWithItem:iconBtn
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:spacingView
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:5]];
    
    [spacingView addConstraint:[NSLayoutConstraint constraintWithItem:iconBtn
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:spacingView
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:-20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacingView
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self.topTableView
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                        constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacingView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.topTableView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    
    
    [self.view layoutIfNeeded];
    NSArray *titleArray = @[@"检查类型",@"开始日期",@"结束日期",@"检查方式",@"操作"];
    for (int i = 0; i < titleArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( i*(kSCREEN_WIDTH)/titleArray.count, CGRectGetMaxY(iconBtn.frame), (kSCREEN_WIDTH)/titleArray.count, 20)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:titleArray[i]];
        [label setTextColor:[UIColor whiteColor]];
        label.backgroundColor = RGBACOLOR(0, 88, 64, 1);
        [label setFont:[UIFont systemFontOfSize:13]];
        [spacingView addSubview:label];
        if (i>1&&i<4) {
            label.textAlignment = NSTextAlignmentRight;
        }
    }
    
    CGFloat spacingViewHeight = CGRectGetHeight(spacingView.frame);
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacingView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.topTableView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    
    _topScvMaxHeight = _topScvMaxHeight - spacingViewHeight;

    
}

- (void)actionOpenScv:(UITapGestureRecognizer *)tap {
    
    UIButton *iconbtn = (UIButton *)[tap.view viewWithTag:9];
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    if (iconbtn.selected == YES) {
        self.topScvHeightConstraint.constant = _topScvMinHeight;
         transform = CGAffineTransformIdentity;
    }else{
        self.topScvHeightConstraint.constant = _topScvMaxHeight;
        transform = CGAffineTransformRotate(iconbtn.transform, M_PI);
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        iconbtn.transform = transform;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        iconbtn.selected = !iconbtn.selected;
    }];
    
}

- (void)setupTableView{

    UITableView *tbView = [[UITableView alloc] init];
    tbView.translatesAutoresizingMaskIntoConstraints = NO;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.dataSource = self;
    tbView.delegate = self;
    tbView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:tbView];
    self.thisTableView = tbView;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tbView]-0-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(tbView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_spacingView]-0-[tbView]-0-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_spacingView ,tbView)]];


    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    //refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手更新数据"];
    [refreshControl addTarget:self action:@selector(reLoadData) forControlEvents:UIControlEventValueChanged];
    [self.thisTableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    [self.refreshControl beginRefreshing];
    [self.refreshControl endRefreshing];
}

#pragma mark - tableView delegate
#pragma mark delegate
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *cellIndentifier = @"cellIdentifier";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
//    
//    return cell;
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.thisArray.count + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
     
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
     }
     
     UILabel *textLabel = (UILabel *)[cell viewWithTag:9];
     textLabel.text = [self.thisArray objectAtIndex:indexPath.row];
     
     CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
     */
    
    return 50.0;
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    if (aScrollView == self.thisTableView) {
        
        CGPoint offset = aScrollView.contentOffset;
        CGRect bounds = aScrollView.bounds;
        CGSize size = aScrollView.contentSize;
        UIEdgeInsets inset = aScrollView.contentInset;
        CGFloat y = offset.y + bounds.size.height - inset.bottom;
        CGFloat h = size.height;
        
        float reload_distance = 15;
        if(y > h + reload_distance) {
            
            if (_hasMoreData == YES && _isLoading == NO) {
                self.thisTableView.tableFooterView.hidden = NO;
                [self loadMoreData];
            }
        }
    }
}

- (void)reLoadData{
    
    //[self cancelAllRequest];
    _startIndex = 1;
    [self.refreshControl beginRefreshing];
    _isLoading = YES;
    [self requestFromNetWorking];
}


- (void)loadMoreData{

    //加截分页前把起始页+1
    _startIndex++;
    [self requestFromNetWorking];
}

#pragma mark request
- (NSMutableDictionary *)makeParams{
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    if (PAT_) {
//        
//        [dic setObject:[HBUserModel getUserId] forKey:@"userNo"];
//        if (self.conLabel.text.length > 0) {
//            [dic setObject:self.conLabel.text forKey:@"conNo"];
//        }
//        [dic setObject:self.customerDic[@"cusId"] forKey:@"cusId"];
//        
//    }else{
//        [dic setObject:@"161" forKey:@"userNo"];
//    }
//    
//    //新增分页字段
//    [dic setObject:@(_startIndex) forKey:@"page"];      //开始页
//    [dic setObject:@(_startIndex + _pageSize - 1) forKey:@"pageNo"];    //结束页
    
    return nil;
}

- (void)requestFromNetWorking{
    
//    NSMutableDictionary *dic = [self makeParams];
//    
//    [HBRequest RequestDataJointStr:kGetCheckPlanList parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
//        [self handleData:receiveJSON];
//    } failBlock:^(NSError *error) {
//        
//    }];
    

}

- (void)handleData:(NSDictionary *)dic{
    
    //
    
    if (dic[@"checkPlanList"]) {
        self.thisArray = dic[@"checkPlanList"];
    }else{
       //lableStringArray3 = [NSArray array];
    }
    [self.thisTableView reloadData];
}



@end
