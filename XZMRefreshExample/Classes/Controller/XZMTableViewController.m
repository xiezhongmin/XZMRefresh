//
//  XZMTableViewController.m
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/17.
//

#import "XZMTableViewController.h"
#import "XZMCollectionViewController.h"
@interface XZMTableViewController ()
@property (strong, nonatomic) NSArray *examples;
/**方法签名数组 */
@property (nonatomic, strong)NSArray *methodArr;
@end

static NSString *const XZMCellId = @"cell_id";
@implementation XZMTableViewController

- (NSArray *)examples
{
    if (_examples == nil) {
        _examples = @[@"默认", @"隐藏时间", @"动画图片", @"动画图片 + 隐藏状态和时间", @"自定义文字"];
    }
    return _examples;
}

- (NSArray *)methodArr
{
    if (_methodArr == nil) {
        _methodArr = @[@"example01",@"example02",@"example03",@"example04",@"example05"];
    }
    return _methodArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XZMCellId forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XZMCellId];
    }
    
    cell.textLabel.text = self.examples[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XZMCollectionViewController *collectionVc = [[XZMCollectionViewController alloc] init];
    collectionVc.title = self.examples[indexPath.item];
    collectionVc.methodStr = self.methodArr[indexPath.item];
    [self.navigationController pushViewController:collectionVc animated:YES];
}
@end
