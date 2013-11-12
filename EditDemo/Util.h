//
//  Util.h
//  EditDemo
//
//  Created by iHope on 13-9-17.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
//按大小截图
+ (UIImage*)imageBy:(UIImage*)image withWidth:(int)width withHight:(int)hight;
//按比例缩放图片
+ (UIImage *)scaleToSize:(UIImage *)image :(CGSize)newsize;
@end
