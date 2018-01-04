//
//  ViewController.m
//  168彩
//
//  Created by tasama on 2018/1/4.
//  Copyright © 2018年 tasama. All rights reserved.
//

#import "ViewController.h"
#import "SSCAPI.h"
#import "SSCModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [SSCModel getModelsWithType:@"USPBALL90" andLimit:20 withSuccess:^(NSUInteger ret, id response) {
       
        
    } andFailure:^(NSError *error) {
        
    }];
}


@end
