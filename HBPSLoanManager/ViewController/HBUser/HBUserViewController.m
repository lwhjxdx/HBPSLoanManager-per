//
//  HBUserViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/9.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBUserViewController.h"
#import "HBLoginViewController.h"
#import "HBAlterPWViewController.h"
#import "UpDataHeaderPicView.h"
#import "UIImageView+WebCache.h"
#import "HBSignInController.h"
#import "HBLocusViewController.h"
#import "HBDraftBoxViewController.h"
@interface HBUserViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *imageViewArray;
    NSArray *titleArray;
    UpDataHeaderPicView *upView;
    BOOL isFirst;
}
@end

@implementation HBUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"我的信息";
    [self configData];
    isFirst = YES;
    [self littleAdjust];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//界面微调 调整界面
- (void)littleAdjust{
    
    //替换 self.photoImageView 为 UpDataHeaderPicView 控件
    
    self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width/2;
    self.photoImageView.layer.masksToBounds = YES;
    self.photoImageView.layer.borderWidth = 5;
    self.photoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CGRect rect = self.photoImageView.frame;
    upView = [[UpDataHeaderPicView alloc] initWithFrame:rect upImage:^(NSData *headerData) {
        
        //选中图片上传
        
        NSMutableDictionary *di = [NSMutableDictionary dictionary];
        [di setObject:headerData forKey:@"fileName"];
        [di setObject:@"1"
               forKey:@"uploadType"];
        [HBRequest uploadHeader:kFileUploadURL withParams:di successfulBlock:^(NSDictionary *receiveJSON) {
            [self handleHeaderPicData:receiveJSON];
            
        } failBlock:^(NSError *error) {
            
        } isNoSession:NO];
    }];
    upView.image = self.photoImageView.image;
    [upView sd_setImageWithURL:[NSURL URLWithString:[HBUserModel getHeadImagePath]] placeholderImage:[UIImage imageNamed:@"photo"]];
    upView.center = CGPointMake((kSCREEN_WIDTH)/2, rect.origin.y + rect.size.width/2);
    upView.layer.cornerRadius = self.photoImageView.frame.size.width/2;
    upView.layer.masksToBounds = YES;
    upView.layer.borderWidth = 2;
    upView.layer.borderColor = [UIColor whiteColor].CGColor;
    [[self.photoImageView superview] addSubview:upView];
    [self.photoImageView removeFromSuperview];
    self.nameLabel.text = [HBUserModel getUserName];
    self.loginButton.layer.cornerRadius =  5 ;
    self.loginButton.layer.masksToBounds = YES;
}

//处理上传头像返回的数据
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
    } failBlock:^(NSError *error) {
        
    }];
}

//界面tableview
- (void)initTableView{
    CGRect rect = self.subTempView.frame;
    rect.size.height = imageViewArray.count* 60 ;
    self.subTempView.frame = rect;
    rect.origin = CGPointMake(0, 0);
    rect.size.width = kSCREEN_WIDTH;
//    rect.size.height = rect.size.height*kSCREEN_HEIGHT/568.0;
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:(UITableViewStylePlain)];
    tableView.dataSource  = self;
    tableView.delegate = self;
    tableView.backgroundColor = RGBACOLOR(247, 247, 247, 1);
    tableView.showsVerticalScrollIndicator = NO;
    [self.subTempView addSubview:tableView];
}


//配置 数据
- (void)configData{
    imageViewArray = @[[UIImage imageNamed:@"wdzl-icon1"],
//                       [UIImage imageNamed:@"wdzl-icon2"],
                       [UIImage imageNamed:@"wdzl-icon3"],
                       [UIImage imageNamed:@"wdzl-icon5"]];
    
    titleArray = @[@"草稿箱",
//                   @"活动轨迹",
                   @"签到",
                   @"密码修改"];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return imageViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDE"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"IDE"];
    }
    cell.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 50);
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 25, 25)];
    imageView.image = imageViewArray[indexPath.row];
    [cell.contentView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, kSCREEN_WIDTH - 100, 25)];
    label.text = titleArray[indexPath.row];
    [cell.contentView addSubview:label];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = RGBACOLOR(247, 247, 247, 1);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            HBDraftBoxViewController *vc = [[HBDraftBoxViewController alloc] init];
            [self pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            //签到
            HBSignInController *vc = [[HBSignInController alloc] init];
            [self pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            //修改密码
            HBAlterPWViewController *vc = [[HBAlterPWViewController alloc] init];
            [self pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

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
    } failBlock:^(NSError *error) {
        
    }];
    
}

//配置参数
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return dic;
}

//登出完成     处理数据     跳转到登陆页面  清空用户信息
- (void)handleData:(NSDictionary *)jsonDic{
    
    if (jsonDic) {
        HBLoginViewController *vc = [[HBLoginViewController alloc] init];
        UINavigationController *nav  = [[UINavigationController alloc] initWithRootViewController:vc];
        [UIApplication sharedApplication].keyWindow.rootViewController  = nav;
        [HBUserModel clearUserInfo];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabbarViewHide:@"NO"];
    if (isFirst) {
        [self initTableView];
    }
    isFirst = NO;
}

@end
