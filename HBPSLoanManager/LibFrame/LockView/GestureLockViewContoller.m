//
//  GestureLockViewContoller.m
//  veryWallen
//
//  Created by Peter Hao on 14/12/23.
//  Copyright (c) 2014年 Peter Hao. All rights reserved.
//

#import "GestureLockViewContoller.h"
#import "GestureLockView.h"
#import "UIImage+DrawImage.h"
#import "AFViewShaker.h"
#import "GestureLockZoomView.h"
#import "NSUserDefaults+Setting.h"

@interface GestureLockViewContoller ()<KKGestureLockViewDelegate>

@property(nonatomic,strong)GestureLockView *lockView;
@property(nonatomic,strong)GestureLockZoomView *zoomLockView;
@property(nonatomic,strong)UILabel *numLabel;
@property(nonatomic,strong)NSString *lockStr;
@end

@implementation GestureLockViewContoller
-(void)sharkView:(UIView*)view{
    AFViewShaker *shark = [[AFViewShaker alloc]initWithView:view];
    [shark shake];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.lockView];
    self.titleLabel.text = @"设置手势密码";
    [_lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (!iPhone4S) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(all_screen_higth(193), all_screen_width(32), all_screen_higth(119),all_screen_width(32)));
        }else{
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(((193/568.f)*kSCREEN_HEIGHT), all_screen_width(32), ((119/568.f)*kSCREEN_HEIGHT),all_screen_width(32)));
        }
    }];
    [self.view addSubview:self.zoomLockView];
    [_zoomLockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(87);
        make.size.mas_equalTo(CGSizeMake(all_screen_width(40), all_screen_width(40)));
    }];
    [self.view addSubview:self.numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_zoomLockView.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
-(UILabel*)numLabel{
    if (!_numLabel) {
        self.numLabel = [[UILabel alloc]init];
        _numLabel.text = @"设置手势密码";
        _numLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numLabel;
}

-(GestureLockZoomView*)zoomLockView
{
    if (!_zoomLockView) {

        self.zoomLockView = [[[NSBundle mainBundle] loadNibNamed:@"GestureLockZoomView" owner:nil options:nil] firstObject];
    }
    return _zoomLockView;
}
-(GestureLockView*)lockView
{
    if (!_lockView) {
        self.lockView = [[GestureLockView alloc]initWithFrame:CGRectMake(0, 0, 211, 240)];
        _lockView.delegate = self;
    }
    return _lockView;
}
- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode{
    
}

- (BOOL)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    NSArray *arr = [passcode componentsSeparatedByString:@","];
    if (arr.count<3) {
        [self showAlterView:@"手势密码最少覆盖3个点！"];
//        [AlertViewTip alertViewTipAutoDismiss:@"手势密码最少覆盖3个点！" title:@"密码格式错误"];
        [self sharkView:_lockView];
        return YES;
    }
    NSMutableArray *numArr = [NSMutableArray array];
    for (NSString *string in arr) {
        [numArr addObject:[NSNumber numberWithInt:([string intValue]+1)]];
    }
    self.zoomLockView.numberArray = numArr;

    
    
    if ([passcode isEqualToString:_lockStr]) {
        [NSUserDefaults changeGesturePasswordByPassword:passcode];
        [self showAlterView:@"手势密码设置成功"];
        [self.navigationController popViewControllerAnimated:YES];
        [NSUserDefaults changeGestureBool:YES];
    }else if(_lockStr==nil){
        self.lockStr = passcode;
        self.numLabel.text = @"绘制第二次解锁图案";
        _numLabel.textColor = [UIColor blackColor];
    }else{
        _lockStr = nil;
        self.numLabel.text = @"两次图案不同，重新绘制解锁图案";
        [self sharkView:_numLabel];
        _numLabel.textColor = [UIColor colorWithRed:0.933 green:0.525 blue:0.032 alpha:1.000];
    }
    return YES;
}

- (BOOL)gestureLockView:(KKGestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode{
    self.lockStr = nil;
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
