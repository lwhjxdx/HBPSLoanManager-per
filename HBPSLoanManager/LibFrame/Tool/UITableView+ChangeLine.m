//
//  UITableView+ChangeLine.m
//  HBPSLoanManager
//
//  Created by MC700 on 15/5/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "UITableView+ChangeLine.h"

@implementation UITableView (ChangeLine)

-(void)setLIneMethond
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

@end
