//
//  UIImage+WatercColour.h
//  HBPSLoanManager
//
//  Created by YM on 15/4/10.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WatercColour)

-(UIImage *)addText:(NSString *)text1 rang:(CGPoint)point;


-(UIImage *)addText:(NSString *)text1 range:(CGRect)rect;


- (UIImage *)addWaterColourOnlyInHB;

@end
