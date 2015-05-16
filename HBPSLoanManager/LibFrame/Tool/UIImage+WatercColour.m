//
//  UIImage+WatercColour.m
//  HBPSLoanManager
//
//  Created by YM on 15/4/10.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "UIImage+WatercColour.h"
#import "HBUserModel.h"
@implementation UIImage (WatercColour)


-(UIImage *)addText:(NSString *)text1 rang:(CGPoint)point
{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    NSDictionary *attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:30.0f], NSFontAttributeName, [UIColor redColor],NSStrokeColorAttributeName,nil];
    [[UIColor redColor]setStroke];
    [text1 drawAtPoint:point withAttributes:attributesDic];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;//获得添加水印后的图片
}

- (NSString *)getTextInfo{

    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss\n"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    NSString *infoString = locationString  ;
    
    
    
    //如果 地址信息已经存储 照片中水印加上地址信息
    if ([HBUserModel getLoactionInfo]) {
        infoString = [infoString stringByAppendingString:[HBUserModel getLoactionInfo]];
    }
    return infoString;
}


- (UIImage *)addText:(NSString *)text1 range:(CGRect)rect{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 5;
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(1,3);
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentRight;
    
    
    NSDictionary *attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:24.0f], NSFontAttributeName,
                                   [UIColor redColor],NSForegroundColorAttributeName,
                                   shadow,NSShadowAttributeName,
                                   @0,NSObliquenessAttributeName,
                                   paragraphStyle,NSParagraphStyleAttributeName ,nil];

    [text1 drawInRect:rect withAttributes:attributesDic];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;//获得添加水印后的图片
}


//添加水印
- (UIImage *)addWaterColourOnlyInHB{
    NSString *infoString = [self getTextInfo];
    UIImage *waterColourImage = [self addText:infoString range:CGRectMake(10, self.size.height - 60,self.size.width-20 , 60)];
    return waterColourImage;
}

@end
