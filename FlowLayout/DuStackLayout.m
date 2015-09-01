//
//  DuStackLayout.m
//  FlowLayout
//
//  Created by Du on 15/8/29.
//  Copyright (c) 2015年 Du. All rights reserved.
//

#import "DuStackLayout.h"

@implementation DuStackLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//要是自定义继承于UICollectionViewLayout的布局，最好实现以下两个方法，不然会报错
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //旋转角度
    NSArray *angle = @[@(0),@(-0.16),@(-0.1),@(0.16),@(0.1)];
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    attri.size = CGSizeMake(DuLayoutConst, DuLayoutConst);
    attri.center = CGPointMake(self.collectionView.frame.size.width *0.5, self.collectionView.frame.size.height *0.5);
    if (indexPath.item >= 5) {
        attri.hidden = YES;
    }else{
        attri.transform = CGAffineTransformMakeRotation([angle[indexPath.item] floatValue]);
        //zIndex的值越大，就越在上面
        attri.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
    }
    return attri;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *arrya = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
//    为所有item添加
    for (int i = 0; i < count; i++) {
//        UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
//        attri.size = CGSizeMake(160, 160);
//        attri.center = CGPointMake(self.collectionView.frame.size.width *0.5, self.collectionView.frame.size.height *0.5);
//        if (i >= 5) {
//            attri.hidden = YES;
//        }else{
//            attri.transform = CGAffineTransformMakeRotation([angle[i] floatValue]);
//            //zIndex的值越大，就越在上面
//            attri.zIndex = count - i;
//        }
        
        [arrya addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    return arrya;
}
@end
