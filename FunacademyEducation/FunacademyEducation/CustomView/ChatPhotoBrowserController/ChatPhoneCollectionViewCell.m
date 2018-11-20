//
//  ChatPhoneCollectionViewCell.m
//  BabyLove
//
//  Created by tianhongkeji on 15/6/3.
//  Copyright (c) 2015年 赵. All rights reserved.
//

#import "ChatPhoneCollectionViewCell.h"

@implementation ChatPhoneCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.scrocview                                    = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.scrocview.backgroundColor = [UIColor clearColor];
        self.scrocview.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        self.scrocview.maximumZoomScale=2.0;
        self.scrocview.minimumZoomScale=1;
        self.scrocview.delaysContentTouches=YES;        
        self.imageView = [[UIImageView alloc]init];
        [self.scrocview addSubview:self.imageView];
        [self.contentView addSubview:self.scrocview];
        self.userInteractionEnabled = YES;
    }
    return self;
}
@end
