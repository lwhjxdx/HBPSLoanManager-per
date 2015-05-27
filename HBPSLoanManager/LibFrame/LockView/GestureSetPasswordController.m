//
//  GestureSetPasswordController.m
//  veryWallen
//
//  Created by qiuqiu's imac on 14/12/24.
//  Copyright (c) 2014年 qiuqiu's imac. All rights reserved.
//

#import "GestureSetPasswordController.h"
#import "GestureLockViewContoller.h"
#import "NSUserDefaults+Setting.h"

@interface GestureSetPasswordController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL enableAdd;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)NSInteger sectionNumber;
@property (nonatomic,strong)UISwitch    *switchView;
@end


@implementation GestureSetPasswordController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"手势设置";
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.switchView.on = [NSUserDefaults acquireGestureBool];
    [self addRowWithBool:[NSUserDefaults acquireGestureBool]];
}
#pragma mark ---------------------getter

-(NSInteger)sectionNumber
{
    return [NSUserDefaults acquireGestureBool]?2:1;;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tab = [[UITableView alloc]initWithFrame:CGRectMake(0, kValueTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kValueTopBarHeight) style:UITableViewStyleGrouped];
        tab.dataSource = self;
        tab.delegate   = self;
        self.tableView = tab;
    }
    return _tableView;
}

-(UISwitch*)switchView
{
    if (!_switchView) {
        UISwitch *swith = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 48, 40)];
        swith.on = [NSUserDefaults acquireGestureBool];
        [swith addTarget:self action:@selector(changeGestureBool) forControlEvents:UIControlEventValueChanged];
        self.switchView = swith;
        
    }
    return _switchView;
}
#pragma mark -----------------dataSource,delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionNumber;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellInde  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInde];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInde];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:17.f];
    if (indexPath.section==0) {
        cell.textLabel.text = @"开启手势密码";
        cell.accessoryView = self.switchView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        cell.textLabel.text = @"修改手势密码";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        [self.navigationController pushViewController:[[GestureLockViewContoller alloc] init] animated:YES];
    }
}

#pragma mark ----------------switch Action----

-(void)changeGestureBool
{
    if (self.switchView.on) {
        [self.navigationController pushViewController:[[GestureLockViewContoller alloc] init] animated:YES];
    }else{
        [self.tableView beginUpdates];
        [NSUserDefaults deleteGesturePassword];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
        enableAdd = NO;
        [self.tableView endUpdates];
    }
}
-(void)addRowWithBool:(BOOL)isAdd{
    if (enableAdd) {
        return;
    }
    if (isAdd) {
        [self.tableView beginUpdates];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
        enableAdd = YES;
        [self.tableView endUpdates];
    }

}

@end
