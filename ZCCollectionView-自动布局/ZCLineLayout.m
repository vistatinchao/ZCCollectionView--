//
//  ZCLineLayout.m
//  ZCCollectionView-自动布局
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCLineLayout.h"

@implementation ZCLineLayout

- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat inset = (self.collectionView.frame.size.width-self.itemSize.width)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"rect:%@",NSStringFromCGRect(rect));
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width*0.5;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat dalta = ABS(attrs.center.x-centerX);
        CGFloat scale = 1 - dalta/self.collectionView.frame.size.width;
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width*0.5;
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta)>ABS(attrs.center.x-centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

@end
