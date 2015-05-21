//
//  UpDataHeaderPicView.m
//  VPImageCropperDemo
//
//  Created by YM on 15/1/12.
//  Copyright (c) 2015年 Vinson.D.Warm. All rights reserved.
//

#import "UpDataHeaderPicView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>


#import "UIImage+FixOrientation.h"
#import "UIImage+WatercColour.h"
#define ORIGINAL_MAX_WIDTH 640.0f

@implementation UpDataHeaderPicView
@synthesize currentVC ;

- (instancetype)initWithFrame:(CGRect)frame upImage:(UpdataImage)up{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        [self setContentMode:UIViewContentModeScaleAspectFill];
        self.userInteractionEnabled         = YES;
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        self.upImage = up;
        [self addGestureRecognizer:portraitTap];
        currentVC = [self findViewController:self];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        [self setContentMode:UIViewContentModeScaleAspectFill];
        self.userInteractionEnabled         = YES;
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        self.upImage = nil;
        [self addGestureRecognizer:portraitTap];
    }
    return self;
}

- (UIImage *)cutImage:(UIView *)view{
    //截图
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    //获取图像
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (void)editPortrait {
    
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    
    
    
    [choiceSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}
-(void)takePhotosWithCamare
{
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([self isRearCameraAvailable]) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        UIViewController *vc = [self findViewController:self];
        currentVC = vc;
        [vc presentViewController:controller
                         animated:YES
                       completion:^(void){
                           NSLog(@"Picker View Controller is presented");
                       }];
    }
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        [self takePhotosWithCamare];
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            UIViewController *vc = [self findViewController:self];
            currentVC = vc;
            [vc presentViewController:controller
                             animated:YES
                           completion:^(void){
                               NSLog(@"Picker View Controller is presented");
                           }];
            
        }
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        
        UIImage *portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        portraitImg = [portraitImg fixOrientation];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        
        
        //如果是拍照返回结果 加水印
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            [portraitImg addWaterColourOnlyInHB];
        }
        
        NSData *imageData = UIImageJPEGRepresentation(portraitImg, 0.6);

        if (self.upImage) {
            self.upImage(imageData);
            _headData = [NSMutableData dataWithData:imageData];

        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH)
        return sourceImage;
   
    CGSize targetSize = CGSizeMake(ORIGINAL_MAX_WIDTH,ORIGINAL_MAX_WIDTH * sourceImage.size.height/sourceImage.size.width);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage      = nil;
    CGSize imageSize       = sourceImage.size;
    CGFloat width          = imageSize.width;
    CGFloat height         = imageSize.height;
    CGFloat targetWidth    = targetSize.width;
    CGFloat targetHeight   = targetSize.height;
    CGFloat scaleFactor    = 0.0;
    CGFloat scaledWidth    = targetWidth;
    CGFloat scaledHeight   = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor  = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor          = widthFactor;// scale to fit height
        else
            scaleFactor          = heightFactor;// scale to fit width
        scaledWidth          = width * scaleFactor;
        scaledHeight         = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor){
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect      = CGRectZero;
    thumbnailRect.origin      = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


//获取view所在的viewController
- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

//
//
//- (UIImage *)fixOrientation:(UIImage *)imageOld {
//    
//    // No-op if the orientation is already correct
//    if (imageOld.imageOrientation == UIImageOrientationUp) return imageOld;
//    
//    // We need to calculate the proper transformation to make the image upright.
//    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    
//    switch (imageOld.imageOrientation) {
//        case UIImageOrientationDown:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, imageOld.size.width, imageOld.size.height);
//            transform = CGAffineTransformRotate(transform, M_PI);
//            break;
//            
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//            transform = CGAffineTransformTranslate(transform, imageOld.size.width, 0);
//            transform = CGAffineTransformRotate(transform, M_PI_2);
//            break;
//            
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, 0, imageOld.size.height);
//            transform = CGAffineTransformRotate(transform, -M_PI_2);
//            break;
//    }
//    
//    switch (imageOld.imageOrientation) {
//        case UIImageOrientationUpMirrored:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, imageOld.size.width, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//            
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, imageOld.size.height, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//    }
//    
//    // Now we draw the underlying CGImage into a new context, applying the transform
//    // calculated above.
//    CGContextRef ctx = CGBitmapContextCreate(NULL, imageOld.size.width, imageOld.size.height,
//                                             CGImageGetBitsPerComponent(imageOld.CGImage), 0,
//                                             CGImageGetColorSpace(imageOld.CGImage),
//                                             CGImageGetBitmapInfo(imageOld.CGImage));
//    CGContextConcatCTM(ctx, transform);
//    switch (imageOld.imageOrientation) {
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            // Grr...
//            CGContextDrawImage(ctx, CGRectMake(0,0,imageOld.size.height,imageOld.size.width), imageOld.CGImage);
//            break;
//            
//        default:
//            CGContextDrawImage(ctx, CGRectMake(0,0,imageOld.size.width,imageOld.size.height), imageOld.CGImage);
//            break;
//    }
//    
//    // And now we just create a new UIImage from the drawing context
//    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
//    UIImage *img = [UIImage imageWithCGImage:cgimg];
//    CGContextRelease(ctx);
//    CGImageRelease(cgimg);
//    return img;
//}
//

@end
