//
//  UIImage+FixOrientation.m
//  HBPSLoanManager
//
//  Created by YM on 15/3/29.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "UIImage+FixOrientation.h"

@implementation UIImage (FixOrientation)

- (UIImage *)fixOrientation { // yang ———— 解决内存开销过大问题
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
   
    NSString * imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    imagePath = [imagePath stringByAppendingPathComponent:@"temp.jpg"];

    // ------- end
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL,
                                             self.size.width,
                                             self.size.height,
                                             8,
                                             0,
                                             CGImageGetColorSpace(self.CGImage),
                                             kCGImageAlphaNoneSkipLast);
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    // And now we justcreate a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    // --------- yang
    NSData * imageData = UIImageJPEGRepresentation(img, .5f);
    BOOL isWrite = [imageData writeToFile:imagePath atomically:YES];
    // 干掉img

    if (isWrite) {
        img = [UIImage imageWithContentsOfFile:imagePath];
    }
    // -------- yang end
    return img;
}

@end
