
//  UIScrollView+UIScrollView_XZMExtension.m
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/21.
//

#import "UIScrollView+XZMExtension.h"

@implementation UIScrollView (UIScrollView_XZMExtension)
- (void)setXzm_contentInsetTop:(CGFloat)xzm_contentInsetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = xzm_contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)xzm_contentInsetTop
{
    return self.contentInset.top;
}

- (void)setXzm_contentInsetBottom:(CGFloat)xzm_contentInsetBottom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = xzm_contentInsetBottom;
    self.contentInset = inset;
}

- (CGFloat)xzm_contentInsetBottom
{
    return self.contentInset.bottom;
}

- (void)setXzm_contentInsetLeft:(CGFloat)xzm_contentInsetLeft
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = xzm_contentInsetLeft;
    self.contentInset = inset;
}

- (CGFloat)xzm_contentInsetLeft
{
    return self.contentInset.left;
}

- (void)setXzm_contentInsetRight:(CGFloat)xzm_contentInsetRight
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = xzm_contentInsetRight;
    self.contentInset = inset;
}

- (CGFloat)xzm_contentInsetRight
{
    return self.contentInset.right;
}

- (void)setXzm_contentOffsetX:(CGFloat)xzm_contentOffsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = xzm_contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)xzm_contentOffsetX
{
    return self.contentOffset.x;
}

- (void)setXzm_contentOffsetY:(CGFloat)xzm_contentOffsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = xzm_contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)xzm_contentOffsetY
{
    return self.contentOffset.y;
}

- (void)setXzm_contentSizeWidth:(CGFloat)xzm_contentSizeWidth
{
    CGSize size = self.contentSize;
    size.width = xzm_contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)xzm_contentSizeWidth
{
    return self.contentSize.width;
}

- (void)setXzm_contentSizeHeight:(CGFloat)xzm_contentSizeHeight
{
    CGSize size = self.contentSize;
    size.height = xzm_contentSizeHeight;
    self.contentSize = size;
}

- (CGFloat)xzm_contentSizeHeight
{
    return self.contentSize.height;
}
@end
