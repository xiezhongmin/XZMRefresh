


//
//  XZMRefreshGifHeader.m
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 16/1/23.
//  Copyright © 2016年 com.xiaomage.new. All rights reserved.
//

#import "XZMRefreshGifHeader.h"
#import "UIView+XZMFrame.h"
#import "XZMRefreshConst.h"

@interface XZMRefreshGifHeader()
@property (weak, nonatomic) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
@end

@implementation XZMRefreshGifHeader

#pragma mark - 懒加载
- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}


#pragma mark - 初始化
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.arrowImage removeFromSuperview];
    [self.activityView removeFromSuperview];
    
    self.gifView.frame = self.bounds;
    if (self.stateHidden && self.updatedTimeHidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
        
    } else {
        self.gifView.contentMode = UIViewContentModeRight;
        CGFloat arrowY = self.xzm_height * 0.5 + 135;
        self.gifView.center = CGPointMake(self.xzm_width * 0.5, arrowY);
    }
}

#pragma mark - 公共方法
#pragma mark 设置状态
- (void)setState:(XZMRefreshState)state
{
    if (self.state == state) return;
    
    // 旧状态
    XZMRefreshState oldState = self.state;
    
    NSArray *images = self.stateImages[@(state)];
    if (images.count != 0) {
        switch (state) {
            case XZMRefreshStateNormal: {
                if (oldState == XZMRefreshStateRefreshing) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(XZMRefreshSlowAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.pullingPercent = 0.0;
                    });
                } else {
                    self.pullingPercent = self.pullingPercent;
                }
                break;
            }
                
            case XZMRefreshStatePulling:
            case XZMRefreshStateRefreshing: {
                [self.gifView stopAnimating];
                if (images.count == 1) { // 单张图片
                    self.gifView.image = [images lastObject];
                } else { // 多张图片
                    self.gifView.animationImages = images;
                    self.gifView.animationDuration = images.count * 0.1;
                    [self.gifView startAnimating];
                }
                break;
            }
                
            default:
                break;
        }
    }
    
    // super里面有回调，应该在最后面调用
    [super setState:state];
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    NSArray *images = self.stateImages[@(self.state)];
    switch (self.state) {
        case XZMRefreshStateNormal: {
            [self.gifView stopAnimating];
            NSUInteger index =  images.count * self.pullingPercent;
            if (index >= images.count) index = images.count - 1;
            self.gifView.image = images[index];
            break;
        }
        default:
            break;
    }
}

- (void)setImages:(NSArray *)images forState:(XZMRefreshState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    
    // 根据图片设置控件的高度
    UIImage *image = [images firstObject];
    if (image.size.width > self.xzm_width) {
        self.xzm_width = image.size.width;
    }
}
@end

