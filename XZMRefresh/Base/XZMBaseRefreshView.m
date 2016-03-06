//
//  XZMBaseRefreshView.m
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/17.
//

#import "XZMBaseRefreshView.h"
#import "XZMRefreshConst.h"
#import "XZMRefreshGifHeader.h"
#import "XZMRefreshGifFooter.h"
#import "UIView+XZMFrame.h"
@interface XZMBaseRefreshView()
{
    __weak UILabel *_statusLabel; /**< 状态文字 */
    __weak UIImageView *_arrowImage; /**< 箭头 */
    __weak UIActivityIndicatorView *_activityView; /**< 菊花 */
}
@end

@implementation XZMBaseRefreshView

#pragma mark - 控件初始化
/**
 *  状态标签
 */
- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        UILabel *statusLabel = [[UILabel alloc] init];
        statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        statusLabel.font = [UIFont boldSystemFontOfSize:13];
        statusLabel.textColor = XZMRefreshLabelTextColor;
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.numberOfLines = 0;
        statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel = statusLabel];
    }
    return _statusLabel;
}

/**
 *  箭头图片
 */
- (UIImageView *)arrowImage
{
    if (!_arrowImage && (self != [XZMRefreshGifHeader class] || self != [XZMRefreshGifFooter class])) {
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"XZMRefresh.bundle/arrow.png"]
];
        arrowImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_arrowImage = arrowImage];
    }
    return _arrowImage;
}

/**
 *  状态标签
 */
- (UIActivityIndicatorView *)activityView
{
    if (!_activityView && (self != [XZMRefreshGifHeader class] || self != [XZMRefreshGifFooter class])) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.bounds = self.arrowImage.bounds;
        activityView.autoresizingMask = self.arrowImage.autoresizingMask;
        [self addSubview:_activityView = activityView];
    }
    return _activityView;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    frame.size.width = XZMRefreshViewWidth;
    if (self = [super initWithFrame:frame]) {
        // 1.自己的属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
        // 2.设置默认状态
        self.state = XZMRefreshStateNormal;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.箭头
    CGFloat arrowY = self.xzm_height * 0.5 + 135;
    self.arrowImage.center = CGPointMake(self.xzm_width * 0.5, arrowY);
    // 2.指示器
    self.activityView.center = self.arrowImage.center;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:XZMRefreshContentOffset context:nil];
    
    if (newSuperview) { // 新的父控件
        [newSuperview addObserver:self forKeyPath:XZMRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        
        // 设置高度
        self.xzm_height = newSuperview.xzm_height;
        if (newSuperview.xzm_height == [UIScreen mainScreen].bounds.size.height) {
            self.xzm_height = newSuperview.xzm_height - XZMRefreshViewWidth;
        }
        
        // 设置位置
        self.xzm_x = 0;
        
        // 记录UIScrollView
        _scrollView = (UIScrollView *)newSuperview;
        // 记录UIScrollView最开始的contentInset
        _scrollViewOriginalInset = _scrollView.contentInset;
    }
}

#pragma mark - 显示到屏幕上
- (void)drawRect:(CGRect)rect
{
    if (self.state == XZMRefreshStateWillRefreshing) {
        self.state = XZMRefreshStateRefreshing;
    }
}

#pragma mark - 刷新相关
#pragma mark 是否正在刷新
- (BOOL)isRefreshing
{
    return XZMRefreshStateRefreshing == self.state;
}

#pragma mark 开始刷新
typedef void (*send_type)(void *, SEL, UIView *);
- (void)beginRefreshing
{
    if (self.state == XZMRefreshStateRefreshing) {
        // 回调
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            msgSend(msgTarget(self.refreshingTarget), self.refreshingAction, self);
        }
        
        if (self.beginRefreshingCallback) {
            self.beginRefreshingCallback();
        }
    } else {
        if (self.window) {
            self.state = XZMRefreshStateRefreshing;
        } else {
             _state = XZMRefreshStateWillRefreshing;
            [super setNeedsDisplay];
        }
    }
}

#pragma mark 结束刷新
- (void)endRefreshing
{
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.state = XZMRefreshStateNormal;
    });
}

#pragma mark - 公共方法
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    self.refreshingTarget = target;
    self.refreshingAction = action;
}

#pragma mark - 设置状态
- (void)setPullToRefreshText:(NSString *)pullToRefreshText
{
    _pullToRefreshText = [pullToRefreshText copy];
    [self settingLabelText];
}
- (void)setReleaseToRefreshText:(NSString *)releaseToRefreshText
{
    _releaseToRefreshText = [releaseToRefreshText copy];
    [self settingLabelText];
}
- (void)setRefreshingText:(NSString *)refreshingText
{
    _refreshingText = [refreshingText copy];
    [self settingLabelText];
}
- (void)settingLabelText
{
    switch (self.state) {
        case XZMRefreshStateNormal:
            // 设置文字
            self.statusLabel.text = _pullToRefreshText;
            break;
        case XZMRefreshStatePulling:
            // 设置文字
            self.statusLabel.text = _releaseToRefreshText;
            break;
        case XZMRefreshStateRefreshing:
            // 设置文字
            self.statusLabel.text = _refreshingText;
            break;
        default:
            break;
    }
}

/**
 * 设置state状态下的状态文字内容title
 */
- (void)setTitle:(NSString *)title forState:(XZMRefreshState)state
{
    if (title == nil) return;
    
    NSString *textTitle = [title appendLineFeedString];
    
    // 刷新当前状态的文字
    switch (state) {
        case XZMRefreshStateNormal:
            self.pullToRefreshText = textTitle;
            break;
            
        case XZMRefreshStatePulling:
            self.releaseToRefreshText = textTitle;
            break;
            
        case XZMRefreshStateRefreshing:
            self.refreshingText = textTitle;
            break;
            
        default:
            break;
    }
}

- (void)setState:(XZMRefreshState)state
{
    // 0.存储当前的contentInset
    if (self.state != XZMRefreshStateRefreshing) {
        _scrollViewOriginalInset = self.scrollView.contentInset;
    }
    
    // 1.一样的就直接返回(暂时不返回)
    if (self.state == state) return;
    
    // 2.根据状态执行不同的操作
    switch (state) {
        case XZMRefreshStateNormal: // 普通状态
        {
            if (self.state == XZMRefreshStateRefreshing) {
                [UIView animateWithDuration:XZMRefreshSlowAnimationDuration * 0.6 animations:^{
                    /** 菊花 */
                    self.activityView.alpha = 0.0;
                } completion:^(BOOL finished) {
                    // 停止转圈圈
                    [self.activityView stopAnimating];
                    
                    // 恢复alpha
                    self.activityView.alpha = 1.0;
                }];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(XZMRefreshSlowAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 再次设置回normal
                    _state = XZMRefreshStatePulling;
                    self.state = XZMRefreshStateNormal;
                });
                // 直接返回
                return;
            } else {
                // 显示箭头
                self.arrowImage.hidden = NO;
                
                // 停止转圈圈
                [self.activityView stopAnimating];
            }
            break;
        }
            
        case XZMRefreshStatePulling:
            break;
            
        case XZMRefreshStateRefreshing:
        {
            // 开始转圈圈
            [self.activityView startAnimating];
            // 隐藏箭头
            self.arrowImage.hidden = YES;
            
            // 回调
            if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
                msgSend(msgTarget(self.refreshingTarget), self.refreshingAction, self);
            }
            
            if (self.beginRefreshingCallback) {
                self.beginRefreshingCallback();
            }
            break;
        }
        default:
            break;
    }
    
    // 3.存储状态
    _state = state;
    
    // 4.设置文字
    [self settingLabelText];
}

- (void)setFont:(UIFont *)font
{
    self.statusLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor
{
    self.statusLabel.textColor = textColor;
}

@end


@implementation NSString (XZMRefresh)
#pragma mark - 文本每个字添加@“\n”
- (NSString *)appendLineFeedString
{
    NSMutableString *stringM = [NSMutableString string];
    for (int i = 0; i < self.length; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        [stringM appendString:str];
        [stringM appendString:@"\n"];
    }
    return stringM;
}

@end
