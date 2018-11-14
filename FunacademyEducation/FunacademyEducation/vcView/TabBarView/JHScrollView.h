//
//  LunBoView.h
//  CGShop
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHScrollView;
@protocol lunBoScrollViewDelegate <NSObject>

//选中第几个轮播图片
-(void)lunboScrollViewDelegate:(JHScrollView *)lunboView didSelectIndex:(NSInteger)index;

@end


@interface JHScrollView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
//定时器
@property(nonatomic,strong)NSTimer *time;
//点
@property(nonatomic,strong)UIPageControl *pageCtrl;
// 图片 url string 数组
@property (nonatomic, weak) NSMutableArray *imageArr;
//代理
@property (nonatomic, assign) id<lunBoScrollViewDelegate> delegate;



@end
