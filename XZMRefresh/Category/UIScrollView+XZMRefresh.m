
//  UIScrollView+XZMRefresh.m
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/17.
//

#import "UIScrollView+XZMRefresh.h"
#import "XZMRefreshNormalFooter.h"
#import "XZMRefreshNormalHeader.h"
#import "XZMRefreshGifHeader.h"
#import "XZMRefreshGifFooter.h"
#import <objc/runtime.h>

@implementation UIScrollView (XZMRefresh)

- (void)setXzm_header:(XZMRefreshNormalHeader *)xzm_header
{
    // 删除旧的，添加新的
    if (xzm_header != self.xzm_header) {
        [self.xzm_header removeFromSuperview];
        [self insertSubview:xzm_header atIndex:0];
        objc_setAssociatedObject(self, @selector(xzm_header),
                                 xzm_header, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (XZMRefreshNormalHeader *)xzm_header
{
    return objc_getAssociatedObject(self, _cmd);
}

- (XZMRefreshGifHeader *)xzm_gifHeader
{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setXzm_gifHeader:(XZMRefreshGifHeader *)xzm_gifHeader
{
    // 删除旧的，添加新的
    if (xzm_gifHeader != self.xzm_gifHeader) {
        [self.xzm_gifHeader removeFromSuperview];
        [self insertSubview:xzm_gifHeader atIndex:0];
        objc_setAssociatedObject(self, @selector(xzm_gifHeader),
                                 xzm_gifHeader, OBJC_ASSOCIATION_ASSIGN);
    }
}


- (void)setXzm_footer:(XZMRefreshNormalFooter *)xzm_footer
{
    // 删除旧的，添加新的
    if (xzm_footer != self.xzm_footer) {
        [self.xzm_footer removeFromSuperview];
        [self insertSubview:xzm_footer atIndex:0];
        objc_setAssociatedObject(self, @selector(xzm_footer),
                                 xzm_footer, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (XZMRefreshNormalFooter *)xzm_footer
{
    return objc_getAssociatedObject(self, _cmd);
}

- (XZMRefreshGifFooter *)xzm_gifFooter
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setXzm_gifFooter:(XZMRefreshGifFooter *)xzm_gifFooter
{
    // 删除旧的，添加新的
    if (xzm_gifFooter != self.xzm_gifFooter) {
        [self.xzm_gifFooter removeFromSuperview];
        [self insertSubview:xzm_gifFooter atIndex:0];
        objc_setAssociatedObject(self, @selector(xzm_gifFooter),
                                 xzm_gifFooter, OBJC_ASSOCIATION_ASSIGN);
    }
}

#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)xzm_addNormalHeaderWithCallback:(void (^)())callback
{
    // 1.创建新的header
    if (!self.xzm_header) {
        XZMRefreshNormalHeader *header = [XZMRefreshNormalHeader header];
        [self addSubview:header];
        self.xzm_header = header;
    }
    
    // 2.设置block回调
    self.xzm_header.beginRefreshingCallback = callback;
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)xzm_addNormalHeaderWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的header
    if (!self.xzm_header) {
        XZMRefreshNormalHeader *header = [XZMRefreshNormalHeader header];
        [self addSubview:header];
        self.xzm_header = header;
    }
    
    // 2.设置目标和回调方法
    self.xzm_header.refreshingTarget = target;
    self.xzm_header.refreshingAction = action;
}

- (void)xzm_addGifHeaderWithCallback:(void (^)())callback
{
    // 1.创建新的header
    if (!self.xzm_gifHeader) {
        XZMRefreshGifHeader *header = [XZMRefreshGifHeader header];
        [self addSubview:header];
        self.xzm_gifHeader = header;
    }
    
    // 2.设置block回调
    self.xzm_gifHeader.beginRefreshingCallback = callback;
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)xzm_addGifHeaderWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的header
    if (!self.xzm_gifHeader) {
        XZMRefreshGifHeader *header = [XZMRefreshGifHeader header];
        [self addSubview:header];
        self.xzm_gifHeader = header;
    }
    
    // 2.设置目标和回调方法
    self.xzm_gifHeader.refreshingTarget = target;
    self.xzm_gifHeader.refreshingAction = action;
}


#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)xzm_addNormalFooterWithCallback:(void (^)())callback
{
    // 1.创建新的footer
    if (!self.xzm_footer) {
        XZMRefreshNormalFooter *footer = [XZMRefreshNormalFooter footer];
        [self addSubview:footer];
        self.xzm_footer = footer;
    }
    
    // 2.设置block回调
    self.xzm_footer.beginRefreshingCallback = callback;
}

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)xzm_addNormalFooterWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的footer
    if (!self.xzm_footer) {
        XZMRefreshNormalFooter *footer = [XZMRefreshNormalFooter footer];
        [self addSubview:footer];
        self.xzm_footer = footer;
    }
    
    // 2.设置目标和回调方法
    self.xzm_footer.refreshingTarget = target;
    self.xzm_footer.refreshingAction = action;
}

- (void)xzm_addGifFooterWithCallback:(void (^)())callback
{
    // 1.创建新的footer
    if (!self.xzm_gifFooter) {
        XZMRefreshGifFooter *footer = [XZMRefreshGifFooter footer];
        [self addSubview:footer];
        self.xzm_gifFooter = footer;
    }
    
    // 2.设置block回调
    self.xzm_gifFooter.beginRefreshingCallback = callback;
}

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)xzm_addGifFooterWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的footer
    if (!self.xzm_gifFooter) {
        XZMRefreshGifFooter *footer = [XZMRefreshGifFooter footer];
        [self addSubview:footer];
        self.xzm_gifFooter = footer;
    }
    
    // 2.设置目标和回调方法
    self.xzm_gifFooter.refreshingTarget = target;
    self.xzm_gifFooter.refreshingAction = action;
}



/**
 *  文字
 */
- (void)setFooterPullToRefreshText:(NSString *)footerPullToRefreshText
{
    self.xzm_footer.pullToRefreshText = footerPullToRefreshText;
}

- (NSString *)footerPullToRefreshText
{
    return self.xzm_footer.pullToRefreshText;
}

- (void)setFooterReleaseToRefreshText:(NSString *)footerReleaseToRefreshText
{
    self.xzm_footer.releaseToRefreshText = footerReleaseToRefreshText;
}

- (NSString *)footerReleaseToRefreshText
{
    return self.xzm_footer.releaseToRefreshText;
}

- (void)setFooterRefreshingText:(NSString *)footerRefreshingText
{
    self.xzm_footer.refreshingText = footerRefreshingText;
}

- (NSString *)footerRefreshingText
{
    return self.xzm_footer.refreshingText;
}

- (void)setHeaderPullToRefreshText:(NSString *)headerPullToRefreshText
{
    self.xzm_footer.pullToRefreshText = headerPullToRefreshText;
}

- (NSString *)headerPullToRefreshText
{
    return self.xzm_footer.pullToRefreshText;
}

- (void)setHeaderReleaseToRefreshText:(NSString *)headerReleaseToRefreshText
{
    self.xzm_footer.releaseToRefreshText = headerReleaseToRefreshText;
}

- (NSString *)headerReleaseToRefreshText
{
    return self.xzm_footer.releaseToRefreshText;
}

- (void)setHeaderRefreshingText:(NSString *)headerRefreshingText
{
    self.xzm_footer.refreshingText = headerRefreshingText;
}

- (NSString *)headerRefreshingText
{
    return self.xzm_footer.refreshingText;
}

@end
