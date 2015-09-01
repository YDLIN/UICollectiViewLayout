//
//  ViewController.m
//  FlowLayout
//
//  Created by Du on 15/8/29.
//  Copyright (c) 2015年 Du. All rights reserved.
//

#import "ViewController.h"
#import "DuPictureCell.h"
#import "DuLineLayout.h"
#import "DuStackLayout.h"
#import "DuFlowLayout.h"
#import "DuCircleLayout.h"

static NSString * const ID = @"picture";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
//存放图片名
@property (strong, nonatomic) NSMutableArray *pictures;
@property (weak, nonatomic)  UICollectionView *collect;

@end

@implementation ViewController
- (NSMutableArray *)pictures{
    if (!_pictures) {
        _pictures = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            [_pictures addObject:[NSString stringWithFormat:@"Expression_%d",i]];
        }
    }
    return _pictures;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建UICollectionView
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 600) collectionViewLayout:[[DuFlowLayout alloc] init]];
    //设置数据源，代理
    collect.dataSource = self;
    collect.delegate = self;
    //注册cell
    [collect registerNib:[UINib nibWithNibName:@"DuPictureCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collect];
    self.collect = collect;
    
    //创建segmented
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"Flow",@"Line",@"Stack",@"Circle"]];
    segment.center = CGPointMake(self.view.frame.size.width *0.5, 100);
    [segment addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    segment.tintColor = [UIColor grayColor];
    segment.selectedSegmentIndex = 0;
    [self.view addSubview:segment];
}
//监听UISegmentedControl，切换布局
- (void)valueChange:(UISegmentedControl *)segmentedControl{
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            [self.collect setCollectionViewLayout:[[DuFlowLayout alloc] init] animated:YES];
            break;
        case 1:
            [self.collect setCollectionViewLayout:[[DuLineLayout alloc] init] animated:YES];
            break;
        case 2:
            [self.collect setCollectionViewLayout:[[DuStackLayout alloc] init] animated:YES];
            break;
        case 3:
            [self.collect setCollectionViewLayout:[[DuCircleLayout alloc] init] animated:YES];
            break;
        default:break;
    }
}


#pragma  mark -- <UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DuPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.picture = self.pictures[indexPath.item];//这里是item,不是row
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //从模型中删除
    [self.pictures removeObjectAtIndex:indexPath.item];
    //刷新UI
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
@end
