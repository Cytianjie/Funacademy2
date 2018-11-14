//
//  NetworkRequestManager.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/13.
//  Copyright © 2018 清. All rights reserved.
//

#import "NetworkRequestManager.h"

@interface NetworkRequestManager ()
@property (nonatomic,copy) ResponseSuccess success;
@property (nonatomic,copy) ResponseFailure failure;
@end

@implementation NetworkRequestManager

+(instancetype)manager{
    NetworkRequestManager * manager = [[NetworkRequestManager alloc]init];
    return manager;
}
+(AFHTTPSessionManager *)sessionManager{
    
    static AFHTTPSessionManager * sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer.timeoutInterval = 10;
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    });
    
    return sessionManager;;
    
}
-(void)POST_URL:(NSString *)url Params:(NSDictionary *)params withLoading:(BOOL)isLoading Success:(ResponseSuccess)success Failure:(ResponseFailure)failure{
    TJLoading * laoding;
    if (isLoading) {
        laoding = [TJLoading LoadingAppear];
    }
    AFHTTPSessionManager * session = [NetworkRequestManager sessionManager];
    [session POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject,laoding);
        [laoding loadingDisappear];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
        [laoding loadingDisappear];
        [LoadDataSuggest showFailWith:NSLocalizedString(@"netWorkError", nil)];
    }];
}
-(void)GET_URL:(NSString *)url withLoading:(BOOL)isLoading Success:(ResponseSuccess)success Failure:(ResponseFailure)failure{
    TJLoading * laoding;
    if (isLoading) {
        laoding = [TJLoading LoadingAppear];
    }
    AFHTTPSessionManager * session = [NetworkRequestManager sessionManager];
    [session GET:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject,laoding);
        [laoding loadingDisappear];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
        [laoding loadingDisappear];
        [LoadDataSuggest showFailWith:NSLocalizedString(@"netWorkError", nil)];
    }];
}
@end
