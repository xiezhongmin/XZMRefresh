# iOS使用XZMRefresh实现UITableView或UICollectionView横向刷新
The easiest way to use pull-to-The transverse refresh(非常易用的横向刷新框架与MJRefresh用法一致)
#框架开发的缘由:
## 现今已有越来越多的APP需要横向刷新的需求，然而MJRefresh已不能满足该需求，该框架已经使用的非常的广泛，并且框架本身封装比较完美，方法的使用大家也非常的熟悉，所以XZMRefresh本着模仿MJRefresh框架做了横向刷新的Refresh，这样大家不必再去适应繁琐的新框架集成。

##APP实例
###1.好赞APP
![(好赞刷新)](http://7xkt3g.com1.z0.glb.clouddn.com/refreshrefresh_haozang2.gif)

###2.淘宝APP
![(淘宝刷新)](http://7xkt3g.com1.z0.glb.clouddn.com/refreshrefresh_taobao.gif)


## Content
* 使用方法参考
    * [默认](#默认)
    * [隐藏时间](#隐藏时间)
    * [动画图片](#动画图片)
    * [动画图片 + 隐藏状态和时间](#动画图片 + 隐藏状态和时间)
    * [自定义文字](#自定义文字)
    * [特性说明](#特性说明)

## <a id="如何使用XZMRefresh"></a>如何使用XZMRefresh
* cocoapods导入：`pod 'XZMRefresh'`
* 手动导入：
* 将`XZMRefresh`文件夹中的所有文件拽入项目中
* 导入主头文件：`#import "XZMRefresh.h"`

- 下拉刷新控件的种类
- 默认（Normal）：`XZMRefreshNormalHeader`
- 动图（Gif）：`XZMRefreshGifHeader`
- 上拉刷新控件的种类
- 默认（Normal）：`XZMRefreshNormalFooter`
- 动图（Gif）：`XZMRefreshGifFooter`


## <a id="默认"></a>默认
```objc
#pragma mark UICollectionView + 默认刷新
[self.collectionView xzm_addNormalHeaderWithTarget:self action:@selector(loadNewDataWithHeader:)];
[self.collectionView xzm_addNormalFooterWithTarget:self action:@selector(loadMoreDataWithFooter:)];
// 自动刷新(一进入程序就下拉刷新)
[self.collectionView.xzm_header beginRefreshing];
}
```
![(默认刷新)](http://7xkt3g.com1.z0.glb.clouddn.com/Refreshrefresh_moren.gif)

## <a id="隐藏时间"></a>隐藏时间
```objc
// 隐藏时间
self.collectionView.xzm_header.updatedTimeHidden = YES;
```
![(隐藏时间)](http://7xkt3g.com1.z0.glb.clouddn.com/Refreshrefresh_hide_date.gif)

## <a id="动画图片"></a>动画图片
```objc
[self.collectionView xzm_addGifHeaderWithTarget:self action:@selector(loadNewDataWithHeader:)];
[self.collectionView xzm_addGifFooterWithTarget:self action:@selector(loadMoreDataWithFooter:)];

// 设置普通状态的动画图片
NSMutableArray *idleImages = [NSMutableArray array];
for (NSUInteger i = 1; i<=60; i++) {
UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
[idleImages addObject:image];
}
[self.collectionView.xzm_gifHeader setImages:idleImages forState:XZMRefreshStateNormal];
[self.collectionView.xzm_gifFooter setImages:idleImages forState:XZMRefreshStateNormal];

// 设置正在刷新状态的动画图片
NSMutableArray *refreshingImages = [NSMutableArray array];
for (NSUInteger i = 1; i<=3; i++) {
UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
[refreshingImages addObject:image];
}
[self.collectionView.xzm_gifHeader setImages:refreshingImages forState:XZMRefreshStateRefreshing];
[self.collectionView.xzm_gifFooter setImages:refreshingImages forState:XZMRefreshStateRefreshing];

// 马上进入刷新状态
[self.collectionView.xzm_gifHeader beginRefreshing];
```
![(动画图片)](http://7xkt3g.com1.z0.glb.clouddn.com/Refreshrefresh_donghua.gif)

## <a id="动画图片 + 隐藏状态和时间"></a>动画图片 + 隐藏状态和时间
```objc
// 添加动画图片代码同上

// 隐藏时间
self.collectionView.xzm_gifHeader.updatedTimeHidden = YES;

// 隐藏状态
self.collectionView.xzm_gifHeader.stateHidden = YES;
self.collectionView.xzm_gifFooter.stateHidden = YES;
```
![(动画图片 + 隐藏状态和时间)](http://7xkt3g.com1.z0.glb.clouddn.com/Refreshrefresh_donghua_hide.gif)

## <a id="自定义文字"></a>自定义文字
```objc
// 设置header文字
[self.collectionView.xzm_header setTitle:@"滑动可以刷新" forState:XZMRefreshStateNormal];
[self.collectionView.xzm_header setTitle:@"释放立即刷新" forState:XZMRefreshStatePulling];
[self.collectionView.xzm_header setTitle:@"正在刷新中 ..." forState:XZMRefreshStateRefreshing];
// 设置字体
self.collectionView.xzm_header.font = [UIFont systemFontOfSize:15];
// 设置颜色
self.collectionView.xzm_header.textColor = [UIColor redColor];

// 设置footer文字
[self.collectionView.xzm_footer setTitle:@"滑动可以刷新" forState:XZMRefreshStateNormal];
[self.collectionView.xzm_footer setTitle:@"释放立即刷新" forState:XZMRefreshStatePulling];
[self.collectionView.xzm_footer setTitle:@"正在加载中数据 ..." forState:XZMRefreshStateRefreshing];
// 设置字体
self.collectionView.xzm_footer.font = [UIFont systemFontOfSize:17];
// 设置颜色
self.collectionView.xzm_footer.textColor = [UIColor blueColor];
```
![(自定义文字)](http://7xkt3g.com1.z0.glb.clouddn.com/Refreshrefresh_text.gif)

## <a id="特性说明"></a>特性说明
* 本框架纯ARC，兼容的系统>=iOS6.0
* 如果在使用过程中遇到BUG，希望你能与我联系(我的邮箱:364101515qq.com)
* 如果有好的建议以及框架上的不足，请联系我，非常感谢你！
* 如果喜欢你就Star一下吧，感谢你的支持！