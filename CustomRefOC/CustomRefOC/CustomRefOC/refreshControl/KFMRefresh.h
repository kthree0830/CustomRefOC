//
//  KFMRefresh.h
//  CustomRefOC
//
//  Created by mac on 2017/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,KFMRefreshState)
{
    KFMRefreshStateNormal = 0,
    KFMRefreshStatePulling = 1,
    KFMRefreshStateWillRefresh = 2,
};
@interface KFMRefresh : UIControl

- (void)beginRefreshing;
- (void)endRefreshing;
@end
