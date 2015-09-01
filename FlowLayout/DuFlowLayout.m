//
//  DuFlowLayout.m
//  FlowLayout
//
//  Created by Du on 15/8/30.
//  Copyright (c) 2015年 Du. All rights reserved.
//

#import "DuFlowLayout.h"

@implementation DuFlowLayout
- (void)prepareLayout{
    self.itemSize = CGSizeMake(DuLayoutConst,DuLayoutConst);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
//    NSArray *attr = [super layoutAttributesForElementsInRect:rect];
//    for (UICollectionViewLayoutAttributes *attrs in attr) {
//        attrs.size = CGSizeMake(150, 150);
//    }
//    return attr;
//}
@end
