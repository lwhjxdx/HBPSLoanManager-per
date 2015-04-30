//
//  HBCheckBaseViewController.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/31.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "HBCheckBaseViewController.h"
#import "HBCheckDetailViewController.h"
#define kCellHigh 60
@implementation HBCheckBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBordHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBordShow:) name:UIKeyboardWillShowNotification object:nil];
    centPoint = CGPointMake(kSCREEN_WIDTH/2, (kSCREEN_HEIGHT - kTopBarHeight)/2 + kTopBarHeight );
}




#pragma  mark 键盘

- (void)keyBordShow:(NSNotification *)notifitcation{
    //计算键盘弹出的高度
    CGFloat y = [[notifitcation.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey ] CGRectValue].size.height;
    if (scrollPoint.y +y +kCellHigh/2 > kSCREEN_HEIGHT ) {
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.center = CGPointMake(kSCREEN_WIDTH/2, scrollView.frame.size.height/2 - (scrollPoint.y +y +kCellHigh/2) + kSCREEN_HEIGHT);
        }];
    }
}

- (void)keyBordHide:(NSNotificationCenter *)notifitcation{
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.center = centPoint;
    }];
}


- (void)getScrollClicked{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xxxx)];
    tap.delegate = self;
    [scrollView addGestureRecognizer:tap];
}

- (void)xxxx{
    NSLog(@"XXX:%@",self.userDic);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UITextField class]]) {
        scrollPoint = [touch locationInView:self.view];
    }else{
        [self.view endEditing:YES];
    }
    return NO;
}



//所有子类需要重写此方法 处理特殊字段
- (void)handleSpecial{
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end