//
//  XZMCollectionViewCell.m
//  XZMRefreshExample
//
//  Created by 谢忠敏 on 15/12/17.
//

#import "XZMCollectionViewCell.h"

/**
 *  随机数据
 */
#define XZMRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

/**
 *  随机颜色
 */
#define XZMRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface XZMCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation XZMCollectionViewCell

- (void)awakeFromNib {
    self.photoView.layer.borderColor = XZMRandomColor.CGColor;
    self.photoView.layer.borderWidth = 15.0;
    self.photoView.layer.cornerRadius = 15.0;
    self.photoView.layer.masksToBounds = YES;

}
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.photoView.layer.borderColor = XZMRandomColor.CGColor;
    self.photoView.image = [UIImage imageNamed:imageName];
    self.titleLable.text = XZMRandomData;
}

@end
