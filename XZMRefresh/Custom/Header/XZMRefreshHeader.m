//
//  XZMRefreshHeader.m
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 16/1/23.
//  Copyright © 2016年 com.xiaomage.new. All rights reserved.
//

#import "XZMRefreshHeader.h"

@implementation XZMRefreshHeader
+ (instancetype)header
{
    return [[self alloc] init];
}

- (void)setStateHidden:(BOOL)stateHidden
{
     _stateHidden = stateHidden;
    
    self.statusLabel.hidden = stateHidden;
    [self setNeedsLayout];
}

- (void)setUpdatedTimeHidden:(BOOL)updatedTimeHidden
{
     _updatedTimeHidden = updatedTimeHidden;
    [self setNeedsLayout];
}

@end
