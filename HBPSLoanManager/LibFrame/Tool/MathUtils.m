#import "MathUtils.h"

@implementation MathUtils

//千位格式化末尾没有.00
+ (NSString *) formatStr:(NSString *) number
{
    double d = [number doubleValue];
    return [MathUtils formatDouble:d];
}

+ (NSString *) formatDouble:(double) number
{
    NSNumber *num = [NSNumber numberWithDouble:number];
    NSString *temp = [num stringValue];
    NSRange range = [temp rangeOfString:@"."];
    if (range.location != NSNotFound)
    {
        temp = [temp substringFromIndex:range.location];
    }
    else
    {
        temp = [[NSString alloc] init];
    }
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *str = [formatter stringFromNumber:num];
    return [NSString stringWithFormat:@"%@%@",str,temp];
}

//千位格式化末尾.00
+ (NSString *) formatStrWithDecimal:(NSString *) number
{
    double d = [number doubleValue];
    return [MathUtils formatDoubleWithDecimal:d yuanStr:number];
}

+ (NSString *) formatDoubleWithDecimal:(double) number yuanStr:(NSString *)numStr
{
    NSString *temp = [NSString stringWithFormat:@"%.2f",number];
    //temp = 2000.00
    temp = [temp substringFromIndex:temp.length - 3];
    //temp = 2000
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *num = [NSNumber numberWithDouble:number];
    //2000
    
    NSString *str = [formatter stringFromNumber:num];
    //2000
    
    for(int i=0; i<[numStr length]; i++){
       NSString * tempStr =[numStr substringWithRange:NSMakeRange(i, 1)];
        if([tempStr isEqualToString:@"."]){
            return str;
        }
    }
    return [NSString stringWithFormat:@"%@%@",str,temp];
}
//加法
+ (NSString *) addingWithVal1:(NSString *) val1 AndVal2:(NSString *) val2
{
    NSDecimalNumber *calValue1 = [NSDecimalNumber decimalNumberWithString:val1];
    NSDecimalNumber *calValue2 = [NSDecimalNumber decimalNumberWithString:val2];
    NSDecimalNumber *rs = [calValue1 decimalNumberByAdding:calValue2];
    NSNumber *num = [NSNumber numberWithDouble:[rs doubleValue]];
    return [num stringValue];
}
//减法
+ (NSString *) subtractingWithVal1:(NSString *) val1 AndVal2:(NSString *) val2
{
    NSDecimalNumber *calValue1 = [NSDecimalNumber decimalNumberWithString:val1];
    NSDecimalNumber *calValue2 = [NSDecimalNumber decimalNumberWithString:val2];
    NSDecimalNumber *rs = [calValue1 decimalNumberBySubtracting:calValue2];
    NSNumber *num = [NSNumber numberWithDouble:[rs doubleValue]];
    return [num stringValue];
}
//乘法
+ (NSString *) multiplyingWithVal1:(NSString *) val1 AndVal2:(NSString *) val2
{
    NSDecimalNumber *calValue1 = [NSDecimalNumber decimalNumberWithString:val1];
    NSDecimalNumber *calValue2 = [NSDecimalNumber decimalNumberWithString:val2];
    NSDecimalNumber *rs = [calValue1 decimalNumberByMultiplyingBy:calValue2];
    NSNumber *num = [NSNumber numberWithDouble:[rs doubleValue]];
    return [num stringValue];
}
//除法
+ (NSString *) dividingWithVal1:(NSString *) val1 AndVal2:(NSString *) val2
{
    NSDecimalNumber *calValue1 = [NSDecimalNumber decimalNumberWithString:val1];
    NSDecimalNumber *calValue2 = [NSDecimalNumber decimalNumberWithString:val2];
    NSDecimalNumber *rs = [calValue1 decimalNumberByDividingBy:calValue2];
    NSNumber *num = [NSNumber numberWithDouble:[rs doubleValue]];
    return [num stringValue];
}
@end
