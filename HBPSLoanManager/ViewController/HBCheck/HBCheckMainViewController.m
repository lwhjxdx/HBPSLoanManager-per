//
//  HBCheckMainViewController.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckMainViewController.h"
#import "FSCalendar.h"
#import "NSDate+FSExtension.h"
#import "Masonry.h"
#import "MainColecthionTableViewCell.h"

#define kPink [UIColor colorWithRed:0.166 green:0.217 blue:0.776 alpha:1.000]
#define kBlue [UIColor colorWithRed:31/255.0 green:119/255.0 blue:219/255.0 alpha:1.0]
#define kBlueText [UIColor colorWithRed:14/255.0 green:69/255.0 blue:221/255.0 alpha:1.0]
@interface HBCheckMainViewController ()<FSCalendarDelegate,FSCalendarDataSource,UITableViewDelegate,UITableViewDataSource>
@property (assign, nonatomic) FSCalendarFlow        flow;
@property (nonatomic, strong) FSCalendar            *calendar;
@property (strong, nonatomic) NSCalendar            *currentCalendar;
@property (assign, nonatomic) NSInteger             theme;
@property (assign, nonatomic) BOOL                  lunar;
@property (copy,   nonatomic) NSDate                *selectedDate;
@property (assign, nonatomic) NSUInteger            firstWeekday;
@property (strong, nonatomic) UIView                *tableViewHead;
@property (strong, nonatomic) NSArray               *itemArr;
@end

@implementation HBCheckMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"贷后检查计划";
    if (_mainType == MainViewControllerTypePlane) {
        self.itemArr         = @[
                                 @{@"title":@"小企业法人授信贷款业务",@"image":@"icon_xqyfrsxdkyw",@"nextVC":@"HBCompanyPlanViewController"},
                                 @{@"title":@"个人商务贷款",@"image":@"icon_grswdk",@"nextVC":@"HBPersonPlanViewController"},
                                 @{@"title":@"个人经营性车辆贷款",@"image":@"icon_grjyxcldk",@"nextVC":@"HBPersonageCarPlanController"},
                                 @{@"title":@"三农贷款",@"image":@"icon_sndk",@"nextVC":@""},
                                 @{@"title":@"消费贷款",@"image":@"icon_xfdk",@"nextVC":@""}
                                 ];
    }else{
        self.itemArr         = @[
                                 @{@"title":@"小企业法人授信贷款业务",@"image":@"icon_xqyfrsxdkyw",@"nextVC":@"LoanLegalViewController"},
                                 @{@"title":@"个人商务贷款",@"image":@"icon_grswdk",@"nextVC":@"LoanPersonageController"},
                                 @{@"title":@"个人经营性车辆贷款",@"image":@"icon_grjyxcldk",@"nextVC":@"LoanPersonageCarController"},
                                 @{@"title":@"三农贷款",@"image":@"icon_sndk",@"nextVC":@""},
                                 @{@"title":@"消费贷款",@"image":@"icon_xfdk",@"nextVC":@""}
                                 ];
    }
    self.dataString = [NSDate dateWithTimeIntervalSinceNow:8*3600];
    [self settingBaseTableView];
}
- (void)settingBaseTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView setLIneMethond];
    [self.view addSubview:tableView];
    tableView.tableHeaderView = self.tableViewHead;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.baseTableView = tableView;
}
#pragma mark - tableViewDatasourse
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainColecthionTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([MainColecthionTableViewCell class])];
    MainColecthionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MainColecthionTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.itemArr = _itemArr;
    __weak HBCheckMainViewController *weekSelf = self;
    cell.selecBlock = ^(NSDictionary *dic,NSInteger index){
        HBBaseViewController *vc = [[NSClassFromString(dic[@"nextVC"]) alloc]init];
        vc.dataString = self.dataString;
        if (vc) {
            [weekSelf pushViewController:vc animated:YES];
        }
    };
    return cell;
}
//-(void)pushNextViewController:(UIViewController *)vc
//{
//    
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (_itemArr.count / 3 + ((_itemArr.count % 3 == 0)?0:1)) * 120.f;
}
#pragma mark - tableViewDelegate



-(UIView *)tableViewHead
{
    if (!_tableViewHead) {
        UIView *headTable = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT / 2)];
        
        self.currentCalendar = [NSCalendar currentCalendar];
        _flow = FSCalendarFlowVertical;
        FSCalendarHeader *head = [[FSCalendarHeader alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
        head.center = CGPointMake(self.view.center.x, head.center.y);
        [headTable addSubview:head];
        //    [self.view addSubview:head];
        _firstWeekday = self.calendar.firstWeekday;
        [headTable addSubview:self.calendar];
        _calendar.header = head;
        self.theme = 1;
        self.tableViewHead = headTable;
    }
    return _tableViewHead;
}
-(FSCalendar *)calendar
{
    if (!_calendar) {
        self.calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, kSCREEN_HEIGHT / 2 - 30)];
        _calendar.center = CGPointMake(self.view.center.x, _calendar.center.y);
        _calendar.delegate = self;
        _calendar.dataSource = self;
        [_calendar setWeekdayTextColor:kBlueText];
        [_calendar setHeaderTitleColor:kBlueText];
        [_calendar setEventColor:[kBlueText colorWithAlphaComponent:0.75]];
        [_calendar setSelectionColor:kBlue];
        [_calendar setHeaderDateFormat:@"MMMM yyyy"];
        [_calendar setMinDissolvedAlpha:0.2];
        [_calendar setTodayColor:kPink];
        [_calendar setCellStyle:FSCalendarCellStyleCircle];
    }
    return _calendar;
}




#pragma mark - FSCalendarDataSource

- (NSString *)calendar:(FSCalendar *)calendarView subtitleForDate:(NSDate *)date
{
//    if (date.fs_day == 3)
//    {
//        return @"延误";
//    }else if(date.fs_day == 8){
//        return @"完成";
//    }
    return nil;
}
-(FSCalendarCellSelectStlye)calendar:(FSCalendar *)calendar calendarCellSelectStlye:(NSDate *)date
{
    if (date.fs_day == 6) {
        return FSCalendarCellSelectStlyeFinished;
    }else if(date.fs_day == 11){
        return FSCalendarCellSelectStlyeUnfinished;
    }else if(date.fs_day == 28){
        return FSCalendarCellSelectStlyeDelay;
    }
    else return 300;
}
- (BOOL)calendar:(FSCalendar *)calendarView hasEventForDate:(NSDate *)date
{
    return NO;
}


#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
    
    BOOL shouldSelect = date.fs_day != 33;
    if (!shouldSelect) {
        [[[UIAlertView alloc] initWithTitle:@"FSCalendar"
                                    message:[NSString stringWithFormat:@"FSCalendar delegate forbid %@  to be selected",[date fs_stringWithFormat:@"yyyy/MM/dd"]]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
    return shouldSelect;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    self.dataString =date;
    NSLog(@"did select date %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
}

- (void)calendarCurrentMonthDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to month %@",[calendar.currentMonth fs_stringWithFormat:@"MMMM yyyy"]);
}



#pragma mark - Setter

- (void)setTheme:(NSInteger)theme
{
    if (_theme != theme) {
        _theme = theme;
        switch (theme) {
            case 0:
            {
                [_calendar setWeekdayTextColor:kBlueText];
                [_calendar setHeaderTitleColor:kBlueText];
                [_calendar setEventColor:[kBlueText colorWithAlphaComponent:0.75]];
                [_calendar setSelectionColor:kBlue];
                [_calendar setHeaderDateFormat:@"MMMM年yyyy月"];
                [_calendar setMinDissolvedAlpha:0.2];
                [_calendar setTodayColor:kPink];
                [_calendar setCellStyle:FSCalendarCellStyleCircle];
                break;
            }
            case 1:
            {
                [_calendar setWeekdayTextColor:[UIColor blackColor]];
                [_calendar setHeaderTitleColor:[UIColor darkGrayColor]];
                [_calendar setEventColor:[UIColor greenColor]];
                [_calendar setSelectionColor:[UIColor colorWithRed:0.163 green:0.576 blue:1.000 alpha:1.000]];
                [_calendar setHeaderDateFormat:@"yyyy年MM月"];
                [_calendar setMinDissolvedAlpha:1.0];
                [_calendar setTodayColor:[UIColor blueColor]];
                [_calendar setCellStyle:FSCalendarCellStyleCircle];
                break;
            }
            case 2:
            {
                [_calendar setWeekdayTextColor:[UIColor redColor]];
                [_calendar setHeaderTitleColor:[UIColor redColor]];
                [_calendar setEventColor:[UIColor greenColor]];
                [_calendar setSelectionColor:[UIColor blueColor]];
                [_calendar setHeaderDateFormat:@"yyyy年MM月"];
                [_calendar setMinDissolvedAlpha:1.0];
                [_calendar setCellStyle:FSCalendarCellStyleRectangle];
                [_calendar setTodayColor:[UIColor orangeColor]];
                break;
            }
            default:
                break;
        }
        
    }
}

- (void)setLunar:(BOOL)lunar
{
    if (_lunar != lunar) {
        _lunar = lunar;
        [_calendar reloadData];
    }
}

- (void)setFlow:(FSCalendarFlow)flow
{
    if (_flow != flow) {
        _flow = flow;
        _calendar.flow = flow;
        [[[UIAlertView alloc] initWithTitle:@"FSCalendar"
                                    message:[NSString stringWithFormat:@"Now swipe %@",@[@"Vertically", @"Horizontally"][_calendar.flow]]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
}

- (void)setSelectedDate:(NSDate *)selectedDate
{
    _calendar.selectedDate = selectedDate;
}

- (void)setFirstWeekday:(NSUInteger)firstWeekday
{
    if (_firstWeekday != firstWeekday) {
        _firstWeekday = firstWeekday;
        _calendar.firstWeekday = firstWeekday;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
