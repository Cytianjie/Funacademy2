//
//  ChatPhotoBrowserView.h
//  BabyLove
//
//  Created by tianhongkeji on 15/6/2.
//  Copyright (c) 2015年 赵. All rights reserved.
//  此类只为图片浏览器作用

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
/**
 *  图片浏览器代理
 */
@protocol PhotoBrowserViewDelegate <NSObject>
/**
 *  当前出现分页的情况就会调用
 *
 *  @param index 当前第几页
 */
-(void)PhotoBrowserDelegate:(NSInteger)index;
/**
 *  点击屏幕就会调用
 *
 *  @param index 当前第几页
 */
-(void)PhotoBrowserTapGestureRecognizerDelegate:(NSInteger)index;

-(void)takeImage:(UIImage *)itemImage;
@end
@interface ChatPhotoBrowserView : UIView<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIScrollView * imageScrowZoom;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger index;//回调用表示第几页
@property(nonatomic,assign)NSInteger indexPage;//进来显示第几页
@property(nonatomic,strong)NSMutableArray * imageDataArray;
@property(nonatomic,assign)id<PhotoBrowserViewDelegate> pBdelegate;

-(void)createLayout;
@end
