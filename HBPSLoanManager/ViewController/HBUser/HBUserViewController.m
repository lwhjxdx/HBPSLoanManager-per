//
//  HBUserViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBUserViewController.h"
#import "HBLoginViewController.h"
#import "UpDataHeaderPicView.h"
#import "UIImageView+WebCache.h"
#import "HBSignInController.h"
#import "HBLocusViewController.h"
#import "HBDraftBoxViewController.h"
#import "YZWViewController.h"
#import "GestureSetPasswordController.h"

static NSString *imageName = @"imageName";
static NSString *titleName = @"titleName";
static NSString *className = @"className";

@interface HBUserViewController ()<UITableViewDelegate,UITableViewDataSource>
{
//    NSArray *imageViewArray;
//    NSArray *titleArray;
    UpDataHeaderPicView *upView;
    BOOL isFirst;
}
@property(nonatomic, strong)NSArray *tableArr;
@end

@implementation HBUserViewController
#pragma mark - init view
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titleLabel.text = @"我的信息";
    [self configData];
    isFirst = YES;
    [self littleAdjust];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (isFirst) {
        [self initTableView];
    }
    isFirst             = NO;
    if (upView) {
        [upView sd_setImageWithURL:[NSURL URLWithString:[HBUserModel getHeadImagePath]] placeholderImage:[UIImage imageNamed:@"photo"]];
    }
    self.nameLabel.text = [HBUserModel getRealname];

}
/**
 *  界面微调 调整界面
 */
- (void)littleAdjust{

    //替换 self.photoImageView 为 UpDataHeaderPicView 控件
    self.photoImageView.layer.cornerRadius  = self.photoImageView.frame.size.width/2;
    self.photoImageView.layer.masksToBounds = YES;
    self.photoImageView.layer.borderWidth   = 5;
    self.photoImageView.layer.borderColor   = [UIColor whiteColor].CGColor;

    CGRect rect                             = self.photoImageView.frame;
    upView                                  = [[UpDataHeaderPicView alloc] initWithFrame:rect upImage:^(NSData *headerData) {

        //选中图片上传

    NSMutableDictionary *di                 = [NSMutableDictionary dictionary];
        [di setObject:headerData forKey:@"fileName"];
        [di setObject:@"1"
               forKey:@"uploadType"];
        [HBRequest uploadHeader:kFileUploadURL withParams:di successfulBlock:^(NSDictionary *receiveJSON) {
            [self handleHeaderPicData:receiveJSON];

        } failBlock:nil isNoSession:NO];
    }];
    upView.image                            = self.photoImageView.image;
    [upView sd_setImageWithURL:[NSURL URLWithString:[HBUserModel getHeadImagePath]] placeholderImage:[UIImage imageNamed:@"photo"]];
    upView.center                           = CGPointMake((kSCREEN_WIDTH)/2, rect.origin.y + rect.size.width/2);
    upView.layer.cornerRadius               = self.photoImageView.frame.size.width/2;
    upView.layer.masksToBounds              = YES;
    upView.layer.borderWidth                = 2;
    upView.layer.borderColor                = [UIColor whiteColor].CGColor;
    [[self.photoImageView superview] addSubview:upView];
    [self.photoImageView removeFromSuperview];

    self.nameLabel.text                     = [HBUserModel getRealname];

    self.loginButton.layer.cornerRadius     = 5 ;
    self.loginButton.layer.masksToBounds    = YES;
}

#pragma mark - setting tableView
//界面tableview
- (void)initTableView{

    CGRect rect                            = self.subTempView.frame;
    self.subTempView.frame                 = rect;
    rect.origin                            = CGPointMake(0, 0);
    rect.size.width                        = kSCREEN_WIDTH;
    rect.size.height                       = 400;
    //rect.size.height = imageViewArray.count * 60 + 80;
    //rect.size.height = rect.size.height*kSCREEN_HEIGHT/568.0;

    UITableView *tableView                 = [[UITableView alloc] initWithFrame:rect style:(UITableViewStylePlain)];
    tableView.dataSource                   = self;
    tableView.delegate                     = self;
    tableView.backgroundColor              = [UIColor whiteColor];
    tableView.showsVerticalScrollIndicator = NO;
    [self.subTempView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.subTempView);
    }];
    UIView *footerView                     = [[UIView alloc] init];
    footerView.frame                       = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 130);
    footerView.backgroundColor             = [UIColor clearColor];
//    footerView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.6f].CGColor;
//    footerView.layer.borderWidth = 0.5f;
    UIView *lineView                       = [[UIView alloc]init];
    lineView.backgroundColor               = [[UIColor grayColor] colorWithAlphaComponent:0.6f];
    [footerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView.mas_left);
        make.right.equalTo(footerView.mas_right);
        make.top.equalTo(footerView.mas_top);
        make.height.equalTo(@0.5);
    }];
    UIButton *logoutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame                        = CGRectMake((CGRectGetWidth(footerView.frame) - 260) * 0.5, 60, 260, 40);
    logoutBtn.exclusiveTouch               = YES;
    [logoutBtn setTitle:@"登出" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoutBtn.backgroundColor              = kColorWith16RGB(0x005E39);
    logoutBtn.layer.cornerRadius           = 5 ;
    logoutBtn.layer.masksToBounds          = YES;
    [logoutBtn addTarget:self action:@selector(loginOutClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:logoutBtn];

    tableView.tableFooterView              = footerView;
}


//配置 数据
- (void)configData{
#warning - 暂时不添加手势密码
    self.tableArr = @[@{imageName:@"wdzl-icon1",titleName:@"草稿箱",className:@"HBDraftBoxViewController"},
                      @{imageName:@"wdzl-icon2",titleName:@"活动轨迹",className:@"HBLocusViewController"},
                      @{imageName:@"wdzl-icon5",titleName:@"修改密码",className:@"HBAlterPWViewController"},
//                      @{imageName:@"wdzl-icon5",titleName:@"安全设置",className:@"GestureSetPasswordController"},
                      @{imageName:@"wdzl-icon3",titleName:@"关于",className:@"YZWViewController"}];
}

#pragma mark - tableView datasourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableCell = @"cellIDUSERINFO";
    UITableViewCell *cell      = [tableView dequeueReusableCellWithIdentifier:tableCell];

    if (!cell) {

    cell                       = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:tableCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.imageView.image       = [UIImage imageNamed:_tableArr[indexPath.row][imageName]];
    cell.textLabel.text        = _tableArr[indexPath.row][titleName];
    cell.accessoryType         = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor       = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return 50;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class class = NSClassFromString(_tableArr[indexPath.row][className]);
    if (!class) {
        return;
    }
    [self pushViewController:[[class alloc]init] animated:YES];

}

#pragma mark - other action
- (IBAction)nameClicked:(id)sender {
    //修改密码
//    HBAlterPWViewController *vc  = [[HBAlterPWViewController alloc] init];
//    [self pushViewController:vc animated:YES];
}


//登出点击事件
- (IBAction)loginOutClick:(id)sender {
    [self requestFromNetWorking];
}

//

//从网络请求数据 登出------
- (void)requestFromNetWorking{
    NSMutableDictionary *dic = [self markParams];
    if (!dic) {
        return;
    }
    [HBRequest RequestDataJointStr:kLoginOutURL parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self handleData:receiveJSON];
    } failBlock:nil];
    
}

//配置参数
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return dic;
}

//登出完成     处理数据     跳转到登陆页面  清空用户信息
- (void)handleData:(NSDictionary *)jsonDic{
    
    if (jsonDic) {
        [HBUserModel clearUserInfo];
        HBLoginViewController *vc = [[HBLoginViewController alloc] init];
        //    UINavigationController *nav  = [[UINavigationController alloc] initWithRootViewController:vc];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - setting head Image
/**
 *  处理上传头像返回的数据
 *
 *  @param dic 请求需要上传数据
 */
- (void)handleHeaderPicData:(NSDictionary *)dic{
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:dic[@"uploadResult"] forKey:@"userPictureUrl"];
    [HBUserModel setHeadImagePath:dic[@"uploadResult"]];
    
    [upView sd_setImageWithURL:[NSURL URLWithString:[HBUserModel getHeadImagePath]] placeholderImage:upView.image];
    [self updataHeaderString:paramDic];
    
}


//将头像路径上传到服务器
- (void)updataHeaderString:(NSMutableDictionary *)dic{
    [HBRequest RequestDataJointStr:kUpdateUserUrl parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
        [self showAlterView:receiveJSON[@"respMsg"]];
    } failBlock:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
