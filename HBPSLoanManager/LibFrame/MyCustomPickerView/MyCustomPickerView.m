//
//  MyCustonPickerView.m
//  MyCustomActionSheetDemo
//
//  Created by newtouch on 14-8-1.
//  Copyright (c) 2014年 qiaoqiao.wu. All rights reserved.
//

#import "MyCustomPickerView.h"



@interface MyCustomPickerView ()
<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *maskView;
    NSInteger maskIndex;
    
}
@property (nonatomic, strong) id receiveData;
@property (nonatomic, strong) NSArray *selctArr;
@end

@implementation MyCustomPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        CGRect frame = [[[UIApplication sharedApplication] keyWindow] frame];
        frame.origin.y = frame.size.height;
        frame.size.height = 224;
        
        self.frame = frame;
        self.contentArray = [NSMutableArray array];
        
        self.backgroundColor = [UIColor lightGrayColor];
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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
    }
    return self;
}
-(void)pickerDataWithCancelBtnBlock:(CancelBtnBlcok )cancleBlock withDoneBtnBlock:(DoneBtnBlock )doneBlock withShowStringArr:(NSArray*)arr
{
    self.cancelBlock = cancleBlock;
    self.doneBlock = doneBlock;
    self.selctArr = arr;
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
    [self hidingPickerView];
}
-(void)doneBtnEvent:(UIButton *)button
{
    self.doneBlock(maskIndex ,self.receiveData);
    [self hidingPickerView];
}

-(void)showInView:(UIView *)view
{
    if (self.contentArray.count) {
        self.receiveData = [self.contentArray objectAtIndex:0];
    }
    
    maskView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        maskView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
        maskView.backgroundColor = [UIColor blackColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.35f animations:^{
         maskView.alpha = 0.3;
        self.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height - self.frame.size.height, kSCREEN_WIDTH, self.frame.size.height);
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        [maskView addGestureRecognizer:tap];
    }];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.frame = CGRectMake(0, 44, kSCREEN_WIDTH, 180);
    pickerView.showsSelectionIndicator = YES;
    [self addSubview:pickerView];
//    [pickerView reloadAllComponents];
}
 
-(void)tapEvent:(UIGestureRecognizer *)recognizer
{
    self.cancelBlock(nil);

    [self hidingPickerView];
    
    [maskView removeGestureRecognizer:recognizer];
}

-(void)hidingPickerView
{
    [UIView animateWithDuration:0.35f animations:^{
        maskView.alpha = 0;
       self.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height, kSCREEN_WIDTH, 224);
       [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [maskView removeFromSuperview];
    }];
    
}

#pragma mark PickerViewDelegate & PickerViewDataSource
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH,45)];
    titleLabel.backgroundColor = [UIColor clearColor];
    if (self.contentArray.count) {
        if ([self.contentArray[row] isKindOfClass:[NSString class]]) {
            titleLabel.text = self.contentArray[row];
        }else{
            NSString *string;
            for (int i = 0; i < self.selctArr.count; i++) {
                if (string) {
                    string = [NSString stringWithFormat:@"%@  %@",string,self.contentArray[row][self.selctArr[i]]];
                }else{
                    string = self.contentArray[row][self.selctArr[i]];
                }
            }
            titleLabel.text = string;
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 45)];
    
    contentView.backgroundColor = [UIColor clearColor];
    [contentView addSubview:titleLabel];
    return contentView;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
 
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (self.contentArray.count) {
        if (self.changedBlock) {
            self.changedBlock(row);
        }
        self.receiveData = self.contentArray[row];
        maskIndex = row;
    }
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

  return [self.contentArray count];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{

    return 45;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.frame.size.width;
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
