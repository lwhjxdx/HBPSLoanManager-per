//
//  HBSignInTool.h
//  HBPSLoanManager
//
//  Created by YM on 15/4/7.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMKLocationService.h"
#import "BMKGeocodeSearch.h"
#import "BMKPointAnnotation.h"

typedef  void (^HBSignIn)(NSMutableDictionary *map);

@interface HBSignInTool : NSObject<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService *_locService;
    BMKGeoCodeSearch* _geocodesearch;
    CLLocationCoordinate2D _userLocationPoint;
    NSMutableDictionary *_addressDic;
}
@property (nonatomic,strong) HBSignIn hbSignInHandle;

- (void)setSignIn:(HBSignIn)signIn;

@end
