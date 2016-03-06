//
//  XZMBaseRefreshView.h
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/17.


#import <UIKit/UIKit.h>

#define XZMTextDefaultTransform CGAffineTransformMakeRotation(M_PI_2)
#pragma mark - 控件的刷新状态
typedef enum {
    XZMRefreshStatePulling = 1, // 松开就可以进行刷新的状态
    XZMRefreshStateNormal = 2, // 普通状态
    XZMRefreshStateRefreshing = 3, // 正在刷新中的状态
    XZMRefreshStateWillRefreshing = 4, // 即将刷新状态
} XZMRefreshState;

#pragma mark - 控件的类型
typedef enum {
    XZMRefreshViewTypeHeader = -1, // 头部控件
    XZMRefreshViewTypeFooter = 1 // 尾部控件
} XZMRefreshViewType;

@interface XZMBaseRefreshView : UIView
#pragma mark - 父控件
@property (nonatomic, weak, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) UIEdgeInsets scrollViewOriginalInset;

#pragma mark - 内部的控件
@property (nonatomic, weak, readonly) UILabel *statusLabel;
@property (nonatomic, weak, readonly) UIImageView *arrowImage;
@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityView;

#pragma mark - 回调
/** 设置回调对象和回调方法 */
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
@property (weak, nonatomic) id refreshingTarget;
@property (assign, nonatomic) SEL refreshingAction;
// 开始进入刷新状态就会调用
@property (nonatomic, copy) void (^beginRefreshingCallback)();

#pragma mark - 刷新相关

/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;
/** 是否正在刷新 */
- (BOOL)isRefreshing;
/** 刷新状态 一般交给子类内部实现 */

#pragma mark - 交给子类去实现 和 调用
@property (assign, nonatomic) XZMRefreshState state;

#pragma mark - 交给子类重写
/** 下拉的百分比(交给子类重写) */
@property (assign, nonatomic) CGFloat pullingPercent;

/**
 *  文字
 */
@property (copy, nonatomic) NSString *pullToRefreshText;
@property (copy, nonatomic) NSString *releaseToRefreshText;
@property (copy, nonatomic) NSString *refreshingText;

#pragma mark - 文字处理
/** 文字颜色 */
@property (strong, nonatomic) UIColor *textColor;
/** 字体大小 */
@property (strong, nonatomic) UIFont *font;

/**
 * 设置state状态下的状态文字内容title
 */
- (void)setTitle:(NSString *)title forState:(XZMRefreshState)state;
@end

@interface NSString (XZMRefresh)
#pragma mark - 文本每个字添加@“\n”
- (NSString *)appendLineFeedString;
@end

