//
//  KFMRefreshView.h
//  CustomRefOC
//
//  Created by mac on 2017/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFMRefresh.h"
@interface KFMRefreshView : UIView

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tipIcon;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, assign) KFMRefreshState state;

+(instancetype)refreshView;
@end
