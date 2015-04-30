#import "DateUtils.h"

@implementation DateUtils

+ (int)calculateDay:(NSString *) st withEnd:(NSString *) ed
{
	return [DateUtils calculateDay:st withEnd:ed andPattern:@"yyyyMMdd"];;
}

+ (int)calculateDay:(NSString *) st withEnd:(NSString *) ed andPattern:(NSString *) pattern
{
	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];   
	[dateFormatter setDateFormat:pattern]; 
	NSDate *stDt=[dateFormatter dateFromString:st];   
	NSDate *edDt=[dateFormatter dateFromString:ed]; 
	NSTimeInterval time=[stDt timeIntervalSinceDate:edDt];
	int days=((int)fabs (time))/(3600*24);
	return days;
}

+ (NSDate *)parse:(NSString *) str withPattern:(NSString
                                                *) pattern
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:pattern];
    return [dateFormatter dateFromString:str]; 
}

+ (NSString *)format:(NSDate *) date withPattern:(NSString *) pattern
{
	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:pattern];
    return [dateFormatter stringFromDate:date];
}
//
+(NSArray *)dateCount:(NSInteger) count withBillDay:(NSString *)billDay
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSMutableArray *array=[NSMutableArray array];
    NSMutableArray *arrayYear=[NSMutableArray array];
    NSMutableArray *arrayMonth=[NSMutableArray array];
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    int temp=0;
    long year=[comps year];long month=[comps month];
    NSString *monthStr;
    if([billDay integerValue]-[comps day]>0){
        temp=1;
        month--;
    }
    
    for(int i=0;i<count;i++){
        
        if(month==0){
            year-=1;
            month=12;
        }
        if(month<10){
            
            monthStr=[NSString stringWithFormat:@"0%ld",month];
            
            [arrayMonth addObject:[NSString stringWithFormat:@"%@",monthStr]];
            
        }else{
            
            [arrayMonth addObject:[NSString stringWithFormat:@"%ld",month]];
            
        }
        [arrayYear addObject:[NSString stringWithFormat:@"%ld",year]];
        month--;
    }
    [[arrayYear reverseObjectEnumerator] allObjects];
    [[arrayMonth reverseObjectEnumerator] allObjects];
    [array addObject:arrayYear];
    [array addObject:arrayMonth];
    
    
    return array;
}

+(NSString *)currectDay
{
    return [NSString stringWithFormat:@"%@-%@-%@",[DateUtils getCurrentYear],[DateUtils getCurrentMonth],[DateUtils getCurrentDay]];
}

+(NSString *)currectDayWithOut
{
    return [NSString stringWithFormat:@"%@%@%@",[DateUtils getCurrentYear],[DateUtils getCurrentMonth],[DateUtils getCurrentDay]];
}
//当前的年
+(NSString *)getCurrentYear
{
    NSDate *dateTime = [NSDate date];
    //Get Current Year
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString * currentyearString = [NSString stringWithFormat:@"%@",
                                    [formatter stringFromDate:dateTime]];
    return currentyearString;
}
//当前的月
+(NSString *)getCurrentMonth
{
    NSDate *dateTime = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    
    NSString *currentMonthString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:dateTime]];
    return currentMonthString;
}
//当前的日
+(NSString *)getCurrentDay
{
    NSDate *dateTime = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:dateTime]];
    return currentDateString;
}

+(NSString *)formatMonth:(long) month
{
    if(month<10){
        return [NSString stringWithFormat:@"0%@",[[NSNumber numberWithInteger:month] stringValue]];
    }else{
        return  [NSString stringWithFormat:@"%@",[[NSNumber numberWithInteger:month] stringValue]];
    }
}

+(NSString *)formatDay:(long)day
{
    if(day<10){
        return [NSString stringWithFormat:@"0%@",[[NSNumber numberWithInteger:day] stringValue]];
    }else{
        return  [NSString stringWithFormat:@"%@",[[NSNumber numberWithInteger:day] stringValue]];
    }

}

//格式化的日期
+(NSString *)dateFormat:(NSString *)dateString
{
    if(dateString.length ==8){
        return [NSString stringWithFormat:@"%@-%@-%@",[dateString substringWithRange:NSMakeRange(0, 4)],[dateString substringWithRange:NSMakeRange(4, 2)],[dateString substringWithRange:NSMakeRange([dateString length] - 2, 2)]];
    }else{
        return @"";
    }
}

+(NSString *)dateFormatSigle:(NSString *)dateString
{
    if(dateString.length ==4){
        return [NSString stringWithFormat:@"%@/%@",[dateString substringWithRange:NSMakeRange(0, 2)],[dateString substringWithRange:NSMakeRange([dateString length] - 2, 2)]];
    }else{
        return @"";
    }
}


@end