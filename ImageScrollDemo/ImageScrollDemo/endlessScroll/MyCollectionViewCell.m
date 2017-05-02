//
//  MyCollectionViewCell.m
//  BiliBili
//
//  Created by csh on 15/6/2.
//  Copyright (c) 2015年 csh. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "YYKit.h"
@interface MyCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MyCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)setImg:(NSString *)img{
    _img=[img copy];
    if ([img rangeOfString:@"http"].location!=NSNotFound)
    {//我这里网络加载图片用的是YYKit的,项目中你可以自己改变这里（YYKit--你值得拥有）
        NSURL *imgUrl = [NSURL URLWithString:img];
        [self.imageView setImageWithURL:imgUrl options:YYWebImageOptionProgressive];
        
    }
    else
    {
        self.imageView.image=[UIImage imageNamed:img];
    }
}

@end
