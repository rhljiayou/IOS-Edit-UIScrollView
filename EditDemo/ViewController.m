//
//  ViewController.m
//  EditDemo
//
//  Created by iHope on 13-9-17.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"image1",@"image2",@"image3",@"image4",@"image5",@"image6",@"image7",@"image8",@"image9",@"image10",@"image11", nil];
    
    EditImageView *editImageView = [[EditImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) withArray:array];
    [self.view addSubview:editImageView];
    editImageView.editDelegate = self;
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)selectImage:(int)index
{
    NSLog(@"处理事件%d",index);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
