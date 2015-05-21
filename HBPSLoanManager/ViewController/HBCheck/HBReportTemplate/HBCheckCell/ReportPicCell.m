//
//  ReportPicCell.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/19.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "ReportPicCell.h"
#import "MyMD5.h"
#import "ImageWithDelCollectionViewCell.h"

static NSString  *midleCellItem = @"midleCellItem";

@interface ReportPicCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *imagePathArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@property(nonatomic,strong)UIImageView*bigImageView;
@property(nonatomic,strong)UIView*bigView;
@property(nonatomic,strong)UIButton*closeBtn;
@property(nonatomic,assign)NSInteger collectionNum;
@end
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
    [_imageView1.delBtn addTarget:self action:@selector(delteImage:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView2.delBtn addTarget:self action:@selector(delteImage:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView3.delBtn addTarget:self action:@selector(delteImage:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView4.delBtn addTarget:self action:@selector(delteImage:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView1.delBtn addTarget:self action:@selector(delteImage:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)]];
    [_imageView2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)]];
    [_imageView3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)]];
    [_imageView4 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)]];
    for (UIView *view in picArray) {
        view.hidden = YES;
    }
    self.textFeildStyleView.layer.cornerRadius = 5;
    self.textFeildStyleView.layer.masksToBounds = YES;
    self.textFeildStyleView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textFeildStyleView.layer.borderWidth = 1;

}
- (void)delteImage:(UIButton*)btn
{
    if ([btn.superview isKindOfClass:[HaveDelImageView class]]) {
        HaveDelImageView *delView = (HaveDelImageView*)btn.superview;
        delView.hidden = YES;
        NSLog(@"_valueString%@",_valueString);
        
        NSInteger tag = delView.tag - 10000;
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[_valueString componentsSeparatedByString:@","]];
        [tempArr removeObjectAtIndex:tag];
        _valueString = nil;
        for (int i = 0; i < tempArr.count; i++) {
            if (_valueString == nil) {
                _valueString = tempArr[i];
            }else{
                _valueString = [_valueString stringByAppendingFormat:@",%@",tempArr[i]];
            }
        }
        [self setPicString:_valueString];
    }
}
- (void)showBigImage:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIImageView *img = (UIImageView*)tap.view;
    if (!img.image) {
        return;
    }
    [self addBigImageViewWithImage:img.image];
    
}
-(void)addBigImageViewWithImage:(UIImage*)image
{
    self.bigImageView = [[UIImageView alloc] initWithImage:image];
//    _bigImageView.frame = CGRectZero;
    _bigImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH);

    self.bigView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    _bigView.userInteractionEnabled = NO;
    _bigView.center = [[UIApplication sharedApplication] keyWindow].center;
    _bigImageView.center = _bigView.center;
    [self.bigView addSubview:_bigImageView];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.bigView];
    [_bigView.layer addAnimation:[self runAnimStartValue:0.1f endValue:1.f] forKey:@"show"];
    
//    _bigView.frame = CGRectMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2, 0, 0);
//    [UIView animateWithDuration:0.25f animations:^{
//        _bigView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
//    } completion:^(BOOL finished) {
//        _bigView.userInteractionEnabled = YES;
//    }];
}
-(CAKeyframeAnimation*)runAnimStartValue:(CGFloat)start endValue:(CGFloat)end{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(start, start, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(end, end, 1)]];
    animation.keyTimes = @[ @0, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .25f;
    animation.delegate = self;
    return animation;

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _bigView.userInteractionEnabled = YES;
    if ([_bigView.layer animationForKey:@"hidden"] == anim) {
        [_bigView removeFromSuperview];
        [_bigImageView removeFromSuperview];
    }
}

-(UIView *)bigView
{
    if (!_bigView) {
        self.bigView = [[UIView alloc]initWithFrame:CGRectZero];
        [_bigView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAction:)]];
        _bigView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    }
    return _bigView;
}
//-(UIButton *)closeBtn
//{
//    if (!_closeBtn) {
//        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _closeBtn.frame = CGRectMake(kSCREEN_WIDTH / 2 - 30, kSCREEN_HEIGHT - 80, 60, 40);
//        [_closeBtn setBackgroundColor:[UIColor orangeColor]];
//        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _closeBtn;
//}
-(void)closeAction:(id)sender
{
    _bigView.userInteractionEnabled = NO;
    [_bigView.layer addAnimation:[self runAnimStartValue:1.f endValue:0.f] forKey:@"hidden"];

//    [UIView animateWithDuration:5.f animations:^{
//        _bigView.frame = CGRectMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 2, 0, 0);
//        _bigImageView.alpha = 0;
////        _bigImageView.frame = CGRectMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 2, 0, 0);
//    } completion:^(BOOL finished) {
//        [_bigView removeFromSuperview];
//        [_bigImageView removeFromSuperview];
//    }];
 
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)takePhoto:(id)sender {
    [toolView takePhotosWithCamare];
}
-(NSString *)gettingFillePath
{
        return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[NSString stringWithFormat:@"/Documents/userImageFile"]];
}
//获取图像信息  将图片信息保存到本地 获取路径，将路径保存到valueString 中,图片名称以时间戳命名，确保唯一性
- (void)fillImageView:(NSData *)data{
   
    
    NSString *filePath  = [self gettingFillePath];
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    NSString *infoString = locationString;

    NSString *fileName = [NSString stringWithFormat:@"%@%@%d.jpg",_keyString,infoString,arc4random()%1000];
    
    BOOL x = YES;
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&x]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }

    BOOL success = [data writeToFile:[NSString stringWithFormat:@"%@/%@",filePath,fileName] atomically:YES];
    if (success) {
        if (_valueString == nil) {
            _valueString = [@"" stringByAppendingString:fileName];
        }else{
            _valueString = [_valueString stringByAppendingString:[NSString stringWithFormat:@",%@",fileName]];
        }
        
        imagePathArray = [_valueString componentsSeparatedByString:@","];
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:imagePathArray];
        while (tempArr.count > 4){
            [tempArr removeObjectAtIndex:0];
        };
        //控制图片的显示
        _valueString = nil;
        for (int i = 0; i < tempArr.count; i++) {
            if (_valueString == nil) {
                _valueString = tempArr[i];
            }else{
                _valueString = [_valueString stringByAppendingFormat:@",%@",tempArr[i]];
            }
        }
        imagePathArray = tempArr;
        for (NSInteger i = 0; i < imagePathArray.count&&i<picArray.count; i++) {
            HaveDelImageView *imageView = picArray[i];
            if (imageView.hidden) {
                imageView.hidden = NO;
            }
            NSInteger index = 0;
            if ((imagePathArray.count - picArray.count)+100>100) {
                index = imagePathArray.count-picArray.count + i;
            }else{
                index = i;
            }
            
            UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",filePath,imagePathArray[index]]];
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
//    imagePathArray = tempArray;
//    [self.imageCollectionView reloadData];
        for (int i = 0; i < tempArray.count; i++) {
            HaveDelImageView *imageView = picArray[i];
            if (imageView.hidden) {
                imageView.hidden = NO;
            }
           
//            int index = 0;
//            if ((tempArray.count - picArray.count)+100>100) {
//                index = (int)tempArray.count-(int)picArray.count + i;
//            }else{
//                index = i;
//            }
            
            UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[self gettingFillePath],tempArray[i]]];
            imageView.image = image;
            image = nil;
    }
    for (int k = 0; k < picArray.count; k++) {
        if (k>=tempArray.count) {
            HaveDelImageView *imageView = picArray[k];
            imageView.hidden = YES;
        }
    }
}

#pragma mark - collecthionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (imagePathArray) {
        return imagePathArray.count;
    }
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageWithDelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:midleCellItem forIndexPath:indexPath];
    cell.midleImageView.image = imagePathArray[indexPath.row];
    
    return cell;
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


@end
