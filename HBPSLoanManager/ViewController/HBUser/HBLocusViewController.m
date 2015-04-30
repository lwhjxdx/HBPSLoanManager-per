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
    [self initMapView];
}

- (void)loadData{
    dataArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",
                 @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",nil];
    [self addPointArray];
}

- (void)initMapView{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTopBarHeight)];
    _mapView.delegate = self;
    [_mapView setZoomLevel:16];
    [self.view addSubview:_mapView];
}


//向地图上加点 模拟假数据
- (void)addPointArray{

    // 添加折线覆盖物
    CLLocationCoordinate2D coors[50] = {0};
    for (int i = 0; i < dataArray.count; i++) {
        coors[i].latitude = 39.315 + i * (i%2)*0.0002;
        coors[i].longitude = 116.304 + i*0.003;
    }
    polyline = [BMKPolyline polylineWithCoordinates:coors count:dataArray.count];

    for (int i = 0; i<dataArray.count; i++) {
        BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
        point.coordinate = coors[i];
        [_mapView addAnnotation:point];
        [_mapView setCenterCoordinate:point.coordinate animated:YES];
    }
    [_mapView addOverlay:polyline];
}


// Override
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay] ;
        polylineView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 1.0;
        
        return polylineView;
    }
    return nil;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    [self setTabbarViewHide:@"YES"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self loadData];
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
