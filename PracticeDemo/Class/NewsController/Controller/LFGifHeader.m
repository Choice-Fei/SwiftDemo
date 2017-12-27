//
//  LFGifHeader.m
//  PracticeDemo
//
//  Created by admin on 2017/12/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LFGifHeader.h"

@implementation LFGifHeader
- (instancetype)init {
    self = [super init];
    if (self) {
        self.lastUpdatedTimeLabel.hidden = YES;
        [self setImages:@[[UIImage imageNamed:@"reflesh1"], [UIImage imageNamed:@"reflesh2"], [UIImage imageNamed:@"reflesh3"]]  forState:MJRefreshStateRefreshing];
        [self setImages:@[[UIImage imageNamed:@"reflesh1"], [UIImage imageNamed:@"reflesh2"], [UIImage imageNamed:@"reflesh3"]]  forState:MJRefreshStatePulling];
        [self setImages:@[[UIImage imageNamed:@"reflesh1"], [UIImage imageNamed:@"reflesh2"], [UIImage imageNamed:@"reflesh3"]]  forState:MJRefreshStateIdle];
        [self setTitle:@"下拉切换另一个主播" forState:MJRefreshStatePulling];
        [self setTitle:@"下拉切换另一个主播" forState:MJRefreshStateIdle];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
