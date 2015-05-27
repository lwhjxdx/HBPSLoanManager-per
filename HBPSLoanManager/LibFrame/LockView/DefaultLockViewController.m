//
//  DefaultLockViewController.m
//  veryWallen
//
//  Created by Peter Hao on 14/12/23.
//  Copyright (c) 2014年 Peter Hao. All rights reserved.
//

#import "DefaultLockViewController.h"
#import "GestureLockView.h"
#import "AFViewShaker.h"
#import "HBLoginViewController.h"
#import "NSUserDefaults+Setting.h"
#import "UIImageView+WebCache.h"

//#define lockViewHeight ((256.f/568.f)*SCREEN_HEIGHT)


@interface DefaultLockViewController ()<KKGestureLockViewDelegate>
@property(nonatomic,strong)UIButton*fogetLock;//忘记手势锁
@property(nonatomic,strong)UILabel*numLabel;
@property(nonatomic,strong)UIImageView*headImgView;
@property(nonatomic,strong)UIView*headView;
@property(nonatomic,strong)GestureLockView*lockView;
@property(nonatomic,assign)int num;

@end

@implementation DefaultLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIImageView *bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"GestureLockView_bgImg"]];
//    [self.view addSubview:bgImgView];
//    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.fogetLock];
    [self.view addSubview:self.numLabel];
    [self.view addSubview:self.lockView];
//    _numLabel.hidden = YES;
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(44);
        make.size.mas_equalTo(CGSizeMake(all_screen_width(72), all_screen_width(72)));
    } ];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@17);
        make.top.equalTo(_headImgView.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        
    }];
    [_fogetLock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-13);
        make.size.mas_equalTo(CGSizeMake(all_screen_width(150), all_screen_higth(25)));
    }];
    [_lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (!iPhone4S) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(all_screen_higth(193), all_screen_width(32), all_screen_higth(119),all_screen_width(32)));
        }else{
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(((193/568.f)*kSCREEN_HEIGHT), all_screen_width(32), ((119/568.f)*kSCREEN_HEIGHT),all_screen_width(32)));
        }
    }];
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:[HBUserModel getHeadImagePath]] placeholderImage:[UIImage imageNamed:@"photo"]];
    _num = gestureWrongNumber-[[NSUserDefaults acquireGestureRecordWrongNumber] intValue];
    
}


#pragma mark -
#pragma mark - setter
-(void)setNum:(int)num
{
    [NSUserDefaults changeGestureRecordWrongNumber:[NSNumber numberWithInt:(gestureWrongNumber-num)]];
    _num = num;
    if (_num==0) {
        [self goBackToHomeLogin:nil];
    }
    if (_num!=gestureWrongNumber) {
        _numLabel.text = [NSString stringWithFormat:@"输入错误，还有%d次机会",_num];
        _numLabel.textColor = [UIColor redColor];
        [self sharkView:_lockView];
    }
}
#pragma mark -
#pragma mark - getter
-(UIButton*)fogetLock
{
    if (!_fogetLock) {
        self.fogetLock = [UIButton buttonWithType:UIButtonTypeSystem];
        _fogetLock.tintColor = KMainColor;
        _fogetLock.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_fogetLock setTitle:@"忘记手势密码？" forState:UIControlStateNormal];
        [_fogetLock addTarget:self action:@selector(goBackToHomeLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fogetLock;
}
-(UILabel*)numLabel{
    if (!_numLabel) {
        self.numLabel = [[UILabel alloc]init];
        _numLabel.text = @"滑动解锁";
//        _numLabel.textColor = [UIColor blackColor];
        _numLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numLabel;
}
-(UIView *)headView
{
    if (!_headView) {
        self.headView = [[UIView alloc]init];
        _headView.layer.cornerRadius = all_screen_width(72) / 2;
        [_headView addSubview:self.headImgView];
        _headView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2f];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_headView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _headView;
}
-(UIImageView*)headImgView
{
    if (!_headImgView) {
        self.headImgView = [[UIImageView alloc]init];
        _headImgView.layer.cornerRadius = all_screen_width(72) / 2;
        _headImgView.layer.masksToBounds = YES;
        _headImgView.image = [UIImage imageNamed:@"photo"];
    }
    return _headImgView;
}

-(GestureLockView*)lockView
{
    if (!_lockView) {
        self.lockView = [[GestureLockView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
        _lockView.delegate = self;
    }
    return _lockView;
}
#pragma mark -
#pragma mark - 添加缩放头像动画
-(void)scanleHedeImgeView{
    if (_numLabel.hidden) {
        _numLabel.alpha = 0;
        _numLabel.hidden = NO;

    }
    [UIView animateWithDuration:0.25f animations:^{
        _numLabel.alpha = 1.f;
        _headView.transform = CGAffineTransformScale([self transformForOrientation], 52.f/72.f, 52.f/72.f);
    }];
    
}
- (CGAffineTransform)transformForOrientation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationLandscapeLeft == orientation) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (UIInterfaceOrientationLandscapeRight == orientation) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (UIInterfaceOrientationPortraitUpsideDown == orientation) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}
#pragma mark -
#pragma mark - KKGestureLockView delegate

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode{
    
}

- (BOOL)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{

    NSArray *arr = [passcode componentsSeparatedByString:@","];
    if (arr.count<3) {
//        [AlertViewTip alertViewTipAutoDismiss:@"手势密码最少覆盖3个点！" title:@"密码格式错误"];
        [self showAlterView:@"手势密码最少覆盖3个点！"];
        [self sharkView:_lockView];
        return YES;
    }
    if ([NSUserDefaults judgeGesturePasswordBy:passcode]) {
        [NSUserDefaults changeGestureRecordWrongNumber:@0];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        return YES;
    }else{
        [self scanleHedeImgeView];
        self.lockView.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selectedWrong"];
        [self performSelector:@selector(lockViewClearButtonState) withObject:nil afterDelay:1.f];
        self.num=_num-1;
        return NO;
    }
    return YES;
}

- (BOOL)gestureLockView:(KKGestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode{
    return YES;
}

-(void)lockViewClearButtonState
{
    [self.lockView gestureLockViewClearButtonState];
    self.lockView.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected"];
}
#pragma mark -
#pragma mark -anyMore
-(void)sharkView:(UIView*)view{
    AFViewShaker *shark = [[AFViewShaker alloc]initWithView:view];
    [shark shake];
}
-(void)closeSelfAndFogotLogonPassword:(UIButton*)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - ButtonAction

-(void)goBackToHomeLogin:(UIButton*)btn
{
//    [self dismissViewControllerAnimated:YES completion:^{
//        [NSUserDefaults deleteGesturePassword];
//        [UserBase deleteUserBase];
//        LoginViewController *login = [[LoginViewController alloc]init];
//        [login showSelf];
//    }];


}

@end
