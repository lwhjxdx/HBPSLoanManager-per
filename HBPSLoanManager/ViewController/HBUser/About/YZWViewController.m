//
//  YZWViewController.m
//  SPDBCCC
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 newTouch. All rights reserved.
//

#import "YZWViewController.h"
#import "DetailsViewController.h"
#import "UIColor+ChangeWithString.h"
#import "Masonry.h"
#import <PgySDK/PgyManager.h>
@interface YZWViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{

    NSArray *array;


}

@property(nonatomic, strong)UILabel *bandleIdLabel;
@property(nonatomic, strong)NSString *downloadUrlString;
@property(nonatomic, strong)NSDictionary *visonInfo;

@end

@implementation YZWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorFromHexString:@"#eaeaea"];
    self.titleLabel.text=@"关于";
    self.backButton.hidden = NO;
    [self setTabbarViewHide:YES];
    array=[[NSArray alloc]initWithObjects:@"检查更新",@"版本说明", nil];
    UITableView *tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kTopBarHeight) style:UITableViewStylePlain];
    tableview.backgroundColor=[UIColor clearColor];
    tableview.dataSource=self;
    tableview.delegate=self;
    tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    
    [self.view addSubview:tableview];
    

    
    
    
}
-(UILabel *)bandleIdLabel
{
    if (!_bandleIdLabel) {
        self.bandleIdLabel = [[UILabel alloc]init];
        
       
        
            }
    return _bandleIdLabel;
}
-(NSAttributedString*)stringWithVision
{
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:@"版本号:" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
    NSAttributedString *vesion = [[NSAttributedString alloc]initWithString: [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor yellowColor]}];
    [attstring insertAttributedString:vesion atIndex:4];
    return attstring;
}


#pragma mark UItableview的协议方法


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    if (section==0) {
        return 1;
        
    }
    return array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return 110;
    }
    return 49;
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *cellID = [NSString stringWithFormat:@"cellID%@",indexPath];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section==0)
        {
            UIImageView *logImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logIcon-60"]];
            logImgView.frame = CGRectMake(30, 20, 60, 60);
            [cell.contentView addSubview:logImgView];
            cell.backgroundColor = [UIColor colorWithRed:0.298 green:0.486 blue:0.361 alpha:1.000];
            [cell.contentView addSubview:self.bandleIdLabel];
            
            _bandleIdLabel.frame = CGRectMake(0, 0, kSCREEN_WIDTH / 2, 20);
            
            _bandleIdLabel.center = CGPointMake(cell.contentView.center.x + 20, cell.contentView.center.y );
            
            _bandleIdLabel.attributedText   = [self stringWithVision];
            [_bandleIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).offset(-12);
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.size.mas_greaterThanOrEqualTo(CGSizeZero);
            }];
        }
    }

    if (indexPath.section==1)
    {
        NSString * title = array[indexPath.row];
        cell.textLabel.text = title;
        cell.textLabel.font=[UIFont  systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
       
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        [SVProgressHUD show];
        if (indexPath.row==0) {
            [[PgyManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateReturnId:)];
        }else{
            if (!_visonInfo) {
                [[PgyManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(gettingVersion:)];
            }else{
                [self gettingVersion:_visonInfo];
            }
        }
    }
}
-(void)gettingVersion:(NSDictionary*)dic
{
    [SVProgressHUD showSuccessWithStatus:@"获取说明成功"];
    if (dic) {
        DetailsViewController *vc = [[DetailsViewController alloc]init];
        vc.versionInfoString = dic[@"releaseNote"];
        [self pushViewController:vc animated:YES];
    }else{
        DetailsViewController *vc = [[DetailsViewController alloc]init];
        vc.versionInfoString = @"初始版本，功能可能会有欠缺";
        [self pushViewController:vc animated:YES];
    }
}
-(void)updateReturnId:(id)dic
{
    if (!dic) {
        [SVProgressHUD showSuccessWithStatus:@"当前版本为最新版本，无需更新"];
    }else{
        self.visonInfo = dic;
        [SVProgressHUD showSuccessWithStatus:@"检测完成"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"版本更新" message:@"当前版本低于最新版本，现在就去更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_visonInfo[@"appUrl"]]];
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
