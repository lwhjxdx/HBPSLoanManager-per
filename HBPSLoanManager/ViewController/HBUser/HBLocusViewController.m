//
//  HBLocusViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/14.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBLocusViewController.h"
#import "BMKMapView.h"
#import "BMKPolyline.h"
#import "BMKPolylineView.h"
#import "BMKPointAnnotation.h"
@interface HBLocusViewController ()<BMKMapViewDelegate>
{
    BMKMapView *_mapView;
    
    NSMutableArray *dataArray;
    BMKPolyline* polyline;
}
@end

@implementation HBLocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"我的轨迹";
    [self initMapView];
}

- (void)loadDataWithJson:(NSDictionary*)dic{
    
    dataArray = [NSMutableArray array];
    for (NSDictionary *tempDic in dic[@"signInfoList"]) {
        for (NSDictionary *tempDic2 in tempDic[@"signInList"]) {
            [dataArray addObject:tempDic2];
        }
    }
    [self addPointArray];
}

- (void)initMapView{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTopBarHeight)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView setZoomLevel:16];
    [self.view addSubview:_mapView];
}
- (void)requestFromNetWorking{
    
    [HBRequest RequestDataJointStr:kSignInURL2 parameterDic:[NSMutableDictionary dictionaryWithDictionary:@{ @"userId":[HBUserModel getUserId]}]successfulBlock:^(NSDictionary *receiveJSON) {
        if (![receiveJSON[@"respCode"] isEqualToString:@"0000"]) {
            return ;
        }
        
        [self loadDataWithJson:receiveJSON];
    } failBlock:^(NSError *error) {
        
    }];
    
    
    
}
//向地图上加点 模拟假数据
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


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    [self setTabbarViewHide:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self requestFromNetWorking];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _mapView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
