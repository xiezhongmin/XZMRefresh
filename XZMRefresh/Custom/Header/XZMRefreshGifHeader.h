//
//  XZMRefreshGifHeader.h
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 16/1/23.
//  Copyright © 2016年 com.xiaomage.new. All rights reserved.
//

#import "XZMRefreshHeader.h"
#import "XZMRefreshNormalHeader.h"
@interface XZMRefreshGifHeader : XZMRefreshNormalHeader
- (void)setImages:(NSArray *)images forState:(XZMRefreshState)state;
@end
