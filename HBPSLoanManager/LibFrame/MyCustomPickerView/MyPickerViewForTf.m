//
//  MyPickerViewForTf.m
//  SPDBCreditCardCenter
//
//  Created by newtouch on 14-8-20.
//  Copyright (c) 2014年 qiaoqiao.wu. All rights reserved.
//

#import "MyPickerViewForTf.h"

@interface  MyPickerViewForTf()
{
    UIView *maskView;
    NSInteger maskIndex;
}

@end

@implementation MyPickerViewForTf

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect frame = [[[UIApplication sharedApplication] keyWindow] frame];
        frame.origin.y = frame.size.height;
        frame.size.height = 224;
        
        maskView = [[UIView alloc] initWithFrame:self.window.frame];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.0;
        [[[UIApplication sharedApplication] keyWindow] addSubview:maskView];
        [maskView bringSubviewToFront:[[UIApplication sharedApplication] keyWindow]];
        maskView.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        [maskView addGestureRecognizer:tap];
        
        self.contentArray = [NSMutableArray array];
        
        self.backgroundColor = [UIColor lightGrayColor];
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.showsTouchWhenHighlighted = YES;
        cancelButton.frame = CGRectMake(4, 2, 40, 40);
        [cancelButton addTarget:self action:@selector(cancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        doneButton.showsTouchWhenHighlighted = YES;
        doneButton.frame = CGRectMake(self.frame.size.width - 44, 2, 40, 40);
        [doneButton addTarget:self action:@selector(doneBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:doneButton];
        
        maskIndex = 0;
        
        
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(keyboardWillShow)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
        
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(keyboardWillHidden)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
        
    }
    return self;
}

-(void)pickerDataWithCancelBtnBlock:(CancelBtnBlcok )cancleBlock withDoneBtnBlock:(DoneBtnBlock )doneBlock withChangedEventBlock:(ChangedEventBlock )changedBlock
{
    self.cancelBlock = cancleBlock;
    self.doneBlock = doneBlock;
    self.changedBlock = changedBlock;
    
    
}

-(void)cancelBtnEvent:(UIButton *)button
{
    self.cancelBlock(button);
}
-(void)doneBtnEvent:(UIButton *)button
{
    self.doneBlock(maskIndex ,nil);
}


-(void)tapEvent:(UIGestureRecognizer *)recognizer
{
    [self keyboardWillHidden];
    self.cancelBlock(nil);
}

-(void)keyboardWillShow
{
     maskView.hidden = NO;
    [UIView animateWithDuration:0.35f animations:^{
    
        maskView.alpha = 0.3f;
    }];
}

-(void)keyboardWillHidden
{
    [UIView animateWithDuration:0.35f animations:^{
        maskView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        maskView.hidden = YES;
    }];
 
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
