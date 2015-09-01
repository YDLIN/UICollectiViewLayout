//
//  DuCircleLayout.m
//  FlowLayout
//
//  Created by Du on 15/8/30.
//  Copyright (c) 2015年 Du. All rights reserved.
//

#import "DuCircleLayout.h"

@implementation DuCircleLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
//要是自定义继承于UICollectionViewLayout的布局，最好实现以下两个方法，不然会报错
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    attri.size = CGSizeMake(150, 150);
    //圆环的半径
    CGFloat radius = 220;
    //圆点
    CGPoint center = CGPointMake(self.collectionView.frame.size.width *0.5, self.collectionView.frame.size.height *0.5);
    //cell的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
    //item之间的夹角
    CGFloat angleDelta = 2 *M_PI / count;
    //item跟原始位置的夹角
    CGFloat angle  = indexPath.item *angleDelta;
    attri.center = CGPointMake(center.x + cosf(angle) *radius, center.y - sinf(angle) *radius);
    return attri;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *arrya = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //    为所有item添加
    for (int i = 0; i < count; i++) {
        [arrya addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    return arrya;
}
@end
