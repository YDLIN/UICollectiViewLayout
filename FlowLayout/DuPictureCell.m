//
//  DuPictureCell.m
//  FlowLayout
//
//  Created by Du on 15/8/29.
//  Copyright (c) 2015年 Du. All rights reserved.
//

#import "DuPictureCell.h"
@interface DuPictureCell()
@property (weak, nonatomic) IBOutlet UIImageView *pictureCell;

@end
@implementation DuPictureCell

- (void)awakeFromNib {
    self.pictureCell.layer.borderWidth = 5;
    self.pictureCell.layer.borderColor = [UIColor whiteColor].CGColor;
    self.pictureCell.layer.cornerRadius = 3;
    self.pictureCell.clipsToBounds = YES;
}

- (void)setPicture:(NSString *)picture{
    _picture = [picture copy];
    self.pictureCell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",picture]];
}

@end
