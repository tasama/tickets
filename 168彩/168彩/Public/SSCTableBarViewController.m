//
//  SSCTableBarViewController.m
//  168彩
//
//  Created by tasama on 18/1/5.
//  Copyright © 2018年 tasama. All rights reserved.
//

#import "SSCTableBarViewController.h"

@interface SSCTableBarViewController ()

@end

@implementation SSCTableBarViewController

- (instancetype)init {
    
    if (self = [super init]) {
        
        NSMutableArray *vcs = @[].mutableCopy;
        
        [self.viewControllerNames enumerateObjectsUsingBlock:^(NSString *controllerName, NSUInteger idx, BOOL * _Nonnull stop) {
           
            Class cl = NSClassFromString(controllerName);
            
            UIViewController *vc = [[cl alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav.title = self.controllerNames[idx];
            [vcs addObject:nav];
        }];
        [self setViewControllers:vcs];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setTintColor:[UIColor redColor]];
}

#pragma mark - Getter & Setter 

- (NSArray *)viewControllerNames {
    
    return @[@"SSCDLTViewController",@"SSCFC3DViewController", @"SSCPL3ViewController"];
}

- (NSArray *)controllerNames {
    
    return @[@"大乐透",@"福彩3D", @"排列3"];
}

@end
