//
//  DuLineLayout.m
//  FlowLayout
//
//  Created by Du on 15/8/29.
//  Copyright (c) 2015年 Du. All rights reserved.
//

#import "DuLineLayout.h"
/**有效距离：当item的中心点x值小于DuDistance时才进行放大，其他情况都是缩小,该值不能乱取*/
static CGFloat const DuDistance = 350;
/**缩放系数，值越大，item越大*/
static CGFloat const DuScaleFactor = 0.7;
@implementation DuLineLayout
//做一些布局前的准备工作
- (void)prepareLayout{
    self.itemSize = CGSizeMake(DuLayoutConst, DuLayoutConst);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 130;
    //设置两边的内边距
//    self.sectionInset = UIEdgeInsetsMake(0, self.collectionView.frame.size.width *0.5, 0, self.collectionView.frame.size.width *0.5);
    self.sectionInset = UIEdgeInsetsMake(0, (self.collectionView.frame.size.width - DuLayoutConst) *0.5, 0, (self.collectionView.frame.size.width - DuLayoutConst) *0.5);

}

//只要显示的边界发生改变后就会重新布局
//会调用layoutAttributesForElementsInRect来获得每个item的布局属性
//也会调用prepareLayout来做布局前的设置
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//获得Rect范围内的所有的布局属性（每个item对应一个UICollectionViewLayoutAttributes）
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    //获得可见矩形框
    CGRect eyeable;
    eyeable.size = self.collectionView.frame.size;
    eyeable.origin = self.collectionView.contentOffset;
    
    NSArray *attr = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attrs in attr) {
        //判断两个矩形框是否相交（即是否在屏幕中显示）
        if (CGRectIntersectsRect(eyeable, attrs.frame)) {
            //技巧：每个item的中点的x值到UICollectionView的中点的距离越小，缩放系数越大
            //计算每个item的中心点的x值
            CGFloat itemCenterX = attrs.center.x;
            //计算缩放比例
            CGFloat collectionViewCenterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width *0.5;
            //缩放比例
            CGFloat scale = 1 + DuScaleFactor *(1 - ABS(itemCenterX - collectionViewCenterX) / DuDistance);
            attrs.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
    return attr;
}

/**
 *  决定了UICollectionView停止滚动时的位置
 *  @param proposedContentOffset 原本UICollectionView停止滚动那一刻的位置
 *  @param velocity              滚动速度
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //1、计算停止滚动时的可见范围()
    CGRect stopRect;
    stopRect.origin = proposedContentOffset;
    stopRect.size = self.collectionView.frame.size;
    
    //2、UICollectionView的中点x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width *0.5;
    
    //3、取出可见范围内所以的item,并比较他们的大小，取出最大的item
    NSArray *items = [self layoutAttributesForElementsInRect:stopRect];
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attributes in items) {
        //判断可见范围内item的中点x值与collectionView的中点x值的距离
        if (ABS(attributes.center.x - centerX) < ABS(adjustOffsetX)) {
            //正数：item在中心的右边；负数：item在中心的的左边
            adjustOffsetX = attributes.center.x - centerX;
        }
    }
    //4、滚动完毕停止的地方
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
//    return CGPointZero;
}
@end
