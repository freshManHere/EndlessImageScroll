//
//  ViewController.m
//  ImageScrollDemo
//
//  Created by csh on 2017/5/2.
//  Copyright © 2017年 csh. All rights reserved.
//

#import "ViewController.h"
#import "EndLessScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //第一种初始化方式
//    EndLessScrollView *scrol = [[EndLessScrollView alloc]initWithImgNameArray:@[@"http://i0.hdslb.com/bfs/archive/8f4f35e45193b8e10fd415497fcbc6160b77b047.jpg_640x200.jpg",@"http://i0.hdslb.com/bfs/archive/a6d03ed229f24fbe7dd1e51083fc13bada4c1a89.png_640x200.png",@"http://i0.hdslb.com/bfs/archive/e7d3f50418cec533ebf43d81e3adca44f7b0cec6.jpg_640x200.jpg"]];
    //第二种初始化方式
    EndLessScrollView *scrol = [[EndLessScrollView alloc]init];
    scrol.imageNameArray = @[@"http://i0.hdslb.com/bfs/archive/8f4f35e45193b8e10fd415497fcbc6160b77b047.jpg_640x200.jpg",@"http://i0.hdslb.com/bfs/archive/a6d03ed229f24fbe7dd1e51083fc13bada4c1a89.png_640x200.png",@"http://i0.hdslb.com/bfs/archive/e7d3f50418cec533ebf43d81e3adca44f7b0cec6.jpg_640x200.jpg"];
    [self.view addSubview:scrol];
    scrol.currentPageIndicatorTintColor = [UIColor orangeColor];
    scrol.frame = CGRectMake(0,
                            0,
                            [UIScreen mainScreen].bounds.size.width,
                            [UIScreen mainScreen].bounds.size.width/3.2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
