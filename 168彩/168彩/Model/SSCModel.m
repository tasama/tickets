//
//  SSCModel.m
//  168彩
//
//  Created by tasama on 2018/1/4.
//  Copyright © 2018年 tasama. All rights reserved.
//

#import "SSCModel.h"
#import "SSCAPI.h"
#import <YYModel.h>

@implementation SSCModel

+ (void)getModelsWithType:(NSString *)type andLimit:(NSUInteger)limit withSuccess:(Success)success andFailure:(Failed)failure {
    
    [SSCAPI loadLotteryWithType:type andLimit:limit withSuccess:^(NSUInteger ret, id response) {
       
        NSArray *array = [NSArray yy_modelArrayWithClass:[SSCModel class] json:response];
        if (success) {
            
            success(array.count, array);
        }
    } andFailure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
        }
    }];
}
    
@end
