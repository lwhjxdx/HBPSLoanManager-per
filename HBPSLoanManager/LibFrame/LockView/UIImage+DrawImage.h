//
//  UIImage+DrawImage.h
//  veryWallen
//
//  Created by Peter Hao on 14-9-19.
//  Copyright (c) 2014年 Peter Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DrawImage)
+(UIImage*)screenWithSize:(CGSize)size withColor:(UIColor*)color;
+(UIImage*)screenWithView:(UIView*)view;
@end
