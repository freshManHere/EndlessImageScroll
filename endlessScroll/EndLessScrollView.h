//
//  EndLessScrollView.h
//  BiliBili
//
//  Created by csh on 15/10/28.
//  Copyright © 2015年 csh. All rights reserved.
//

/*
 *每个图片的样子 可以修改MyCollectionViewCell这个cell，可以自定义
 */
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ScrollDirection)
{
    ScrollDirectionVertical,
    ScrollDirectionHorizontal
};
@class EndLessScrollView;
@protocol EndLessScrollViewDelegate<NSObject>

/**
 图片点击的代理方法

 @param index 被点击的index
 */
-(void)picDidClickAtIndex:(NSInteger)index;

- (void)scrollView:(EndLessScrollView *)scrollView atIndex:(NSInteger)atIndex;

@end
@interface EndLessScrollView : UIView


/**
 初始化方法

 @param imgNameArray 图片的名字，url字符串（图片带http判断为网络图片）
 */
-(instancetype)initWithImgNameArray:(NSArray *)imgNameArray;


@property(nonatomic,weak)id<EndLessScrollViewDelegate>endLessScrollViewDelegate;

/**
 是否定时滚动 默认为是
 */
@property (nonatomic,assign) BOOL timerEnabled;


/**
 滚动方向 默认为水平方向 
 */
@property (nonatomic,assign)ScrollDirection scrollDirection;

/**
 图片的名字，url字符串（图片带http判断为网络图片）
 */
@property (nonatomic,strong)NSArray *imageNameArray;

/**
 滚动的时间间隔 默认为2s
 */
@property (nonatomic,assign) NSTimeInterval timeInterval;


/**
 pageControl
 */
@property(nonatomic,strong)UIPageControl *pageCon;

/**
 page圆点的底色 默认白色
 */


@property (nonatomic,strong) UIColor *pageIndicatorTintColor;

/**
 当前页page圆点的颜色 默认红色
 */
@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;

@end
