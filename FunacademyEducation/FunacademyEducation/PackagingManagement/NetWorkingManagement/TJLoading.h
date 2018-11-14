//
//  TJLoading.h
//  2222222
//
//  Created by ZQY on 16/8/29.
//  Copyright © 2016年 ZQY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJLoading : UIView

@property(nonatomic,weak)TJLoading * loading;
@property(nonatomic,weak)UIImageView * loadingImage;
+(TJLoading *)LoadingAppear;
-(void)loadingDisappear;
@end
