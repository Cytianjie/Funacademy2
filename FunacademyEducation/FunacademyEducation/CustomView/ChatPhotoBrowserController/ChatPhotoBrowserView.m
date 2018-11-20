//
//  ChatPhotoBrowserView.m
//  BabyLove
//
//  Created by tianhongkeji on 15/6/2.
//  Copyright (c) 2015年 赵. All rights reserved.
//

#import "ChatPhotoBrowserView.h"
#import "ChatPhoneCollectionViewCell.h"
@interface ChatPhotoBrowserView ()

@end
@implementation ChatPhotoBrowserView

-(void)createLayout{
    
    
    UICollectionViewFlowLayout *layout                 = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView                                = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor                = [UIColor blackColor];
    self.collectionView.delegate                       = self;
    self.collectionView.dataSource                     = self;
    //注册单元格
    [self.collectionView registerClass:[ChatPhoneCollectionViewCell class] forCellWithReuseIdentifier:@"GradientCell"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.userInteractionEnabled = YES;
    self.collectionView.contentOffset = CGPointMake(self.frame.size.width * self.indexPage, 0);
    [self addSubview: self.collectionView];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backGroundScroViewTapGestureRecognizer:)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        [self.collectionView addGestureRecognizer:tap];
  

}
//手势点击
-(void)backGroundScroViewTapGestureRecognizer:(UITapGestureRecognizer *)tapGeRe{
    if ([self.pBdelegate respondsToSelector:@selector(PhotoBrowserTapGestureRecognizerDelegate:)]) {
        [self.pBdelegate PhotoBrowserTapGestureRecognizerDelegate:self.index];
    }

}
#pragma mark UIScrollViewDelegate

//只要滚动了就会触发

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    
}

//开始拖拽视图

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

{
    
    // NSLog(@"scrollViewWillBeginDragging");
    
}

//完成拖拽

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

{
    //decelerate 分页成功才调用
    if (scrollView == self.collectionView && decelerate) {
         if (self.imageScrowZoom != nil) {
            [self.imageScrowZoom setZoomScale:1 animated:YES];
            self.imageScrowZoom = nil;
           
        }
        
    }
    
    
}

//将开始降速时

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;

{
    
    //NSLog(@"scrollViewWillBeginDecelerating");
    
}


//减速停止了时执行

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.index = scrollView.contentOffset.x/self.bounds.size.width;
    NSLog(@"------ >> %ld",(long)self.index);
    if ([self.pBdelegate respondsToSelector:@selector(PhotoBrowserDelegate:)]) {
        [self.pBdelegate PhotoBrowserDelegate:self.index];
    }
    
}

//滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView

{
 
}

//设置放大缩小的视图，要是uiscrollview的subview

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    if (scrollView != self.collectionView) {
        
        return scrollView.subviews.firstObject;
    }
    
    return nil;
    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView != self.collectionView) {
        
  
    UIImageView * _imageView = scrollView.subviews.firstObject;
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
        
          }
}
//完成放大缩小时调用

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (self.collectionView != scrollView) {
      self.imageScrowZoom = scrollView;
    }
    
    
}// scale between minimum and maximum. called after any 'bounce' animations


//如果你不是完全滚动到滚轴视图的顶部，你可以轻点状态栏，那个可视的滚轴视图会一直滚动到顶部，那是默认行为，你可以通过该方法返回NO来关闭它

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    NSLog(@"scrollViewShouldScrollToTop");
    return YES;
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScrollToTop");
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageDataArray.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChatPhoneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GradientCell" forIndexPath:indexPath];
    cell.scrocview.delegate=self;
    NSString * urlString = [self.imageDataArray objectAtIndex:indexPath.row];
    cell.imageView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[TJToolsClass getPlaceholderImage]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
    
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

     NSLog(@"s++++++++++++++++");
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
