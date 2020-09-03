//
//  RootCollectionViewCell.m
//  瀑布流布局（组头和组尾）
//
//  Created by huangxin on 2020/9/2.
//  Copyright © 2020 huangxin. All rights reserved.
//

#import "RootCollectionViewCell.h"
#import "DataModel.h"

@implementation RootCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self creatCellAlloc];
        [self creatCellUI];
    }
    return self;
}

-(void)setModel:(DataModel *)model{
    self.headerImageView.backgroundColor = model.color;
    self.titleLabel.text = model.title;
}
-(void)creatCellAlloc{
    
    self.headerImageView  = [[UIImageView alloc]init];
    [self.contentView addSubview:self.headerImageView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerImageView addSubview:self.titleLabel];
    
}
-(void)creatCellUI{
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.headerImageView.superview);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.titleLabel.superview);
        make.height.mas_equalTo(20);
    }];
    
}

@end
