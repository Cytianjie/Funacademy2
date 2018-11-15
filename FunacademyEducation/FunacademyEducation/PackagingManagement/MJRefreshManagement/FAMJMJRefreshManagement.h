//
//  FAMJMJRefreshManagement.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/14.
//  Copyright © 2018 清. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

typedef  void (^FAheaderWithRefreshingBlock)(void);
typedef  void (^FAfooterWithRefreshingBlock)(void);


@interface FAMJMJRefreshManagement : NSObject

+(MJRefreshNormalHeader *)faHeaderWithRefreshingBlock:(FAheaderWithRefreshingBlock)faHeaderWithRefreshingBlock;

+(MJRefreshAutoNormalFooter *)faFooterWithRefreshingBlock:(FAfooterWithRefreshingBlock)faFooterWithRefreshingBlock;
@end

NS_ASSUME_NONNULL_END
