//
//  SSCAPI.h
//  168彩
//
//  Created by tasama on 2018/1/4.
//  Copyright © 2018年 tasama. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(NSUInteger ret, id response);
typedef void(^Failed)(NSError *error);

@interface SSCAPI : NSObject

+ (void)loadLotteryWithType:(NSString *)type andLimit:(NSUInteger)limit withSuccess:(Success)success andFailure:(Failed)failure;

    
@end
