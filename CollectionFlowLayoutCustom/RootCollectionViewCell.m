//
//  RootCollectionViewCell.m
//  瀑布流布局（组头和组尾）
//
//  Created by huangxin on 2020/9/2.
//  Copyright © 2020 huangxin. All rights reserved.
//

#import "RootCollectionViewCell.h"

@implementation RootCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self creatCell];
    }
    return self;
}

-(void)creatCell{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.titleLabel];
}

@end
