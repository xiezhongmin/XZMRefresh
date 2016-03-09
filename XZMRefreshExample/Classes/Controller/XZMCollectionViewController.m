//
//  XZMCollectionViewController.m
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/17.
//

#import "XZMCollectionViewController.h"
#import "XZMCollectionViewCell.h"
#import "XZMLayout.h"
#import "XZMRefresh.h"

#define CellOffsetWidth 20
#define CellOffsetHeight 50
#define ItemWidth ([UIScreen mainScreen].bounds.size.width - 2 *CellOffsetWidth)
#define ItemHeight ([UIScreen mainScreen].bounds.size.height - 2 *CellOffsetHeight)

@interface XZMCollectionViewController ()
@property (nonatomic, assign)NSUInteger examples; /**< 存放假数据 */
@end

@implementation XZMCollectionViewController

NSString *const XZMCellIdentifier = @"cellIdentifier";
- (instancetype)init
{
    // 创建布局
    XZMLayout *layout = [[XZMLayout alloc] init];
    layout.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.初始化collectionView
    [self setupCollectionView];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    // 2.执行实例
    [self performSelector:NSSelectorFromString(self.methodStr) withObject:nil];
}

/**
 *  初始化collectionView
 */
- (void)setupCollectionView
{
    self.examples = 1;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceHorizontal = YES;
    // 注册
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XZMCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:XZMCellIdentifier];
}

#pragma mark - 示例代码
#pragma mark UICollectionView + 默认刷新
- (void)example01
{
    [self.collectionView xzm_addNormalHeaderWithTarget:self action:@selector(loadNewDataWithHeader:)];
    [self.collectionView xzm_addNormalFooterWithTarget:self action:@selector(loadMoreDataWithFooter:)];
    // 自动刷新(一进入程序就下拉刷新)
    [self.collectionView.xzm_header beginRefreshing];
}

#pragma mark UICollectionView + 隐藏时间
- (void)example02
{
    [self.collectionView xzm_addNormalHeaderWithTarget:self action:@selector(loadNewDataWithHeader:)];
    [self.collectionView xzm_addNormalFooterWithTarget:self action:@selector(loadMoreDataWithFooter:)];
    // 隐藏时间
    self.collectionView.xzm_header.updatedTimeHidden = YES;
    // 自动刷新(一进入程序就下拉刷新)
    [self.collectionView.xzm_header beginRefreshing];
}

#pragma mark UICollectionView + 动图刷新
- (void)example03
{
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
}

#pragma mark UICollectionView + 动图刷新 + 隐藏文字
- (void)example04
{
    [self.collectionView xzm_addGifHeaderWithTarget:self action:@selector(loadNewDataWithHeader:)];
    [self.collectionView xzm_addGifFooterWithTarget:self action:@selector(loadMoreDataWithFooter:)];
    
    // 隐藏时间
    self.collectionView.xzm_gifHeader.updatedTimeHidden = YES;
    
    // 隐藏状态
    self.collectionView.xzm_gifHeader.stateHidden = YES;
    self.collectionView.xzm_gifFooter.stateHidden = YES;
    
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
}

#pragma mark UICollectionView + 自定义文字
- (void)example05
{
    [self.collectionView xzm_addNormalHeaderWithTarget:self action:@selector(loadNewDataWithHeader:)];
    [self.collectionView xzm_addNormalFooterWithTarget:self action:@selector(loadMoreDataWithFooter:)];
    
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
    
    // 自动刷新(一进入程序就下拉刷新)
    [self.collectionView.xzm_header beginRefreshing];
}

- (void)loadNewDataWithHeader:(XZMRefreshHeader *)header
{
    // 增加1条假数据
    self.examples += 1;
    
    // 模拟延迟加载数据，因此2秒后才调用）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        // 结束刷新
        [header endRefreshing];
    });
}

- (void)loadMoreDataWithFooter:(XZMRefreshFooter *)footer
{
    // 增加1条假数据
    self.examples += 1;
    
    // 模拟延迟加载数据，因此2秒后才调用）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        // 结束刷新
        [footer endRefreshing];
    });
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.examples;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XZMCellIdentifier forIndexPath:indexPath];
    
    cell.imageName = [NSString stringWithFormat:@"%zd", (indexPath.item + 1) % 21];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.item);
}
@end
