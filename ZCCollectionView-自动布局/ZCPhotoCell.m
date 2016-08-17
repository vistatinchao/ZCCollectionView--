//
//  ZCPhotoCell.m
//  ZCCollectionView-自动布局
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCPhotoCell.h"
@interface ZCPhotoCell()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageview;

@end
@implementation ZCPhotoCell

- (void)awakeFromNib {
    // Initialization code
    self.photoImageview.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.photoImageview.layer.borderWidth = 10;

}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.photoImageview.image = [UIImage imageNamed:imageName];
}

- (void)setFrame:(CGRect)frame
{
    NSLog(@"%@",NSStringFromCGRect(frame));
    [super setFrame:frame];
}

@end
