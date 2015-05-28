//
//  HBSignInTool.m
//  HBPSLoanManager
//
//  Created by YM on 15/4/7.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBSignInTool.h"



@implementation HBSignInTool

//初始化定位服务
- (void)initLocation{
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _addressDic = [NSMutableDictionary dictionary];
    //启动LocationService
    [_locService startUserLocationService];
}

//实现相关delegate 处理位置信息更新

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (_addressDic) {
        [_addressDic setObject:userLocation.location forKey:@"location"];
    }
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
        [self signInWithDic:_addressDic];
        NSLog(@"反geo检索发送失败");
    }
}

//获取地址解码
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
  
    [_locService stopUserLocationService];
    _locService = nil;
    if (error == 0) {
        
        if (_addressDic && result.address) {
            [_addressDic setObject:result.address forKey:@"address"];
        };
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
    [self signInWithDic:_addressDic];
}



- (void)setSignIn:(HBSignIn)signIn{
    self.hbSignInHandle = signIn;
    
    //启动定位
    [self initLocation];
}

- (void)signInWithDic:(NSMutableDictionary *)dic{
    
    [_locService stopUserLocationService];
    _locService = nil;
    
    
    NSMutableDictionary *dataDic ;
    if (dic[@"location"]) {
        dataDic = [NSMutableDictionary dictionary];
        [dataDic setObject:dic[@"location"] forKey:@"location"];
    }
    
    if (dic[@"address"] && dataDic) {
        [dataDic setObject:dic[@"address"] forKey:@"address"];
    }
    
    if (self.hbSignInHandle) {
        self.hbSignInHandle(dataDic);
    }
}


@end
