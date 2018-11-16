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
-(void)POST_URL_HttpHeader:(NSString *)header url:(NSString *)url params:(NSDictionary *)params withLoading:(BOOL)isLoading isFailureAlter:(BOOL)isAlter successBlock:(ResponseSuccess)success failureBlock:(ResponseFailure)failure{
    TJLoading * laoding;
    if (isLoading) {
        laoding = [TJLoading LoadingAppear];
    }
    AFHTTPSessionManager * session = [NetworkRequestManager sessionManager];
    NSLog(@"--url--->%@",[NSString stringWithFormat:@"%@%@",header,url]);
    NSLog(@"--params-->%@",params);
    [session POST:[NSString stringWithFormat:@"%@%@",header,url] parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BOOL isOk = NO;
        if (responseObject) {
            NSString * result = responseObject[@"result"];
            if ([result isEqualToString:@"ok"]) {
                isOk = YES;
            }
        }
        if (isOk == YES) {
            success(task,responseObject);
        }else{
            NSString * message = @"";
            if (responseObject[@"message"]) {
                message = responseObject[@"message"];
            }
            failure(task,message,nil);
            if (isAlter == YES) {
                [LoadDataSuggest showFailWith:message];
            }
        }
        
        [laoding loadingDisappear];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,@"",error);
        [laoding loadingDisappear];
        if (isAlter == YES) {
            [LoadDataSuggest showFailWith:NSLocalizedString(@"netWorkError", nil)];
        }
    }];
}

-(void)GET_URL_HttpHeader:(NSString *)header url:(NSString *)url withLoading:(BOOL)isLoading isFailureAlter:(BOOL)isAlter successBlock:(ResponseSuccess)success failureBlock:(ResponseFailure)failure{
    TJLoading * laoding;
    if (isLoading) {
        laoding = [TJLoading LoadingAppear];
    }
    AFHTTPSessionManager * session = [NetworkRequestManager sessionManager];
    [session GET:[NSString stringWithFormat:@"%@%@",header,url] parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BOOL isOk = NO;
        if (responseObject) {
            NSString * result = responseObject[@"result"];
            if ([result isEqualToString:@"ok"]) {
                isOk = YES;
            }
        }
        if (isOk == YES) {
            success(task,responseObject);
        }else{
            NSString * message = @"";
            if (responseObject[@"message"]) {
                message = responseObject[@"message"];
            }
            failure(task,message,nil);
            if (isAlter == YES) {
                [LoadDataSuggest showFailWith:message];
            }
        }
        
        [laoding loadingDisappear];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,@"",error);
        [laoding loadingDisappear];
        if (isAlter == YES) {
            [LoadDataSuggest showFailWith:NSLocalizedString(@"netWorkError", nil)];
        }
    }];
}
@end
