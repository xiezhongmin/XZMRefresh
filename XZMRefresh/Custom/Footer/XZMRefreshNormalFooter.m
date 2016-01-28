
//
//  XZMRefreshFooder.m
//  XZMRefreshExample
//  Created by 谢忠敏 on 15/12/17.

#import "XZMRefreshNormalFooter.h"
#import "XZMBaseRefreshView.h"
#import "XZMRefreshConst.h"
#import "UIView+XZMFrame.h"
#import "UIScrollView+XZMExtension.h"


@interface XZMRefreshNormalFooter()
@property (assign, nonatomic) int lastRefreshCount;
@end

@implementation XZMRefreshNormalFooter

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pullToRefreshText = XZMRefreshFooterPullToRefresh;
        self.releaseToRefreshText = XZMRefreshFooterReleaseToRefresh;
        self.refreshingText = XZMRefreshFooterRefreshing;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.statusLabel.frame = self.bounds;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:XZMRefreshContentSize context:nil];
    
    if (newSuperview) { // 新的父控件
        // 监听
        [newSuperview addObserver:self forKeyPath:XZMRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        
        // 重新调整frame
        [self adjustFrameWithContentSize];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrameWithContentSize
{
    // 内容的高度
    CGFloat contentWidth = self.scrollView.xzm_contentSizeWidth;
    // 表格的高度
    CGFloat scrollWidth = self.scrollView.xzm_width - self.scrollViewOriginalInset.left - self.scrollViewOriginalInset.right;
    // 设置位置和尺寸
    self.xzm_x = MAX(contentWidth, scrollWidth);
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互，直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if ([XZMRefreshContentSize isEqualToString:keyPath]) {
        // 调整frame
        [self adjustFrameWithContentSize];
    } else if ([XZMRefreshContentOffset isEqualToString:keyPath]) {

        // 如果正在刷新，直接返回
        if (self.state == XZMRefreshStateRefreshing) return;
        
        // 调整状态
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
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetX = [self happenOffsetX];
    
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetX <= happenOffsetX) return;
    
    if (self.scrollView.isDragging) {
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetX = happenOffsetX + self.xzm_width;
        
        self.pullingPercent = (currentOffsetX - happenOffsetX) / self.xzm_width;
        
        if (self.state == XZMRefreshStateNormal && currentOffsetX > normal2pullingOffsetX) {
            // 转为即将刷新状态
            self.state = XZMRefreshStatePulling;
        } else if (self.state == XZMRefreshStatePulling && currentOffsetX <= normal2pullingOffsetX) {
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

#pragma mark - 状态相关
#pragma mark 设置状态
- (void)setState:(XZMRefreshState)state
{
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.保存旧状态
    XZMRefreshState oldState = self.state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态来设置属性
    switch (state)
    {
        case XZMRefreshStateNormal:
        {
            // 刷新完毕
            if (XZMRefreshStateRefreshing == oldState) {
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                [UIView animateWithDuration:XZMRefreshSlowAnimationDuration animations:^{
                    self.scrollView.xzm_contentInsetRight = self.scrollViewOriginalInset.right;
                }];
            } else {
                // 执行动画
                [UIView animateWithDuration:XZMRefreshFastAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                }];
            }
            
            CGFloat deltaW = [self widthForContentBreakView];
            int currentCount = [self totalDataCountInScrollView];
            // 刚刷新完毕
            if (XZMRefreshStateRefreshing == oldState && deltaW > 0 && currentCount != self.lastRefreshCount) {
                self.scrollView.xzm_contentOffsetX = self.scrollView.xzm_contentOffsetX;
            }
            break;
        }
            
        case XZMRefreshStatePulling:
        {
            [UIView animateWithDuration:XZMRefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
            }];
            break;
        }
            
        case XZMRefreshStateRefreshing:
        {
            // 记录刷新前的数量
            self.lastRefreshCount = [self totalDataCountInScrollView];
            
            [UIView animateWithDuration:XZMRefreshFastAnimationDuration animations:^{
                CGFloat right = self.xzm_width + self.scrollViewOriginalInset.right;
                CGFloat deltaW = [self widthForContentBreakView];
                if (deltaW < 0) { // 如果内容高度小于view的高度
                    right -= deltaW;
                }
                self.scrollView.xzm_contentInsetRight = right;
            }];
            break;
        }
            
        default:
            break;
    }
}

- (int)totalDataCountInScrollView
{
    int totalCount = 0;
    if ([self.scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.scrollView;
        
        for (int section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.scrollView;
        
        for (int section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)widthForContentBreakView
{
    CGFloat w = self.scrollView.frame.size.width - self.scrollViewOriginalInset.right - self.scrollViewOriginalInset.left;
    return self.scrollView.contentSize.width - w;
}

#pragma mark - 在父类中用得上
/**
 *  刚好看到上拉刷新控件时的contentOffset.x
 */
- (CGFloat)happenOffsetX
{
    CGFloat deltaW = [self widthForContentBreakView];
    if (deltaW > 0) {
        return deltaW - self.scrollViewOriginalInset.left;
    } else {
        return - self.scrollViewOriginalInset.left;
    }
}

@end
