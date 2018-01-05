//
//  SSCDLTViewController.m
//  168彩
//
//  Created by tasama on 18/1/5.
//  Copyright © 2018年 tasama. All rights reserved.
//

#import "SSCDLTViewController.h"
#import "SSCModel.h"
#import <TACategorys/UIView+Layout.h>
#import <TACategorys/UIColor+category.h>

@interface SSCDLTViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation SSCDLTViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.view addSubview:self.mainTableView];
    [self loadData];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.mainTableView.frame = CGRectMake(0, 0, self.view.mWidth, self.view.mHeight);
}

- (void)loadData {
    
    [SSCModel getModelsWithType:@"DLT" andLimit:20 withSuccess:^(NSUInteger ret, id response) {
        
        self.dataSource = response;
        [self.mainTableView reloadData];
    } andFailure:^(NSError *error) {
        
    }];
}

#pragma mark - 代理方法，数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    
    return cell;
}


#pragma mark - Getter & Setter 

- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableView.tableFooterView = [[UIView alloc] init];
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
    }
    return _mainTableView;
}

@end
