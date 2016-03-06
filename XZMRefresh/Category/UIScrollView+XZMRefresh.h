//
//  UIScrollView+XZMRefresh.h
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/17.
//

#import <UIKit/UIKit.h>

@class XZMRefreshNormalFooter,XZMRefreshNormalHeader,XZMRefreshGifFooter,
XZMRefreshGifHeader;
@interface UIScrollView (XZMRefresh)

/** 下拉刷新控件 */
@property (strong, nonatomic) XZMRefreshNormalHeader *xzm_header;
@property (strong, nonatomic) XZMRefreshGifHeader *xzm_gifHeader;
/** 上拉刷新控件 */
@property (strong, nonatomic) XZMRefreshNormalFooter *xzm_footer;
@property (strong, nonatomic) XZMRefreshGifFooter *xzm_gifFooter;
#pragma mark - 默认头部刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)xzm_addNormalHeaderWithCallback:(void (^)())callback;

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)xzm_addNormalHeaderWithTarget:(id)target action:(SEL)action;

#pragma mark - GIF头部刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)xzm_addGifHeaderWithCallback:(void (^)())callback;

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)xzm_addGifHeaderWithTarget:(id)target action:(SEL)action;

// ---------------------------------------------------------------------

#pragma mark - 默认上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)xzm_addNormalFooterWithCallback:(void (^)())callback;

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)xzm_addNormalFooterWithTarget:(id)target action:(SEL)action;

#pragma mark - GIF上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)xzm_addGifFooterWithCallback:(void (^)())callback;

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)xzm_addGifFooterWithTarget:(id)target action:(SEL)action;


/**
 *  设置尾部控件的文字
 */
@property (copy, nonatomic) NSString *footerPullToRefreshText; // 默认:@"上拉可以加载更多数据"
@property (copy, nonatomic) NSString *footerReleaseToRefreshText; // 默认:@"松开立即加载更多数据"
@property (copy, nonatomic) NSString *footerRefreshingText; // 默认:@"正在刷新数据..."

/**
 *  设置头部控件的文字
 */
@property (copy, nonatomic) NSString *headerPullToRefreshText; // 默认:@"下拉可以刷新"
@property (copy, nonatomic) NSString *headerReleaseToRefreshText; // 默认:@"松开立即刷新"
@property (copy, nonatomic) NSString *headerRefreshingText; // 默认:@"正在刷新数据..."
@end
