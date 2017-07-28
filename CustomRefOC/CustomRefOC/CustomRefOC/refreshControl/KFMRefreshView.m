//
//  KFMRefreshView.m
//  CustomRefOC
//
//  Created by mac on 2017/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "KFMRefreshView.h"

@interface KFMRefreshView()



@end
@implementation KFMRefreshView

+(instancetype)refreshView {
    UINib * nib = [UINib nibWithNibName:@"KFMRefreshView" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].firstObject;
}
-(void)setState:(KFMRefreshState)state {
    _state = state;
    switch (state) {
        case KFMRefreshStateNormal:
            ({_tipLabel.text = @"继续使劲啦";
                _tipIcon.hidden = NO;
                [_indicator stopAnimating];
                _indicator.hidden = YES;
                [UIView animateWithDuration:0.25 animations:^{
                    self.tipIcon.transform = CGAffineTransformIdentity;
                }];});
            break;
        case KFMRefreshStatePulling:
            ({_tipLabel.text = @"快松开我啦";
                [UIView animateWithDuration:0.25 animations:^{
                    self.tipIcon.transform = CGAffineTransformMakeRotation(M_PI-0.001);
                }];});
            break;
        case KFMRefreshStateWillRefresh:
            ({
                _tipLabel.text = @"正在刷新";
                _tipIcon.hidden = YES;
                _indicator.hidden = NO;
                [_indicator startAnimating];
            });
            break;
        default:
            break;
    }
}
@end
