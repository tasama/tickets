//
//  SSCAPI.m
//  168彩
//
//  Created by tasama on 2018/1/4.
//  Copyright © 2018年 tasama. All rights reserved.
//

#import "SSCAPI.h"
#import "SSCNetTool.h"

@implementation SSCAPI

+ (void)loadLotteryWithType:(NSString *)type andLimit:(NSUInteger)limit withSuccess:(Success)success andFailure:(Failed)failure {
    
    NSString *limitStr = limit > 0 ? [NSString stringWithFormat:@"%zd", limit] : @"";
    
    if (limitStr.length > 0) {
        
        NSArray *array = @[type, limitStr];
        type = [array componentsJoinedByString:@"-"];
    }
    NSString *url = [NSString stringWithFormat:@"http://f.apiplus.net/%@.json", type];
    [SSCNetTool GET:url parameters:nil success:^(id  _Nullable responseObject) {
        
        if (success) {
            
            success(0, responseObject[@"data"]);
        }
    } failure:^(NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
        }
    }];
}
    
@end
