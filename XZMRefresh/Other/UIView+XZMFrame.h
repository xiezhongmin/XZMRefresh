//
//  UIView+XZMFrame.h
//  彩票-练习2-0627
//
//  Created by 谢忠敏 on 15/6/28.
//  Copyright (c) 2015年 谢忠敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XZMFrame)
/** 在分类中@property只会生产方法的声明 */
@property (nonatomic, assign)CGFloat xzm_height;
@property (nonatomic, assign)CGFloat xzm_width;
@property (nonatomic, assign)CGFloat xzm_x;
@property (nonatomic, assign)CGFloat xzm_y;
@property (nonatomic, assign)CGFloat xzm_centerX;
@property (nonatomic, assign)CGFloat xzm_centerY;
@end
