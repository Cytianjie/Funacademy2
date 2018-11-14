//
//  LunBoView.m
//  CGShop
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JHScrollView.h"

@implementation JHScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
    }
    return self;
}
-(void)setImageArr:(NSMutableArray *)imageArr{


    _imageArr = imageArr;
    
    
    if (imageArr.count == 0) {
        return;
    }
    
    //滑动式图
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, self.bounds.size.height)];
    self.scrollView.contentSize = CGSizeMake(kScreen_Width * (self.imageArr.count +2), self.bounds.size.height);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.contentOffset = CGPointMake(kScreen_Width, 0) ;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.scrollView];
    //点
    self.pageCtrl =[[UIPageControl alloc] initWithFrame:CGRectMake(0,150,kScreen_Width, 30)];
    self.pageCtrl.numberOfPages = self.imageArr.count;
    self.pageCtrl.currentPage = 0;
    self.pageCtrl.pageIndicatorTintColor = [UIColor darkGrayColor];
    //    [pageCtrl addTarget:self action:@selector(pageCtrlAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageCtrl];
    //图片
    
    for (int i = 0; i <self.imageArr.count+2; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreen_Width, 0, kScreen_Width, self.bounds.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;

        imageView.layer.masksToBounds = YES;

        if (i == 0) {
            
           
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr.lastObject] placeholderImage:[TJToolsClass getPlaceholderImage]];
        }else if (i == _imageArr.count+1){

           
             [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr.firstObject] placeholderImage:[TJToolsClass getPlaceholderImage]];
            
        }else{

            
             [imageView sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:i-1]] placeholderImage:[TJToolsClass getPlaceholderImage]];
            
            
        }
        [self.scrollView addSubview:imageView];
    }

    //点击手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianjiTapAction:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [self.scrollView addGestureRecognizer:tap];

    //定时器
    self.time = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    

}
//点击方法
-(void)dianjiTapAction:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(lunboScrollViewDelegate:didSelectIndex:)]) {
        [self.delegate lunboScrollViewDelegate:self didSelectIndex:self.pageCtrl.currentPage];
    }
}
//page方法
-(void)pageCtrlAction:(UIPageControl *)page{

    
}
//定时器方法
-(void)scrollTimer{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + kScreen_Width, 0) animated:YES];
}
//2.滑动视图时,滑动时调用(实时调用)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (self.scrollView.contentOffset.x == 0) {
        self.scrollView.contentOffset = CGPointMake(self.imageArr.count * kScreen_Width , 0);
    }
    if (self.scrollView.contentOffset.x == self.scrollView.contentSize.width - kScreen_Width) {
        self.scrollView.contentOffset = CGPointMake(kScreen_Width , 0);
    }
    
    self.pageCtrl.currentPage = (self.scrollView.contentOffset.x-kScreen_Width)/kScreen_Width;

}

//已经结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"已经结束减速");
    if (self.time == nil) {
        self.time = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    }
    
    

}
//改变偏移量的时候调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
}
//手指将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"手指将要开始拖拽");
    
    [self.time invalidate];
    self.time = nil;

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}
-(void)dealloc{
    [self.time invalidate];
}
@end
