//
//  UIImage+DrawImage.m
//  veryWallen
//
//  Created by Peter Hao on 14-9-19.
//  Copyright (c) 2014年 Peter Hao. All rights reserved.
//

#import "UIImage+DrawImage.h"

@implementation UIImage (DrawImage)
+(UIImage*)screenWithSize:(CGSize)size withColor:(UIColor*)color
{
    //开始截图
    UIGraphicsBeginImageContextWithOptions(size, YES, 1.0);
    //获取图像
    UILabel*label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.backgroundColor = color;
    
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *reslutImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  reslutImage;
}
+(UIImage*)screenWithView:(UIView*)view
{
    UIColor *viewColor = view.backgroundColor;
    view.backgroundColor = [UIColor whiteColor];
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 1.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *reslutImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    view.backgroundColor = viewColor;
    return  reslutImage;
}

@end
