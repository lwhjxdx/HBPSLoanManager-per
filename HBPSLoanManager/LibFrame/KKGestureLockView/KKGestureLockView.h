//
//  KKGestureLockView.h
//  KKGestureLockView
//
//  Created by Luke on 8/5/13.
//  Copyright (c) 2013 geeklu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KKGestureLockView;

@protocol KKGestureLockViewDelegate <NSObject>
@optional
- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode;
//BOOL值用来判断是否需要返回原来的状态，即吧button转到未选中状态
- (BOOL)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode;

- (BOOL)gestureLockView:(KKGestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didMovingWithPasscode:(NSString *)passcode;
@end

@interface KKGestureLockView : UIView

@property (nonatomic, strong, readonly) NSArray *buttons;
@property (nonatomic, strong, readonly) NSMutableArray *selectedButtons;

@property (nonatomic, assign) NSUInteger numberOfGestureNodes;
@property (nonatomic, assign) NSUInteger gestureNodesPerRow;

@property (nonatomic, strong) UIImage *normalGestureNodeImage;
@property (nonatomic, strong) UIImage *selectedGestureNodeImage;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong, readonly) UIView *contentView;//the container of the gesture notes
@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, weak) id<KKGestureLockViewDelegate> delegate;

/**
 *  这个方法是用来清除button的状态让其还原到非选中状态
 */
-(void)gestureLockViewClearButtonState;


@end
