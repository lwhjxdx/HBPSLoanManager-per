//
//  BaseSlideTabBarViewController.m
//  BaseSlideTabBarViewController
//
//  Created by YM on 14-12-10.
//  Copyright (c) 2014年 YM. All rights reserved.
//

#import "BaseSlideTabBarViewController.h"
#define kViewControllerChange @"ViewControllerChange"

@implementation BaseSlideTabBarViewController
{
    NSInteger _index;
    UIPanGestureRecognizer *pan;
    UIImageView *tempView;
}

- (instancetype)init{
    if (self = [super init]) {
        _index = 0;
    }
    return self;
}
- (id)initWithControllers:(NSArray *)vcArray  UseGesture:(BOOL)use{
    if (self = [super init]) {
        self.controllers = [NSArray arrayWithArray:vcArray];
        self.useGesture = use;
        self.offSetGesture = kWidth/3;
        self.cutAnimation = YES;
        [self setViewControllers:self.controllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if (_useGesture) {
        [self loadGesture];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveChangeNotification:)
                                                 name:kViewControllerChange
                                               object:nil];
    //注册观察者 KVO 观察selectedViewController的值变化 同时更改index
    [self addObserver:self forKeyPath:@"selectedViewController" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setUseGesture:(BOOL)useGesture{
    if (_useGesture!=useGesture) {
        _useGesture = useGesture;
        if (_useGesture) {
            [self loadGesture];
        }else{
            [self cancelGesture];
        }
    }
}

- (void)loadGesture{
    //移动手势
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (void)cancelGesture{
    //取消手势
    [self.view removeGestureRecognizer:pan];
}

- (void)panGesture:(UIPanGestureRecognizer *)pan1{
    static CGPoint x1;
    static CGPoint x2;
    //开始手势
    if (pan1.state==UIGestureRecognizerStateBegan) {
        x1 = [pan1 translationInView:self.view];
    } else
        //结束手势
        if (pan1.state==UIGestureRecognizerStateEnded) {
            x2 = [pan1 translationInView:self.view];
            
            int offSet = x1.x - x2.x;//偏移量
            NSLog(@"offSet  %d   _offSetGesture   %d",offSet,self.offSetGesture);
            if (offSet>_offSetGesture) {
                [self showNextViewController];
            }else if(offSet<-_offSetGesture){
                [self showFrontViewController];
            }
        }
}

- (void)showNextViewController{
    NSLog(@"%s",__func__);
    //设置index的值 主要对index进行控制
    if (_index+1<self.controllers.count) {
        _index =_index+1;
    }else{
        _index = 0;
    }
    [self  showAnimation:nil];
}

- (void)showFrontViewController{
    NSLog(@"%s",__func__);
    //设置index的值 主要对index进行控制
    if (_index>0) {
        _index =_index-1;
    }else{
        _index = self.controllers.count-1;
    }
    [self showAnimation:nil];
}

- (void)showAnimation:(UIViewController *)vc1{
    if (_cutAnimation) {
        //如果需要动画 发送通知   切换
        [[NSNotificationCenter defaultCenter] postNotificationName:kViewControllerChange object:self.selectedViewController];
    }else{
        //无动画效果
        [self setSelectedIndex :_index ];
    }
}

- (void) receiveChangeNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:kViewControllerChange]){
        //通过通知中心 主要是为了实现手势滑动tab切换动画
        UIViewController *vc1 = (UIViewController *)[notification object];;
        UIViewController *vc2 = (UIViewController *)[self.viewControllers objectAtIndex:_index];
        
        //截图
        UIGraphicsBeginImageContext(vc1.view.bounds.size); //currentView 当前的view
        [vc1.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //将当前图像放在最上层
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:vc1.view.bounds];
        imageView.image = viewImage;
        [[UIApplication sharedApplication].keyWindow addSubview:imageView];
        //在下层迅速切换viewController
        [self setSelectedIndex :_index ];
        
        [UIView animateWithDuration:5 animations:^{
            //淡入淡出效果
            imageView.alpha = 0.8;
            imageView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1);
            vc2.view.alpha = 0.0;
            imageView.alpha = 0.5;
            vc2.view.alpha = 0.5;
            imageView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2);
            imageView.alpha = 0.3;
            vc2.view.alpha = 0.8;
            imageView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3);
            imageView.alpha = 0.0;
            vc2.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            //在动画结束后将 图层删除
            [imageView removeFromSuperview];
        }];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"selectedViewController"]){
        //监听selectedViewController值对变化 改变_index KVO
        NSLog(@"selectedViewController  Change");
        _index =  self.selectedIndex;
    }
}

- (void)dealloc{
    //移除观察者
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
