//
//  FAMJMJRefreshManagement.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/14.
//  Copyright © 2018 清. All rights reserved.
//

#import "FAMJMJRefreshManagement.h"

@implementation FAMJMJRefreshManagement
+(MJRefreshNormalHeader *)faHeaderWithRefreshingBlock:(FAheaderWithRefreshingBlock)faHeaderWithRefreshingBlock{
   MJRefreshNormalHeader * header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
       faHeaderWithRefreshingBlock();
    }];
    // 设置文字
   // [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
   // [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    //[header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    //header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    //header.stateLabel.hidden = YES;
    
    // 设置字体
    //header.stateLabel.font = [UIFont systemFontOfSize:15];
    //header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    //header.stateLabel.textColor = [UIColor redColor];
    //header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    return header;
}
@end
