//
//  HBCheckFirstBaseController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/31.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckFirstBaseController.h"



@implementation HBCheckFirstBaseController


//获取所有参数 将参数存放到 _paramDic中
- (void)getAllParams{
    if (_paramDic == nil) {
        _paramDic = [NSMutableDictionary dictionary];
    }
    
    for (UIView *view in _cellArray) {

            NSString *keyString = [view valueForKey:@"keyString"];
            NSString *valueString = [view valueForKey:@"valueString"];
            if (valueString) {
                [_paramDic setObject:valueString forKey:keyString];
            }else{
                [_paramDic setObject:kDefaultValue forKey:keyString];
            }
        
        
        NSString *subKeyString = [view valueForKey:@"subKeyString"];
        NSString *subValueString = [view valueForKey:@"subValueString"];

        if (subKeyString && subValueString) {
            [_paramDic setObject:subValueString   forKey:subKeyString];
        }
    }
    
    //处理特殊字段 （imageInfo）
    [self handleSpecial];
    NSLog(@"HBCheckFirstBaseController:dic = %@",_paramDic);
}

-(void)pushCheckNextVC:(HBCheckNextBaseController*)vc
{
    vc.className = self.class;
    [self pushViewController:vc animated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_paramDic) {
        _paramDic = [NSMutableDictionary dictionaryWithDictionary: self.userDic];
    }
    NSLog(@"HBCheckFirstBaseController:viewDidAppear:%@",_paramDic);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
