//
//  DateCustomPickerView.m
//  SPDBCCC
//
//  Created by newtouch on 14-10-16.
//  Copyright (c) 2014年 Qiaoqiao.Wu. All rights reserved.
//

#import "DateCustomPickerView.h"
#define currentMonth [currentMonthString integerValue]
@implementation DateCustomPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGRect frame = [[[UIApplication sharedApplication] keyWindow] frame];
        frame.origin.y = frame.size.height;
        frame.size.height = 224;
        
        self.frame = frame;
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
        [self bulidData];
        maskIndex = 0;
    }
    return self;
}

-(void)bulidData
{
    NSDate *date = [NSDate date];
    
    // Get Current Year
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    
    
    // Get Current  Month
    
    [formatter setDateFormat:@"MM"];
    
    currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
    currentMonthString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    if([currentMonthString integerValue]<10){
        currentMonthString =[NSString stringWithFormat:@"0%@",[[NSNumber numberWithInteger:[currentMonthString integerValue]] stringValue]];
    }else{
        currentMonthString =[NSString stringWithFormat:@"%@",[[NSNumber numberWithInteger:[currentMonthString integerValue]] stringValue]];
    }
    
    
    // Get Current  Date
    
    [formatter setDateFormat:@"dd"];
    currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    if([currentDateString integerValue]<10){
        currentDateString =[NSString stringWithFormat:@"0%@",[[NSNumber numberWithInteger:[currentDateString integerValue]] stringValue]];
    }else{
        currentDateString =[NSString stringWithFormat:@"%@",[[NSNumber numberWithInteger:[currentDateString integerValue]] stringValue]];
    }
    
    
    // Get Current  Hour
    [formatter setDateFormat:@"hh"];
    currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    // Get Current  Minutes
    [formatter setDateFormat:@"mm"];
    currentMinutesString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    // Get Current  AM PM
    
    [formatter setDateFormat:@"a"];
    currentTimeAMPMString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // PickerView -  Years data
    
    yearArray = [[NSMutableArray alloc]init];
    
    
    for (int i = 1900; i <= 2050 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
    // PickerView -  Months data
    
    
    monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    
    // PickerView -  Hours data
    
    
    hoursArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    
    // PickerView -  Hours data
    
    minutesArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 60; i++)
    {
        
        [minutesArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
    
    
    // PickerView -  AM PM data
    
    amPmArray = @[@"AM",@"PM"];
    
    
    
    // PickerView -  days data
    
    DaysArray = [[NSMutableArray alloc]init];
    
    for (int i = 1; i <= 31; i++)
    {
        if(i<10){
            [DaysArray addObject:[NSString stringWithFormat:@"0%d",i]];
        }else{
            [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        
    }
    // PickerView - Default Selection as per current Date
    
    
}

-(void)cancelBtnEvent:(UIButton *)button
{
    [self hidingPickerView];
}
-(void)doneBtnEvent:(UIButton *)button
{
    [self hidingPickerView];
    [self.delegate loadDate:[NSString stringWithFormat:@"%@%@%@",[yearArray objectAtIndex:[datePickerView selectedRowInComponent:0]],[monthArray objectAtIndex:[datePickerView selectedRowInComponent:1]],[DaysArray objectAtIndex:[datePickerView selectedRowInComponent:2]]]];
    [self.delegate loadDateString:[NSString stringWithFormat:@"%@%@%@",[yearArray objectAtIndex:[datePickerView selectedRowInComponent:0]],[monthArray objectAtIndex:[datePickerView selectedRowInComponent:1]],[DaysArray objectAtIndex:[datePickerView selectedRowInComponent:2]]]];

}

-(void)showInView:(UIView *)view
{
    maskView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    maskView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    maskView.backgroundColor = [UIColor blackColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.35f animations:^{
        maskView.alpha = 0.3;
        self.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height - self.frame.size.height, 320, self.frame.size.height);
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        [maskView addGestureRecognizer:tap];
    }];
    
    datePickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    datePickerView.backgroundColor = [UIColor whiteColor];
    datePickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    datePickerView.dataSource = self;
    datePickerView.delegate = self;
    datePickerView.frame = CGRectMake(0, 44, self.frame.size.width, 180);
    datePickerView.showsSelectionIndicator = YES;
    [datePickerView selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];
    
    [datePickerView selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
    
    [datePickerView selectRow:[DaysArray indexOfObject:currentDateString] inComponent:2 animated:YES];
    
    [self addSubview:datePickerView];


    //    [pickerView reloadAllComponents];
}

-(void)tapEvent:(UIGestureRecognizer *)recognizer
{
    [self hidingPickerView];
    [maskView removeGestureRecognizer:recognizer];
}

-(void)hidingPickerView
{
    [UIView animateWithDuration:0.35f animations:^{
        maskView.alpha = 0;
        self.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height, 320, 224);
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [maskView removeFromSuperview];
    }];
    
}

#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (component == 0)
    {
        selectedYearRow = row;
        [pickerView reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [pickerView reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [pickerView reloadAllComponents];
        
    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 50, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:20.0f]];
    }
    
    
    
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        
    }
    else if (component == 3)
    {
        pickerLabel.text =  [hoursArray objectAtIndex:row]; // Hours
    }
    else if (component == 4)
    {
        pickerLabel.text =  [minutesArray objectAtIndex:row]; // Mins
    }
    else
    {
        pickerLabel.text =  [amPmArray objectAtIndex:row]; // AM/PM
    }
    
    return pickerLabel;
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
        return [monthArray count];
    }
    else if (component == 2)
    { // day
        
                    if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31;
            }
            else if (selectedMonthRow == 1)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
                
                
            }
            else
            {
                return 30;
            }
     }
    else if (component == 3)
    { // hour
        
        return 12;
        
    }
    else if (component == 4)
    { // min
        return 60;
    }
    else
    { // am/pm
        return 2;
        
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 80;
}

@end
