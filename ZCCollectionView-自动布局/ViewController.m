//
//  ViewController.m
//  ZCCollectionView-自动布局
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ViewController.h"
#import "ZCLineLayout.h"
#import "ZCCircleLayout.h"
#import "ZCPhotoCell.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *imageNames;
@property (nonatomic,weak) UICollectionView *collectionView;
@end
static NSString *const photoID = @"photo";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatLayout];

}
- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (NSInteger i=0; i<20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%zd",i+1]];
        }
    }
    return _imageNames;
}
- (void)creatLayout
{
    ZCLineLayout *layout = [[ZCLineLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);

    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = 200;
    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    ;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:photoID];
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZCPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoID forIndexPath:indexPath];
    cell.imageName =self.imageNames[indexPath.item];
      return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageNames removeObjectAtIndex:indexPath.item];
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[ZCLineLayout class]]) {
        ZCCircleLayout *layout = [[ZCCircleLayout alloc]init];
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }else{
        ZCLineLayout *layout = [[ZCLineLayout alloc]init];
        layout.itemSize = CGSizeMake(100, 100);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }
}

@end
