//
//  ShareMessageTableViewCell.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol ShareMessageTableViewCellDelegate <NSObject>

-(void)imageButtonClick:(NSInteger)buttomTag withIndexPath:(NSIndexPath *)indexPath;

-(void)bottomViewButtonClick:(NSInteger)buttomTag withIndexPath:(NSIndexPath *)indexPath;

@end
@interface ShareMessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headerImageButton;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBackViewTopValue;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commetnsButton;
@property (weak, nonatomic) IBOutlet UIButton *giveLikeButton;

@property(nonatomic,assign)id<ShareMessageTableViewCellDelegate> delegate;



/**
 <#Description#>

 @param model <#model description#>
 @param source 来源，1是首页，2是详情页
 */
-(void)setLayoutData:(DBShareMessage *)model withIndePath:(NSIndexPath *)indexPath withViewSource:(NSInteger)source;

@end

NS_ASSUME_NONNULL_END
