//
//  ReportPicCell.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/19.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "ReportPicCell.h"
#import "MyMD5.h"
@implementation ReportPicCell

- (void)awakeFromNib {
    toolView = [[UpDataHeaderPicView alloc] initWithFrame:CGRectZero upImage:^(NSData *headerData) {
        [self fillImageView:headerData];
    }];
    [self.contentView addSubview:toolView];
    picArray = [NSMutableArray array];
    [picArray addObject:_imageView1];
    [picArray addObject:_imageView2];
    [picArray addObject:_imageView3];
    [picArray addObject:_imageView4];
    for (UIView *view in picArray) {
        view.hidden = YES;
    }
    self.textFeildStyleView.layer.cornerRadius = 5;
    self.textFeildStyleView.layer.masksToBounds = YES;
    self.textFeildStyleView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textFeildStyleView.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)takePhoto:(id)sender {
    [toolView editPortrait];
}

//获取图像信息  将图片信息保存到本地 获取路径，将路径保存到valueString 中
- (void)fillImageView:(NSData *)data{
   
    
    NSString *filePath  = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[NSString stringWithFormat:@"/Documents/m%d",arc4random()%1000]];
    
    NSString *fileName = [NSString stringWithFormat:@"%@/%@%d.jpg",filePath,_keyString,arc4random()%1000];
    NSLog(@"fileName   %@",fileName);
    BOOL x = YES;
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&x]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    BOOL success = [data writeToFile:fileName atomically:YES];
    if (success) {
        
        if (_valueString == nil) {
            _valueString = [@"" stringByAppendingString:fileName];
        }else{
            _valueString = [_valueString stringByAppendingString:[NSString stringWithFormat:@",%@",fileName]];
        }
        
        NSArray *imagePathArray = [_valueString componentsSeparatedByString:@","];
        
        //控制图片的显示
        for (NSInteger i = 0; i < imagePathArray.count&&i<picArray.count; i++) {
            UIImageView *imageView = picArray[i];
            if (imageView.hidden) {
                imageView.hidden = NO;
            }
            NSInteger index = 0;
            if ((imagePathArray.count - picArray.count)+100>100) {
                index = imagePathArray.count-picArray.count + i;
            }else{
                index = i;
            }
            
            UIImage *image = [UIImage imageWithContentsOfFile:imagePathArray[index]];
            imageView.image = image;
            image = nil;
            data = nil;
        }
    }
}


- (void)setPicString:(NSString *)picString{
    _valueString = picString;
    NSArray *tempArray = [_valueString componentsSeparatedByString:@","];
        //控制图片的显示
        for (int i = 0; i < tempArray.count&&i<picArray.count; i++) {
            UIImageView *imageView = picArray[i];
            if (imageView.hidden) {
                imageView.hidden = NO;
            }
            int index = 0;
            if ((tempArray.count - picArray.count)+100>100) {
                index = tempArray.count-picArray.count + i;
            }else{
                index = i;
            }
            
            UIImage *image = [UIImage imageWithContentsOfFile:tempArray[index]];
            imageView.image = image;
            image = nil;
    }
}



- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


@end
