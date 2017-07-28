//
//  KFMRefresh.m
//  CustomRefOC
//
//  Created by mac on 2017/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#define KFMRefreshOffset 84

#import "KFMRefresh.h"
#import "KFMRefreshView.h"

@interface KFMRefresh()
@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, strong)KFMRefreshView *refreshView;

@end

@implementation KFMRefresh

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
-(KFMRefreshView *)refreshView {
    if (!_refreshView) {
        _refreshView = [KFMRefreshView refreshView];
    }
    return _refreshView;
}

-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        _scrollView = (UIScrollView *)newSuperview;
        
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }else {
        return;
    }
    

}

-(void)removeFromSuperview {
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    
    [super removeFromSuperview];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (_scrollView) {
        CGFloat height = -(_scrollView.contentInset.top + _scrollView.contentOffset.y);
        NSLog(@"%f",height);
        if (height < 0) {
            return;
        }
        
        self.frame = CGRectMake(0,-height,_scrollView.bounds.size.width,height);
        
        if (_scrollView.isDragging) {
            if (height > KFMRefreshOffset && self.refreshView.state == 0) {
                self.refreshView.state = 1;
            }else if (height <= KFMRefreshOffset && self.refreshView.state == 1) {
                self.refreshView.state = 0;
            }
        } else {
            if (self.refreshView.state == 1) {
                //给父视图发消息，开始执行刷新
                [self sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
}


-(void)setupUI {
    self.backgroundColor = self.superview.backgroundColor;
    [self addSubview:self.refreshView];
    
    self.refreshView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint * conCenterX = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0
                                                                    constant:0];
    NSLayoutConstraint * conBottom = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:0];
    //self.refreshView.bounds.size.width
    NSLayoutConstraint * conWidth = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:self.refreshView.bounds.size.width];
    //self.refreshView.bounds.size.height
    NSLayoutConstraint * conHeight = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:self.refreshView.bounds.size.height];
    
    [self addConstraints:@[conCenterX,conBottom,conWidth,conHeight]];
    
}
- (void)beginRefreshing {
    if (_scrollView) {
        if (self.refreshView.state == 2) {
            return;
        }
        self.refreshView.state = 2;
        
        // 停留显示
        UIEdgeInsets insets = _scrollView.contentInset;
        insets.top += KFMRefreshOffset;
        _scrollView.contentInset = insets;
    }
}
- (void)endRefreshing {
    if (self.refreshView.state == 2) {
        self.refreshView.state = 0;
    }
    
    if (_scrollView) {
        UIEdgeInsets insets = _scrollView.contentInset;
        insets.top -= KFMRefreshOffset;
        _scrollView.contentInset = insets;

    }
}
@end
