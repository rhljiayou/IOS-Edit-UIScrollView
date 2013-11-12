//
//  EditImageView.m
//  EditDemo
//
//  Created by iHope on 13-9-17.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import "EditImageView.h"
#import "QuartzCore/QuartzCore.h"

@implementation EditImageView

- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray*)array
{
    self = [super initWithFrame:frame];
    if (self) {
        _edit = NO;
        self.imageArray = array;
        [self createView];
    }
    return self;
    
}
//创建所有的view
- (void)createView
{
    x = 0;
    y = 0;
    width = self.frame.size.width /Column;
    for (int i = 0; i<_imageArray.count; i++) {
        x = (i%Column)*width;
        y = (i/Column)*(ImageHeight+Space);
        
        if (i%Column != 0) {
            x+=Space*(i%Column);
        }
        
        //bgView
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, ImageHeight)];        
        CALayer *imageLayer = bgView.layer;
        [imageLayer setMasksToBounds:YES];
        [imageLayer setCornerRadius:3];
        bgView.tag = i + BgViewTag;
        [self addSubview:bgView];
        
        //添加图像
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height)];
        imageView.image = [Util imageBy:[UIImage imageNamed:[_imageArray objectAtIndex:i]] withWidth:imageView.frame.size.width*2 withHight:imageView.frame.size.height*2];
        [bgView addSubview:imageView];
        
        //添加删除按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(bgView.frame.size.width - 24, 0, 24, 24);
        [button setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        button.tag = BtnTag +i;
        [button addTarget:self action:@selector(buttonChange:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
        button.hidden = YES;
        
        //在bgview上添加点击手势事件
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tapOnContentView:)];
        [bgView addGestureRecognizer:tapGestureRecognizer];
        
        
    }
    //
    self.contentSize = CGSizeMake(self.frame.size.width, y+ImageHeight);
    //长按手势
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGestureRecognizer:)];
    [self addGestureRecognizer:longGesture];
}

- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSLog(@"tag:%d",tapGestureRecognizer.view.tag);
    if (_edit) {
        [self editView:!_edit];

    }else{
        [_editDelegate selectImage:tapGestureRecognizer.view.tag];
    }
}

- (void)LongPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {        
        [self editView:!_edit];
        
    }
}
-(void)buttonChange:(UIButton*)sender
{
    NSArray *views = self.subviews;
    __block CGRect newframe;
    int index = sender.tag - BtnTag;
    for (int i = index; i < [_imageArray count]; i++)
    {
        UIView *obj = [views objectAtIndex:i];
        __block CGRect nextframe = obj.frame;
        if (i == index)
        {
            //删除这个view
            [obj removeFromSuperview];
        }
        else
        {
            for (UIView *v in obj.subviews)
            {
                //把每个按钮的tag从重设置
                if ([v isMemberOfClass:[UIButton class]])
                {
                    v.tag = i+BtnTag - 1;
                    break;
                }
            }
            //并且位置动画改变
            [UIView animateWithDuration:0.6 animations:^
             {
                 obj.frame = newframe;
             } completion:^(BOOL finished)
             {
                 
             }];
        }
        //记住上一个view的位置 
        newframe = nextframe;
    }
    //数组移除 
    [_imageArray removeObjectAtIndex:index];

}
//是否编辑中
- (void)editView:(BOOL)isEdit
{
    _edit = isEdit;
    for (UIView *view in self.subviews)
    {
        for (UIView *v in view.subviews)
        {
            //所有的uibutton是否显示
            if ([v isMemberOfClass:[UIButton class]])
                [v setHidden:!isEdit];
        }
    }
    
    //缩小大小
    float scale;
    if (_edit) {
        scale = 0.9;
    }else{
        scale = 1.0;
    }
    
    for (UIView *view in self.subviews)
    {
        //动画缩小，放大
        [UIView animateWithDuration:0.1 delay:0.1 options:0  animations:^
         {
             view.transform=CGAffineTransformMakeScale(scale, scale);
         } completion:^(BOOL finished)
         {
             
         }];
    }
}

@end
