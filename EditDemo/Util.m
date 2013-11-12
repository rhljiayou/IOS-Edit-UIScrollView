//
//  Util.m
//  EditDemo
//
//  Created by iHope on 13-9-17.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import "Util.h"

@implementation Util
//按大小截图
+ (UIImage*)imageBy:(UIImage*)image withWidth:(int)width withHight:(int)hight
{
    //缩放图片
    UIImage *image1 = [self scaleToSize:image :CGSizeMake(image.size.width, image.size.height)];
    
    float x = (image1.size.width - width)/2;
    float y = (image1.size.height - hight)/2;
    //截图大小
    CGRect rect = CGRectMake(x, y, width, hight);
    //截图
    CGImageRef imageRef = CGImageCreateWithImageInRect([image1 CGImage], rect);
    //获取截图下来的
    UIImage *image2 = [UIImage imageWithCGImage:imageRef];
    
    return image2;
    
}

//按比例缩放图片
+ (UIImage *)scaleToSize:(UIImage *)image :(CGSize)newsize {
    //图片比例大小
    CGFloat imageScale = image.size.width/image.size.height;
    //缩成图片的比例
    CGFloat newScale = newsize.width/newsize.height;
    //判断，如果图片比例大于缩成图片比例，说明图片宽度尺寸比缩成图片的要大，那么要改变缩成图片的高度，
    if (imageScale>newScale) {
        newsize.width = image.size.width/image.size.height * newsize.height;
    }else{
        //否则，说明图片高度尺寸比缩成图片的要大，那么要改变缩成图片的宽度，
        newsize.height = image.size.height/image.size.width * newsize.width;
    }
    NSLog(@"图片大小：%f，比例 大小%f",imageScale,newScale);
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
