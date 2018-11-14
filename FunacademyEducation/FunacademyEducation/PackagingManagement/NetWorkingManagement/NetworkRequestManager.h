//
//  NetworkRequestManager.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/13.
//  Copyright © 2018 清. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef  void (^ResponseSuccess)(NSURLSessionTask * task,id dataSource,id _Nullable loadingview);  //请求成功block
typedef void (^ResponseFailure)(NSURLSessionTask * task,NSError * error); //请求失败block

@interface NetworkRequestManager : NSObject

+(instancetype)manager;

/**
 http请求
 @param url url
 @param params 入参
 @param isLoading 是否显示加载动画
 @param success 成功block
 @param failure 失败block
 */
-(void)POST_URL:(NSString *)url Params:(NSDictionary *)params withLoading:(BOOL)isLoading Success:(ResponseSuccess)success Failure:(ResponseFailure)failure;
-(void)GET_URL:(NSString *)url withLoading:(BOOL)isLoading Success:(ResponseSuccess)success Failure:(ResponseFailure)failure;



@end

NS_ASSUME_NONNULL_END
