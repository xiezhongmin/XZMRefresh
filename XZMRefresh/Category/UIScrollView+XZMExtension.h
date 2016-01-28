//
//  UIScrollView+UIScrollView_XZMExtension.h
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/21.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (XZMExtension)
@property (assign, nonatomic) CGFloat xzm_contentInsetTop;
@property (assign, nonatomic) CGFloat xzm_contentInsetBottom;
@property (assign, nonatomic) CGFloat xzm_contentInsetLeft;
@property (assign, nonatomic) CGFloat xzm_contentInsetRight;

@property (assign, nonatomic) CGFloat xzm_contentOffsetX;
@property (assign, nonatomic) CGFloat xzm_contentOffsetY;

@property (assign, nonatomic) CGFloat xzm_contentSizeWidth;
@property (assign, nonatomic) CGFloat xzm_contentSizeHeight;
@end
