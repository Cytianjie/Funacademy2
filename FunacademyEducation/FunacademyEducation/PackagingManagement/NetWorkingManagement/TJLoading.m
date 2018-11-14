//
//  TJLoading.m
//  2222222
//
//  Created by ZQY on 16/8/29.
//  Copyright © 2016年 ZQY. All rights reserved.
//

#import "TJLoading.h"

@implementation TJLoading

+(TJLoading *)LoadingAppear{

    TJLoading * loading = [[TJLoading alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    loading.loading = loading;
    
    loading.backgroundColor = [UIColor clearColor];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.center = CGPointMake(loading.bounds.size.width/2, loading.bounds.size.height/2);
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 0;
    
    view.backgroundColor = [UIColor clearColor];
    
    [loading addSubview:view];
    
    UIActivityIndicatorView * active = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
    [active startAnimating];
    view.backgroundColor = kColor_RGBA(63, 63, 63, 0.8);
    view.layer.cornerRadius = 5;
    [view addSubview:active];
    
    /*
    UIImageView * loadImage = [[UIImageView alloc]initWithFrame:view.bounds];
    loadImage.image = [UIImage imageNamed:@"tjloadingthree"];
    loading.loadingImage = loadImage;
    
    [view addSubview:loadImage];
    
    [loading rotatingAnimation];
     
     */
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:loading];
    
    
    return loading;

}
-(void)rotatingAnimation{
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat: M_PI * 2];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 1;
    [self.loadingImage.layer addAnimation:animation forKey:@"rotatingAnimation"];
    
    
}
-(void)loadingDisappear{
    [self.loadingImage.layer removeAnimationForKey:@"rotatingAnimation"];
    [self.loading removeFromSuperview];


}
@end
