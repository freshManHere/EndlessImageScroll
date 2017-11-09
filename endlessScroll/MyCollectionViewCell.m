//
//  MyCollectionViewCell.m
//  BiliBili
//
//  Created by csh on 15/6/2.
//  Copyright (c) 2015年 csh. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "YYWebImage.h"
@interface MyCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MyCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.imageView.backgroundColor = [UIColor greenColor];
}
-(void)setImg:(NSString *)img{
    _img=[img copy];
    if ([img rangeOfString:@"http"].location!=NSNotFound)
    {//项目中你可以自己改变这里的加载图片方式
        
        NSURL *imgUrl = [NSURL URLWithString:img];

        [self.imageView yy_setImageWithURL:imgUrl placeholder:nil];
        
        
    }
    else
    {
        self.imageView.image=[UIImage imageNamed:img];
    }
}

@end
