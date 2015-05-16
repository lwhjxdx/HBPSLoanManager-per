//
//  HBSignInController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/14.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBSignInController.h"
#import "BMKMapView.h"
#import "BMKLocationService.h"
#import "BMKGeocodeSearch.h"
#import "BMKPointAnnotation.h"
#import "HBCheckBaseViewController.h"

@interface HBSignInController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    UITableView *tableView1;
    
    
    
    
    CLLocationCoordinate2D _userLocationPoint;
    NSString *addressString;
    
    NSMutableArray *_dataArray;
    BOOL isQiandao;
}
@property(nonatomic,strong)BMKMapView *mapView;
@property(nonatomic,strong)BMKLocationService *locService;
@property(nonatomic,strong)BMKGeoCodeSearch* geocodesearch;
@end

@implementation HBSignInController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setFrame:CGRectMake(35, kSCREEN_HEIGHT- 80, 45, 45)];
    //        btn.center = _mapView.center;
    //        [btn setTitle:@"签到" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"thumb_IMG_0036_1024"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.3f]];
    btn.layer.cornerRadius = 5.f;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(chongxindingwei) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    self.titleLabel.text = @"定位";
    [self initLocation];
    [self.homeButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.homeButton.frame = CGRectMake(kSCREEN_WIDTH-60,FromStatusBarHeight, 60, 44);
    [self.homeButton setImage:nil forState:UIControlStateNormal];
    self.homeButton.hidden = YES;
    [self.homeButton addTarget:self action:@selector(nextIemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mBaseNavigationBarView addSubview:self.homeButton];
    [self setTabbarViewHide:YES];

}
-(void)chongxindingwei
{
    [_locService startUserLocationService];
}
-(void)nextIemAction:(id)sender
{
    NSMutableDictionary *dic = [self markParams];
    if (!dic) {
        return;
    }
//    if (!isQiandao) {
//        [SVProgressHUD showErrorWithStatus:@"请先签到"];
//        return;
//    }

        [HBRequest RequestDataJointStr:kSignInURL1 parameterDic:dic successfulBlock:^(NSDictionary *receiveJSON) {
            if (![receiveJSON[@"respCode"] isEqualToString:@"0000"]) {
                return ;
            }
//            [receiveJSON isMemberOfClass:<#(__unsafe_unretained Class)#>]
            if (self.pushNextDic) {
                HBCheckBaseViewController *vc;
                vc = [[[self.classString class] alloc] init];
                vc.userDic = self.pushNextDic;
                [self pushViewController:vc animated:YES];
                
            }else{
                [self pushViewController:[[[self.classString class] alloc] init] animated:YES];

            }
        } failBlock:^(NSError *error) {
            
        }];

}
-(void)setIsShowNextItem:(BOOL)isShowNextItem
{
    _isShowNextItem = isShowNextItem;
    if (isShowNextItem) {
        self.homeButton.hidden = NO;
    }else{
        self.homeButton.hidden = YES;
    }
}
- (void)configUI{
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT -kTopBarHeight )];
    [_mapView setZoomLevel:17];
//    [_mapView setlo]
//    <wpt lat="31.225" lon="121.437">
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.showsUserLocation = YES;//显示定位图层
    [self.view addSubview:_mapView];
//    [_mapView viewWillAppear];
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(31.225, 121.437) animated:YES];
    self.backButton.hidden = NO;
}

//初始化定位服务
- (void)initLocation{
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}



//实现相关delegate 处理位置信息更新

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (!_mapView) {
        return;
    }
    [_mapView updateLocationData:userLocation];
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:NO];
    [self searchGEO:userLocation];
}

//查询地址
- (void)searchGEO:(BMKUserLocation *)userLocation{
    
    _geocodesearch.delegate = nil;
    _geocodesearch = nil;
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    if (userLocation != nil) {
        pt = userLocation.location.coordinate;
        _userLocationPoint = pt;
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

//获取地址解码
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (!_mapView) {
        return;
    }
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    [_mapView setShowsUserLocation:NO];
    [_locService stopUserLocationService];
    _locService = nil;
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        
        item.coordinate = result.location;
        item.title = result.address;
        addressString = result.address;
        [_mapView addAnnotation:item];
        [_mapView selectAnnotation:item animated:YES];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_mapView selectAnnotation:item animated:YES];
        });
//        _mapView.centerCoordinate = result.location;
        _userLocationPoint = _mapView.centerCoordinate;
        //定位完成 取消定位服务
        
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setFrame:CGRectMake(kSCREEN_WIDTH - 80, kSCREEN_HEIGHT- 80, 45, 45)];
//        btn.center = _mapView.center;
//        [btn setTitle:@"签到" forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"thumb_IMG_0035_1024"] forState:UIControlStateNormal];
        [btn setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.3f]];
        btn.layer.cornerRadius = 5.f;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(signInClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:btn];
        
        [self.view bringSubviewToFront:btn];
    }else{

        NSString *errorString;
        if (error ==  BMK_SEARCH_RESULT_NOT_FOUND) {
            errorString = @"没有找到当前位置地理名称";
        }else{
            errorString = @"当前定位异常";
        }
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorString  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }
}


//签到点击事件
- (void)signInClicked:(UIButton *)btn{
//    btn.hidden = YES;
    self.homeButton.hidden = !_isShowNextItem;
    [self requestFromNetWorking];
    
}


//从网络请求数据
- (void)requestFromNetWorking{

    [HBRequest RequestDataJointStr:kSignInURL2 parameterDic:[NSMutableDictionary dictionaryWithDictionary:@{ @"userId":[HBUserModel getUserId]}]successfulBlock:^(NSDictionary *receiveJSON) {
        if (![receiveJSON[@"respCode"] isEqualToString:@"0000"]) {
            return ;
        }
        
        [self handleData:receiveJSON];
    } failBlock:^(NSError *error) {
        
    }];
    
    
    
}

//配置参数
- (NSMutableDictionary *)markParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (_userLocationPoint.latitude) {
        [dic setObject:[NSString stringWithFormat:@"%f",_userLocationPoint.latitude] forKey:@"latitude"];
        [dic setObject:[NSString stringWithFormat:@"%f",_userLocationPoint.longitude] forKey:@"longitude"];
    }
    if (addressString) {
        [dic setObject:addressString forKey:@"address"];
    }
    [dic setObject:[HBUserModel getUserId] forKey:@"userId"];
    return dic;
}

//处理数据
- (void)handleData:(NSDictionary *)jsonDic{
    _dataArray = [self dataHandle:jsonDic];
    [self initMapTableView];
    
    [tableView1 reloadData];
}


//初始化
- (void)initMapTableView{
    [UIView animateWithDuration:0.3 animations:^{
        _mapView.frame = CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH,( kSCREEN_HEIGHT - kTopBarHeight)/3);
        [_mapView setCenterCoordinate:_userLocationPoint animated:YES];
    }];
   
    
    
    tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight +( kSCREEN_HEIGHT - kTopBarHeight)/3, kSCREEN_WIDTH,( kSCREEN_HEIGHT - kTopBarHeight)*2/3) style:(UITableViewStyleGrouped)];
    tableView1.dataSource = self;
    tableView1.delegate = self;
    [self.view addSubview:tableView1];
}

#pragma mark - MAP tableViewDelegate  地图签到列表显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDE"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"IDE"];
    }
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    NSDictionary *firstDic = [_dataArray objectAtIndex:indexPath.section];
    NSArray *tempArray = [firstDic objectForKey:@"signInList"];
    NSDictionary *dataDic = [tempArray objectAtIndex:indexPath.row];
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*kSCREEN_WIDTH/320.0, 5, 25  ,25)];
    imageView.image = [UIImage imageNamed:@"wdzl-icon"];
    [cell.contentView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15*kSCREEN_WIDTH/320.0 + 30 , 5, 75, 30)];
    [label setText:dataDic[@"signinTime"]];
    [label setTextAlignment:(NSTextAlignmentCenter)];
    [cell.contentView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15*kSCREEN_WIDTH/320.0 + 30 + 75 , 5, kSCREEN_WIDTH - (15*kSCREEN_WIDTH/320.0 + 30 + 75) -10, 30)];
    [label1 setText:dataDic[@"address"]];
    [cell.contentView addSubview:label1];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_dataArray[section] objectForKey:@"signInList"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSDictionary *dic = [self getHeadData:section];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 40)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80*kSCREEN_WIDTH/320, 5, 30, 30)];
    imageView.image = [UIImage imageNamed:@"wdzl-icon2"];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2 - 50 , 5, 100, 30)];
    
    
    
    [label setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"dateString"]]];
    [label setTextAlignment:(NSTextAlignmentCenter)];
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2 + 50 , 5, 50, 30)];
    [label1 setText:[dic objectForKey:@"weakString"]];
    [view addSubview:label1];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [_mapView viewWillAppear];

}
-(void)backBtnEvents:(id)sender
{
//    [_mapView viewWillDisappear];
    
    _mapView.showsUserLocation = NO;
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil; // 不用时，置nil
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
    [super backBtnEvents:sender];
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



//数据处理算法
- (NSMutableArray *)dataHandle:(NSDictionary *)dic{
    NSArray *array ;
    if (dic[@"signInfoList"]) {
        array = dic[@"signInfoList"];
    }else{
        array = [NSArray array];
    }
    return [NSMutableArray arrayWithArray:array];
}

- (NSMutableDictionary *)getHeadData:(NSInteger)section{
    if (_dataArray == nil) {
        return nil;
    }
    NSDictionary *dic = _dataArray[section];
    NSString *lableString = dic[@"signDate"];
    NSArray *dayArray = [lableString componentsSeparatedByString:@"-"];
    
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:[dayArray[2] integerValue]];
    [_comps setMonth:[dayArray[1] integerValue]];
    [_comps setYear:[dayArray[0] integerValue]];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
//    NSInteger _weekday = [weekdayComponents weekday];
    NSString *weakString;
    switch (weekdayComponents.weekday) {
        case 1:
            weakString = @"周日";
            break;
        case 2:
            weakString = @"周一";
            break;
        case 3:
            weakString = @"周二";
            break;
        case 4:
            weakString = @"周三";
            break;
        case 5:
            weakString = @"周四";
            break;
        case 6:
            weakString = @"周五";
            break;
        case 7:
            weakString = @"周六";
            break;
            
        default:
            weakString = @"";
            break;
    }
    NSMutableDictionary *dataDic = [NSMutableDictionary  dictionary];

    [dataDic setObject:lableString forKey:@"dateString"];
    [dataDic setObject:weakString forKey:@"weakString"];
    return dataDic;
    
}



@end
