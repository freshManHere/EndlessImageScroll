//
//  EndLessScrollView.m
//  BiliBili
//
//  Created by csh on 15/10/28.
//  Copyright © 2015年 csh. All rights reserved.
//

#import "EndLessScrollView.h"
#import "MyCollectionViewCell.h"
#define cellID @"cell"
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define maxSection 100
@interface EndLessScrollView()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UICollectionView *endlessCollecionView;

@property(nonatomic,strong)UIPageControl *pageCon;

@property(strong,nonatomic)NSArray *imgArray;

@property(nonatomic,strong)NSTimer *timer;

@end
@implementation EndLessScrollView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.timerEnabled = YES;

    }
    return self;
}
-(instancetype)initWithImgNameArray:(NSArray *)imgNameArray
{
    if (self=[super init])
    {
        self.timerEnabled = YES;
        
        [self addTopImageViewWithImgArr:imgNameArray];
        
        [self addTimerWithTimeInterval:2.0];
    }
    return self;
}

#pragma mark - API
-(void)addTopImageViewWithImgArr:(NSArray *)arr{
    self.imgArray=arr;
    [self addSubview:self.endlessCollecionView];
    [self addSubview:self.pageCon];
    self.pageCon.numberOfPages = arr.count;
}

-(void)setTimerEnabled:(BOOL)timerEnabled
{
    _timerEnabled = timerEnabled;
    if (!timerEnabled)
    {
        if (self.timer)
        {
            [self timerClose];
        }
    }
}
-(void)setTimeInterval:(NSTimeInterval)timeInterval
{
    _timeInterval = timeInterval;
    [self timerClose];
    [self addTimerWithTimeInterval:timeInterval];
}

-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageCon.pageIndicatorTintColor = pageIndicatorTintColor;
}

-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageCon.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
-(void)setImageNameArray:(NSArray *)imageNameArray
{
    if (self.imgArray)
    {
        return;
    }
    self.imgArray = imageNameArray;
    
    [self addTopImageViewWithImgArr:imageNameArray];
    
    [self addTimerWithTimeInterval:(self.timeInterval?self.timeInterval:2)];
}
#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
        
        
        return maxSection;
        
  
   
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        
        return self.imgArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        
        MyCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
      NSString *img=self.imgArray[indexPath.row];
        cell.img=img;
        return cell;
    }
    //调整每个cell间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
        return 0;
        
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        
        
self.pageCon.currentPage=(int)(self.endlessCollecionView.contentOffset.x/self.bounds.size.width+0.5)%self.imgArray.count;
//    NSLog(@"%d",self.pageCon.currentPage);
    }

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self timerClose];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (self.timerEnabled)
    {
        [self addTimerWithTimeInterval:(self.timeInterval?self.timeInterval:2)];

    }
    
        
        
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.endLessScrollViewDelegate respondsToSelector:@selector(picDidClickAtIndex:)]) {
        [self.endLessScrollViewDelegate picDidClickAtIndex:indexPath.item];
    }
 
}
#pragma mark - Timer
-(void)addTimerWithTimeInterval:(NSTimeInterval)interval{
    if (self.timer)
    {
        return;
    }
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer=timer;
}

-(void)timerClose
{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)scrollToNextPage{
    NSIndexPath *currentIndex=[[self.endlessCollecionView indexPathsForVisibleItems]lastObject];
    //马上显示回中间那组的图片
    /*tips:
     * 这里如果只需要自动滚动 其实只需要滚到第一组就行了。
     NSIndexPath *currentIndexReset=[NSIndexPath indexPathForItem:currentIndex.item inSection:0];
     并且只需要2组。
     但是，如果用户用手去拖，定时任务就会停止，他拖到第二组后，后面就没有内容了，就拖不动了。或者在第一组时，直接往前拖，也拖不动了。定时任务可以让他滚到第一组，但是手动拖时，没办法做这个操作，所以这里的解决方案是 多搞几个section。每次定时任务，滚到中间去，这样除非用户一直往前或者往后滚max组，不然不会出这个问题。

     */
    NSIndexPath *currentIndexReset=[NSIndexPath indexPathForItem:currentIndex.item inSection:maxSection/2];
    [self.endlessCollecionView scrollToItemAtIndexPath:currentIndexReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    NSInteger nextItem=currentIndexReset.item+1;
    NSInteger nextSection=currentIndexReset.section;
    if (nextItem==self.imgArray.count) {
        nextItem=0;
        nextSection=nextSection+1;
    }
    NSIndexPath *nextIndex=[NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.endlessCollecionView scrollToItemAtIndexPath:nextIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}
#pragma mark - Frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    //无限滚动的frame
    self.endlessCollecionView.frame=CGRectMake(0,
                                               0,
                                               self.frame.size.width,
                                               self.frame.size.height);
    //page的frame
    CGSize size = [self.pageCon sizeForNumberOfPages:self.imgArray.count ];
    CGFloat x=self.frame.size.width-size.width-10;
    CGFloat y=self.frame.size.height-size.height;
    
    self.pageCon.frame=CGRectMake(x, y, size.width, size.height);
}
#pragma mark - Getter
-(UICollectionView *)endlessCollecionView
{
    if (!_endlessCollecionView)
    {
        //顶上无限滚动
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        //设置头视图高度
        flow.headerReferenceSize=CGSizeMake(0, 0);
        _endlessCollecionView =
        [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
        _endlessCollecionView.showsHorizontalScrollIndicator=NO;
        //滚动方向（横向、纵向）
        flow.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _endlessCollecionView.dataSource=self;
        _endlessCollecionView.delegate=self;
        _endlessCollecionView.translatesAutoresizingMaskIntoConstraints = NO;
        //分页
        _endlessCollecionView.pagingEnabled=YES;
        //注册cell
        [_endlessCollecionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
        
    }
    return _endlessCollecionView;
}

-(UIPageControl *)pageCon
{
    if (!_pageCon)
    {
        _pageCon=[[UIPageControl alloc]init];
        _pageCon.hidesForSinglePage = YES;
        _pageCon.pageIndicatorTintColor = [UIColor whiteColor];
        _pageCon.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageCon;
}

@end
