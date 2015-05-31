//
//  GestureLockZoomView.m
//  veryWallen
//
//  Created by qiuqiu's imac on 15/3/27.
//  Copyright (c) 2015年 qiuqiu's imac. All rights reserved.
//

#import "GestureLockZoomView.h"

@interface GestureLockZoomView ()

@end



@implementation GestureLockZoomView


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray*)array
{
    if (self = [super initWithFrame:frame]) {
        self.numberArray = array;
    }
    return self;
}





-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView* view in self.subviews) {
        view.layer.borderColor = [UIColor colorWithRed:0.933 green:0.525 blue:0.032 alpha:1.000].CGColor;
        view.layer.borderWidth = 0.3f;
        view.backgroundColor = [UIColor clearColor];
        view.layer.cornerRadius = CGRectGetWidth(view.frame)/2.f;
        view.layer.masksToBounds = YES;
    }
}


-(void)setNumberArray:(NSArray *)numberArray
{
    if (numberArray!=_numberArray) {
        _numberArray= numberArray;
        for (UIView *view in self.subviews) {
            view.backgroundColor = [UIColor clearColor];
        }
        for (NSNumber *number in numberArray) {
            UIView *changeView = [self viewWithTag:[number intValue]+1000];
            changeView.backgroundColor = [UIColor colorWithRed:0.933 green:0.779 blue:0.213 alpha:1.000];
        }
    }
}



@end
