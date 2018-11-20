//
//  PhotoBrowsingViewController.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/19.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoBrowsingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property(nonatomic,strong)NSMutableArray * imageUrlArray;
@property(nonatomic,assign)NSInteger selectIndex;
@end

NS_ASSUME_NONNULL_END
