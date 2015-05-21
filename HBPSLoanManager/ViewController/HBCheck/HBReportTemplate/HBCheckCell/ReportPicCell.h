//
//  ReportPicCell.h
//  HBPSLoanManager
//
//  Created by YM on 15/3/19.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpDataHeaderPicView.h"
#import "HaveDelImageView.h"

/*
    此cell为图片上传样式Cell
 由于cell空间有限 特只显示出4张图片 多余四张，覆盖第一张 显示最后一张
 
 valueString 选择图片时候 valueString保存图片的路径，
 点击上传时候 根据 valueString保存图片的路径 将图片打成压缩包上传
 返回一个图片的ID
 获取图片ID后 将路径替换为图片ID 到此时 valueString 保存的为图片ID
 
 
 */

@interface ReportPicCell : UITableViewCell
{
    UpDataHeaderPicView *toolView;
    NSMutableArray *picArray;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet HaveDelImageView *imageView1;
@property (weak, nonatomic) IBOutlet HaveDelImageView *imageView2;
@property (weak, nonatomic) IBOutlet HaveDelImageView *imageView3;
@property (weak, nonatomic) IBOutlet HaveDelImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIView *textFeildStyleView;

@property (nonatomic,copy) NSString *keyString;
@property (nonatomic,copy) NSString *valueString;

- (void)setPicString:(NSString *)picString;

@end
