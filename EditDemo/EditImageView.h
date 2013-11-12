//
//  EditImageView.h
//  EditDemo
//
//  Created by iHope on 13-9-17.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

//图片高度
#define ImageHeight 156
//删除按钮tag
#define BtnTag 400
//BigView的tag
#define BgViewTag 300
//列数
#define Column 2
//空隔 
#define Space 2

//协议 
@protocol EditImageViewDelegate <NSObject>

-(void)selectImage:(int)index;

@end

@interface EditImageView : UIScrollView
{
    float x;//坐标x
    float y;//坐标y
    float width;//图像宽度
}
//可编辑状态
@property (nonatomic, assign)BOOL edit;
//图像数组
@property (nonatomic, strong)NSMutableArray *imageArray;
//代理
@property (nonatomic, assign)id<EditImageViewDelegate> editDelegate;
//初始化
- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray*)array;
//创建所有的图像
- (void)createView;
//编辑中
- (void)editView:(BOOL)isEdit;
@end
