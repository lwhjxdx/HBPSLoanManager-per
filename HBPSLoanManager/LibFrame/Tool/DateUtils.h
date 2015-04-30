#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (int)calculateDay:(NSString *) st withEnd:(NSString *) ed;

+ (NSDate *)parse:(NSString *) str withPattern:(NSString *) pattern;

+ (NSString *)format:(NSDate *) date withPattern:(NSString *) pattern;

+(NSArray *)dateCount:(NSInteger) count withBillDay:(NSString *)billDay;

+(NSString *)currectDay;

+(NSString *)formatMonth:(long) month;

+(NSString *)formatDay:(long)day;

+(NSString *)currectDayWithOut;

+(NSString *)dateFormat:(NSString *)dateString;

+(NSString *)dateFormatSigle:(NSString *)dateString;

+(NSString *)getCurrentMonth;

+(NSString *)getCurrentYear;

+(NSString *)getCurrentDay;
@end 