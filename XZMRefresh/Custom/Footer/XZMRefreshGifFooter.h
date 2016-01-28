//
//  XZMRefreshGifFooter.h
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 16/1/23.
//  Copyright © 2016年 com.xiaomage.new. All rights reserved.
//

#import "XZMRefreshFooter.h"
#import "XZMRefreshNormalFooter.h"
@interface XZMRefreshGifFooter : XZMRefreshNormalFooter

- (void)setImages:(NSArray *)images forState:(XZMRefreshState)state;
@end
