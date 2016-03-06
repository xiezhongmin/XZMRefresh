//
//  XZMRefreshHeader.m
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/17.
//

#import "XZMRefreshNormalHeader.h"
#import "XZMRefreshConst.h"
#import "UIScrollView+XZMExtension.h"
#import "UIView+XZMFrame.h"
@interface XZMRefreshNormalHeader()
// 最后的更新时间
@property (nonatomic, strong) NSDate *lastUpdateTime;
@property (nonatomic, weak) UILabel *lastUpdateTimeLabel;
@end

@implementation XZMRefreshNormalHeader

/**
 *  时间标签
 */
- (UILabel *)lastUpdateTimeLabel
{
    if (!_lastUpdateTimeLabel) {
        // 1.创建控件
        UILabel *lastUpdateTimeLabel = [[UILabel alloc] init];
        lastUpdateTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        lastUpdateTimeLabel.font = [UIFont boldSystemFontOfSize:12];
        lastUpdateTimeLabel.textColor = XZMRefreshLabelTextColor;
        lastUpdateTimeLabel.backgroundColor = [UIColor clearColor];
        lastUpdateTimeLabel.numberOfLines = 0;
        lastUpdateTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lastUpdateTimeLabel = lastUpdateTimeLabel];
        
        // 2.加载时间
        self.lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:XZMRefreshHeaderTimeKey];
    }
    return _lastUpdateTimeLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pullToRefreshText    = XZMRefreshHeaderPullToRefresh;
        self.releaseToRefreshText = XZMRefreshHeaderReleaseToRefresh;
        self.refreshingText       = XZMRefreshHeaderRefreshing;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lastUpdateTimeLabel.hidden = self.updatedTimeHidden;
    
    CGFloat statusX      = 0;
    CGFloat statusY      = 0;
    CGFloat statusHeight = self.xzm_height;
    CGFloat statusWidth  = self.xzm_width * 0.5;
    // 1.状态标签
    if (self.lastUpdateTimeLabel.hidden) statusWidth = self.xzm_width;
    
    self.statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);
   
    // 2.时间标签
    CGFloat lastUpdateX      = statusWidth;
    CGFloat lastUpdateY      = 0;
    CGFloat lastUpdateHeight = statusHeight;
    CGFloat lastUpdateWidth  = statusWidth;
    self.lastUpdateTimeLabel.frame = CGRectMake(lastUpdateX, lastUpdateY, lastUpdateWidth, lastUpdateHeight);

}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 设置自己的位置和尺寸
    self.xzm_x = - self.xzm_width;
}

#pragma mark - 状态相关
#pragma mark 设置最后的更新时间
- (void)setLastUpdateTime:(NSDate *)lastUpdateTime
{
    _lastUpdateTime = lastUpdateTime;
    
    // 1.归档
    [[NSUserDefaults standardUserDefaults] setObject:lastUpdateTime forKey:XZMRefreshHeaderTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 2.更新时间
    [self updateTimeLabel];
}

#pragma mark 更新时间字符串
- (void)updateTimeLabel
{
    if (!self.lastUpdateTime) return;
    
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:_lastUpdateTime];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *timeFormat = [formatter stringFromDate:self.lastUpdateTime];
    NSString *time = [timeFormat appendLineFeedString];
    // 3.显示日期
    self.lastUpdateTimeLabel.text = [NSString stringWithFormat:@"最\n后\n更\n新\n\n%@", time];
}


#pragma mark - 监听UIScrollView的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    // 如果正在刷新，直接返回
    if (self.state == XZMRefreshStateRefreshing) return;
    
    if ([XZMRefreshContentOffset isEqualToString:keyPath]) {
        [self adjustStateWithContentOffset];
    }
}

/**
 *  调整状态
 */
- (void)adjustStateWithContentOffset
{
    // 当前的contentOffset
    CGFloat currentOffsetX = self.scrollView.xzm_contentOffsetX;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetX = - self.scrollViewOriginalInset.left;
  
    // 如果是向上滚动到看不见头部控件，直接返回
    if (currentOffsetX >= happenOffsetX) return;
    
    if (self.scrollView.isDragging) { // scrollView正在拖动就会调用
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetX = happenOffsetX - self.xzm_width;
        
        self.pullingPercent = (happenOffsetX - currentOffsetX) / self.xzm_width;
        
        if (self.state == XZMRefreshStateNormal && currentOffsetX < normal2pullingOffsetX) {
            // 转为即将刷新状态
            self.state = XZMRefreshStatePulling;
        } else if (self.state == XZMRefreshStatePulling && currentOffsetX >= normal2pullingOffsetX) {
            // 转为普通状态
            self.state = XZMRefreshStateNormal;
        }
    } else if (self.state == XZMRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        self.state = XZMRefreshStateRefreshing;
        self.pullingPercent = 1.0;
    }else {
        self.pullingPercent = (happenOffsetX - currentOffsetX) / self.xzm_width;
    }
}

#pragma mark 设置状态
- (void)setState:(XZMRefreshState)state
{
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.保存旧状态
    XZMRefreshState oldState = self.state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态执行不同的操作
    switch (state) {
        case XZMRefreshStateNormal: // 下拉可以刷新
        {
            // 刷新完毕
            if (XZMRefreshStateRefreshing == oldState) {
                self.arrowImage.transform = CGAffineTransformIdentity;
                // 保存刷新时间
                self.lastUpdateTime = [NSDate date];
                
                [UIView animateWithDuration:XZMRefreshSlowAnimationDuration animations:^{
                    // 这句代码修复了，top值不断累加的bug
                    self.scrollView.xzm_contentInsetLeft -= self.xzm_width;
                }];
            } else {
                // 执行动画 箭头复位
                [UIView animateWithDuration:XZMRefreshFastAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformIdentity;
                }];
            }
            break;
        }
            
        case XZMRefreshStatePulling: // 松开可立即刷新
        {
            // 执行箭头动画
            [UIView animateWithDuration:XZMRefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            break;
        }
            
        case XZMRefreshStateRefreshing: // 正在刷新中
        {
            // 执行动画
            [UIView animateWithDuration:XZMRefreshFastAnimationDuration animations:^{
                // 1.增加滚动区域
                CGFloat left = self.scrollViewOriginalInset.left + self.xzm_width;
                self.scrollView.xzm_contentInsetLeft = left;
                
                // 2.设置滚动位置
                self.scrollView.xzm_contentOffsetX = -left;
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.lastUpdateTimeLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    self.lastUpdateTimeLabel.textColor = textColor;
}

@end
