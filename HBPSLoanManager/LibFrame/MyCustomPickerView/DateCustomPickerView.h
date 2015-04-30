//
//  DateCustomPickerView.h
//  SPDBCCC
//
//  Created by newtouch on 14-10-16.
//  Copyright (c) 2014年 Qiaoqiao.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DateCustomPickerView;

@protocol DateCustomPickerDelegate <NSObject>
@optional
-(void)loadDate:(NSString *) date;
-(void)loadDateString:(NSString *) date;
@end
@interface DateCustomPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *maskView;
    NSInteger maskIndex;
    UIPickerView *datePickerView;
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *DaysArray;
    NSArray *amPmArray;
    NSArray *hoursArray;
    NSMutableArray *minutesArray;
    NSString *currentDateString;
    NSString *currentMonthString;
    NSString *currentyearString;
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    NSString *currentHourString;
    NSString *currentMinutesString;
    NSString *currentTimeAMPMString;
    BOOL firstTimeLoad;
}
@property (nonatomic ,strong) id<DateCustomPickerDelegate> delegate;
-(void)showInView:(UIView *)view;

@end
