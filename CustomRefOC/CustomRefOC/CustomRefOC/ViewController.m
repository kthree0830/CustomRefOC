//
//  ViewController.m
//  CustomRefOC
//
//  Created by mac on 2017/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "KFMRefresh.h"

//下拉刷新

NSString  * const cellId = @"cellId";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) KFMRefresh * refreshControl;

@end

@implementation ViewController
{
    UIView *_headerView;
    UIImageView *_headerImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView addSubview:self.refreshControl];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [_refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self loadData];
}


- (void)loadData {
    [_refreshControl beginRefreshing];
    NSLog(@"开始刷新");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"结束刷新");
        [_refreshControl endRefreshing];
    });
}

- (KFMRefresh *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[KFMRefresh alloc]init];
    }
    return _refreshControl;
}
#pragma mark -   

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
    
}

#pragma mark -   

@end
