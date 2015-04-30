#import <Foundation/Foundation.h>
#import "math.h"

@interface MathUtils : NSObject

+ (NSString *) formatStr:(NSString *) number;
+ (NSString *) formatDouble:(double) number;
+ (NSString *) formatStrWithDecimal:(NSString *) number;
+ (NSString *) addingWithVal1:(NSString *) val1 AndVal2:(NSString *) val2;
+ (NSString *) subtractingWithVal1:(NSString *) val1 AndVal2:(NSString *) val2;
+ (NSString *) multiplyingWithVal1:(NSString *) val1 AndVal2:(NSString *) val2;
+ (NSString *) dividingWithVal1:(NSString *) val1 AndVal2:(NSString *) val2;
@end
