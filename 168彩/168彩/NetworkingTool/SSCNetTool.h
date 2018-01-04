//
//  SSCNetTool.h
//  168彩
//
//  Created by tasama on 2018/1/4.
//  Copyright © 2018年 tasama. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RequestCachePolicy){
    //    ReturnCacheDataThenLoad = 0,///< 有缓存就先返回缓存，同步请求数据，弃用
    ReloadIgnoringLocalCacheData, ///< 忽略缓存，重新请求
    ReturnCacheDataElseLoad,///< 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    ReturnCacheDataDontLoad,///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
    ReturnCacheDataAfterLoadError ///< 先请求数据，无网络时才返回缓存
};

typedef void(^SuccessBlock)(NSInteger ret,id _Nullable obj);
typedef void(^FailedBlock)(NSError *_Nonnull error);
typedef void(^successBlock)(id _Nullable responseObject);
typedef void(^failureBlock)(NSError *_Nonnull error);

@interface SSCNetTool : NSObject

@property (nonatomic, copy, nonnull) NSString *serverAddress;
    
+ (instancetype _Nullable)shareInstance;
    
+ (void)POST:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters
     success:(successBlock _Nullable)success
     failure:(failureBlock _Nonnull)failure;
+ (void)GET:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters
    success:(successBlock _Nullable)success
    failure:(failureBlock _Nonnull)failure;
+ (void)GET:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters cachePolicy:(RequestCachePolicy)cachePolicy
    success:(successBlock _Nullable)success
    failure:(failureBlock _Nonnull)failure;


@end
