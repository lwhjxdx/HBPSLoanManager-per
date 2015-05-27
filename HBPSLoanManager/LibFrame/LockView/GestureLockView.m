//
//  GestureLockView.m
//  veryWallen
//
//  Created by Peter Hao on 14/12/23.
//  Copyright (c) 2014年 Peter Hao. All rights reserved.
//

#import "GestureLockView.h"
@interface GestureLockView ()

@end

@implementation GestureLockView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.normalGestureNodeImage = [UIImage imageNamed:@"gesture_node_normal"];
        self.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected"];
        self.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.lineColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
        self.lineWidth = 2.f;
    }
    return self;
}

@end
