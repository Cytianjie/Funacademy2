//
//  DayShareDetailsViewController.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/19.
//  Copyright © 2018 清. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DayShareDetailsViewController : RootViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *inpuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewHeightValue;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomValue;

@property (nonatomic,strong)DBShareMessage * dbModel;

@end

NS_ASSUME_NONNULL_END
