//
//  UpDataHeaderPicView.h
//  VPImageCropperDemo
//
//  Created by YM on 15/1/12.
//  Copyright (c) 2015年 Vinson.D.Warm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HBBaseViewController.h"

typedef void (^UpdataImage)(NSData *headerData);
typedef Boolean (^CheckUserInfo)();
@interface UpDataHeaderPicView : UIImageView<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
}
@property (nonatomic,strong) UpdataImage upImage;
@property (nonatomic,weak) UIViewController *currentVC;


@property (nonatomic,strong) NSMutableData *headData;

- (void)editPortrait;
-(void)takePhotosWithCamare;
- (instancetype)initWithFrame:(CGRect)frame upImage:(UpdataImage)up;

@end
