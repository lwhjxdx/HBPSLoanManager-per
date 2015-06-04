//
//  HBLocusViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/14.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBLocusViewController.h"
//#import "BMKMapView.h"
//#import "BMKPolyline.h"
//#import "BMKPolylineView.h"
//#import "BMKPointAnnotation.h"
//#import "BMKTypes.h"
#import "BMapKit.h"

@interface HBLocusViewController ()<BMKMapViewDelegate>
{
    BMKMapView *_mapView;
    
    NSMutableArray *dataArray;
    BMKPolyline* polyline;
}
@property(nonatomic,strong)NSArray *listArr;
@end

@implementation HBLocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = @"我的轨迹";
    [self initMapView];
//    [self initBaseTableView];
    [self requestFromNetWorking];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    [self.homeButton setTitle:@"地图" forState:UIControlStateNormal];
    [self.homeButton setTitle:@"列表" forState:UIControlStateSelected];
    [self.homeButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
}



- (void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _mapView = nil;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.homeButton.hidden = NO;
   
}
- (void)homeBtnEvents:(UIButton*)btn
{
    btn.selected = !btn.selected;
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";//{kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
    
     //更多私有{@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"};
     transition.subtype = kCATransitionFromLeft;//{kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
    
     transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:@"transitionSub"];
    
     // 要做的
     [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//    [UIView animateWithDuration:0.25f animations:^{
//        [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//    }];
    
//    self.baseTableView.hidden = !self.baseTableView.hidden;
}
- (void)loadDataWithJson:(NSDictionary*)dic{
    
    dataArray = [NSMutableArray array];
    for (NSDictionary *tempDic in dic[@"signInfoList"]) {
        for (NSDictionary *tempDic2 in tempDic[@"signInList"]) {
            [dataArray addObject:tempDic2];
        }
    }
    [self addPointArray];
    self.listArr = dic[@"signInfoList"];
    [self.baseTableView reloadData];

}
- (void)initBaseTableView
{
    self.baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    [self.view addSubview:self.baseTableView];
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(kValueTopBarHeight, 0, 0, 0));
    }];
}
- (void)initMapView{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTopBarHeight)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;//显示定位图层
    CLLocationCoordinate2D coordinator;
    coordinator.latitude = 114.291479f;
    coordinator.longitude = 30.606202f;
    [_mapView setCenterCoordinate:coordinator animated:NO];
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coordinator, BMKCoordinateSpanMake(1.0, 1.0));
    [_mapView setRegion:viewRegion];
    [_mapView setZoomLevel:16];
    [self.view addSubview:_mapView];
}
- (void)requestFromNetWorking{
    
    [HBRequest RequestDataJointStr:kSignInURL2 parameterDic:[NSMutableDictionary dictionaryWithDictionary:@{ @"userId":[HBUserModel getUserId]}]successfulBlock:^(NSDictionary *receiveJSON) {
        if (![receiveJSON[@"respCode"] isEqualToString:@"0000"]) {
            return ;
        }
        
        [self loadDataWithJson:receiveJSON];
    } failBlock:nil];
    
    
    
}
/**
 *  绘制地图上的点
 */
- (void)addPointArray
{

    // 添加折线覆盖物
    CLLocationCoordinate2D coors[500] = {0};
    for (int i = 0; i < dataArray.count; i++) {
        coors[i].latitude = [dataArray[i][@"latitude"] floatValue];
        coors[i].longitude = [dataArray[i][@"longitude"] floatValue];
    }
    polyline = [BMKPolyline polylineWithCoordinates:coors count:dataArray.count];

    for (int i = 0; i<dataArray.count; i++) {
        BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
        point.coordinate = coors[i];
        point.title = dataArray[i][@"address"];
        [_mapView addAnnotation:point];
        [_mapView setCenterCoordinate:point.coordinate animated:YES];
        
    }
    [_mapView addOverlay:polyline];
}


// Override
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay] ;
        polylineView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 3.0;
        
        return polylineView;
    }
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!_listArr) {
        return 0;
    }
    return _listArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArr[section][@"signInList"] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
    lable.text = _listArr[section][@"signDate"];
    lable.backgroundColor = [UIColor colorWithRed:0.725 green:0.913 blue:0.717 alpha:1.000];
    lable.textAlignment = NSTextAlignmentCenter;
    return lable;
}
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return _listArr[section][@"signDate"];
//}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"myCellIdHBLocusViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
    }
         cell.textLabel.text = _listArr[indexPath.section][@"signInList"][indexPath.row][@"address"];
         cell.detailTextLabel.text = _listArr[indexPath.section][@"signInList"][indexPath.row][@"updateDatetime"];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
