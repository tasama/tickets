//
//  SSCNetTool.m
//  168彩
//
//  Created by tasama on 2018/1/4.
//  Copyright © 2018年 tasama. All rights reserved.
//

#import "SSCNetTool.h"
#import <AFNetworking.h>
#import <YYCache.h>

static NSString * const HttpRequestCache = @"HttpRequestCache";

@implementation SSCNetTool
  
+ (instancetype)shareInstance {
    
    static SSCNetTool *shareInstancd = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareInstancd = [[SSCNetTool alloc] init];
    });
    return shareInstancd;
}
    
+ (AFHTTPSessionManager *)sessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // <=== 直接使用AF的JSON解析结果,去除自己解析代码
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 25.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    return manager;
}
    
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure {
    
    if ([URLString length] > 0) {
        URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            [[self sessionManager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               
                if (success) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        success(responseObject);
                    });
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    
                    failure(error);
                }
            }];
        });
    }
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters cachePolicy:(RequestCachePolicy)cachePolicy success:(successBlock)success failure:(failureBlock)failure {
    
    NSString *cacheKey = URLString;
    if (parameters) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [URLString stringByAppendingString:paramStr];
    }
    YYCache *cache = [[YYCache alloc] initWithName:HttpRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    id object = [cache objectForKey:cacheKey];
    switch (cachePolicy) {
        case ReloadIgnoringLocalCacheData: {//忽略本地缓存直接请求
            //不做处理，直接请求
            break;
        }
        case ReturnCacheDataAfterLoadError: {//先请求数据，请求出错后才返回缓存
            //不做处理，直接请求
            break;
        }
        case ReturnCacheDataElseLoad: {//有缓存就返回缓存，没有就请求
            if (object) {//有缓存
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(object);
                });
                return;
            }
            break;
        }
        case ReturnCacheDataDontLoad: {//有缓存就返回缓存,从不请求（用于没有网络）
            if (object) {//有缓存
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(object);
                });
                
            }
            return ;//退出从不请求
        }
        default: {
            break;
        }
    }
    if ([URLString length] > 0)
    {
        URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[self sessionManager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //HHLogDebug(@"response object : %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                if (success)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(responseObject);
                    });
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ((error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost) && cachePolicy == ReturnCacheDataAfterLoadError && object)
                        {
                            success(object);
                        }
                        
                        failure(error);
                    });
                }
            }];
        });
    }
    else
    {
        NSLog(@"url 长度为0");
    }
}
    
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure {
    
    if ([URLString length] > 0) {
        
        URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[self sessionManager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (success) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        success(responseObject);
                    });
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        failure(error);
                    });
                }
            }];
        });
    } else {
        
        NSLog(@"url 长度为0");
    }
}

@end
