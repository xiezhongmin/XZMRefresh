

#import <UIKit/UIKit.h>
#import <objc/message.h>

#ifdef DEBUG
#define XZMLog(...) NSLog(__VA_ARGS__)
#else
#define XZMLog(...)
#endif

#define XZMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define XZMRefreshLabelTextColor XZMColor(90, 90, 90)

extern const CGFloat XZMRefreshViewWidth;
extern const CGFloat XZMRefreshFastAnimationDuration;
extern const CGFloat XZMRefreshSlowAnimationDuration;

extern NSString *const XZMRefreshBundleName;
#define XZMRefreshSrcName(file) [XZMRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const XZMRefreshFooterPullToRefresh;
extern NSString *const XZMRefreshFooterReleaseToRefresh;
extern NSString *const XZMRefreshFooterRefreshing;

extern NSString *const XZMRefreshHeaderPullToRefresh;
extern NSString *const XZMRefreshHeaderReleaseToRefresh;
extern NSString *const XZMRefreshHeaderRefreshing;
extern NSString *const XZMRefreshHeaderTimeKey;

extern NSString *const XZMRefreshContentOffset;
extern NSString *const XZMRefreshContentSize;

// 字体大小
#define XZMRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 运行时objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define msgTarget(target) (__bridge void *)(target)

// 状态检查
#define XZMRefreshCheckState \
XZMRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];
