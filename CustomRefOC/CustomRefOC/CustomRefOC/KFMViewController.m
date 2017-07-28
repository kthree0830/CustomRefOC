//
//  KFMViewController.m
//  CustomRefOC
//
//  Created by mac on 2017/7/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "KFMViewController.h"
#import "KFMRef.h"
@interface KFMViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) KFMRef *ref;
@end

@implementation KFMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.backgroundColor = [UIColor yellowColor];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, _scrollView.bounds.size.height)];
    v.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:v];
     _scrollView.contentSize = CGSizeMake(1000, 0);
    [_scrollView addSubview:self.ref];
    [_ref addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self loadData];
}

- (KFMRef *)ref {
    if (!_ref) {
        _ref = [[KFMRef alloc]init];
    }
    return _ref;
}

- (void)loadData {
    [_ref beginRefreshing];
   NSLog(@"开始刷新");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"结束刷新");
        [_ref endRefreshing];
    });
}
@end
