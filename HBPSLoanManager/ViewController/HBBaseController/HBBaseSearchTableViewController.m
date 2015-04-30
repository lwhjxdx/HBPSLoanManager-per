//
//  HBBaseSearchTableViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/10.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseSearchTableViewController.h"


@interface HBBaseSearchTableViewController ()
{
    UITextField *_textField;
}
@end

@implementation HBBaseSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

//点击屏幕其他区域 收键盘
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.view endEditing:YES];
}

//初始化SearchBar
- (void)initSearchView:(NSString *)placeholder SearchClicked:(SearchData)s{
    self.search = s;
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSearchBarHigh)];
    searchView.backgroundColor = RGBACOLOR(210, 210, 210, 1);
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, kSCREEN_WIDTH*3/4, kSearchBarHigh - 10)];
    _textField.backgroundColor = RGBACOLOR(247, 247, 247, 1);
    _textField.borderStyle = UITextBorderStyleLine;
    _textField.delegate =self;
    _textField.returnKeyType = UIReturnKeyDone;
    if (placeholder == nil) {
        placeholder = @"搜索";
    }
    _textField.placeholder = placeholder;
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 40, kSearchBarHigh - 10-5)];
    tempImageView.image = [UIImage imageNamed:@"searchItem"];
    [tempImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [_textField setLeftView:tempImageView];
    [_textField setLeftViewMode:(UITextFieldViewModeAlways)];

    [searchView addSubview:_textField];
    
    UIButton *searchBtn = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    [searchBtn setFrame:CGRectMake(kSCREEN_WIDTH*3/4 + 20, 5, kSCREEN_WIDTH/4 - 20 - 10,  kSearchBarHigh - 10)];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    searchBtn.layer.cornerRadius = 3;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.borderColor = [UIColor grayColor].CGColor;
    searchBtn.layer.borderWidth = 1;
    [searchBtn addTarget:self action:@selector(searchClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [searchView addSubview:searchBtn];
    
    [self.view addSubview:searchView];
}


//点击完成按钮 收键盘 搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self searchClicked];
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//初始化Tableview
- (void)initTableViewForResult:(CGRect)rect{
    if (rect.size.height == 0) {
        rect = CGRectMake(0,kTopBarHeight + kSearchBarHigh ,kSCREEN_WIDTH ,kSCREEN_HEIGHT - kTopBarHeight - kSearchBarHigh);
    }
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.backgroundColor              = RGBACOLOR(238, 238, 238, 1);
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView              = [[UIView alloc] init];
    self.tableView.tableFooterView              = [[UIView alloc] init];
    self.tableView.dataSource                   = self;
    self.tableView.delegate                     = self;
    [self.view addSubview:self.tableView];
    
    if (DSystemVersion >= 7.0)
        //分割线的位置不带偏移
        self.tableView.separatorInset = UIEdgeInsetsZero;
}



- (void)searchClicked{
    [self.view endEditing:YES];
    if (self.search) {
        self.search(_textField.text);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
