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

+(MJRefreshAutoNormalFooter *)faFooterWithRefreshingBlock:(FAfooterWithRefreshingBlock)faFooterWithRefreshingBlock{
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        faFooterWithRefreshingBlock();
    }];
    
    
    // 设置文字
    //[footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    //[footer setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    //[footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
    // 设置字体
    //footer.stateLabel.font = [UIFont systemFontOfSize:17];
    // 设置颜色
    //footer.stateLabel.textColor = [UIColor blueColor];
    
    return footer;
}
@end
