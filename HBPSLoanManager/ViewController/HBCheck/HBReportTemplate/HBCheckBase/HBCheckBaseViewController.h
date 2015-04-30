//
//  HBCheckBaseViewController.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/31.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBBaseViewController.h"

/*
 此基类主目的为 封装 模板录入时 键盘事件的处理
 */

@interface HBCheckBaseViewController : HBBaseViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    //最终的参数字典
    NSMutableDictionary *_paramDic;
    
    UIScrollView *scrollView;
    CGPoint centPoint;
    CGPoint scrollPoint;
}

//传进来的字典数据 每一个基类都需要
@property (nonatomic,strong) NSMutableDictionary *userDic;


- (void)getScrollClicked;



//处理特殊字段
- (void)handleSpecial;


@end
