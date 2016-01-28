//
//  UIView+XZMFrame.m
//  彩票-练习2-0627
//
//  Created by 谢忠敏 on 15/6/28.
//  Copyright (c) 2015年 谢忠敏. All rights reserved.
//

#import "UIView+XZMFrame.h"

@implementation UIView (XZMFrame)

/**实现分类的方法 */
- (void)setXzm_x:(CGFloat)xzm_x
{
    CGRect rect = self.frame;
    rect.origin.x = xzm_x;
    self.frame = rect;
}
- (CGFloat)xzm_x
{
    return self.frame.origin.x;
}


- (void)setXzm_y:(CGFloat)xzm_y
{
    CGRect rect = self.frame;
    rect.origin.y = xzm_y;
    self.frame = rect;
}
- (CGFloat)xzm_y
{
    return self.frame.origin.y;
}


- (void)setXzm_height:(CGFloat)xzm_height
{
    CGRect rect = self.frame;
    rect.size.height = xzm_height;
    self.frame = rect;
}
- (CGFloat)xzm_height
{
    return self.frame.size.height;
}


- (void)setXzm_width:(CGFloat)xzm_width
{
    CGRect rect = self.frame;
    rect.size.width = xzm_width;
    self.frame = rect;
}
- (CGFloat)xzm_width
{
    return self.frame.size.width;
}

- (CGFloat)xzm_centerX
{
    return self.center.x;
}

- (void)setXzm_centerX:(CGFloat)xzm_centerX{
    CGPoint center = self.center;
    center.x = xzm_centerX;
    self.center = center;
}

- (CGFloat)xzm_centerY
{
    return self.center.y;
}

- (void)setXzm_centerY:(CGFloat)xzm_centerY
{
    CGPoint center = self.center;
    center.y = xzm_centerY;
    self.center = center;
}

@end
