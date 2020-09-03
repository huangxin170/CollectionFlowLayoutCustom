//
//  HeaderCollectionReusableView.m
//  CollectionFlowLayoutCustom
//
//  Created by huangxin on 2020/9/3.
//  Copyright © 2020 huangxin. All rights reserved.
//

#import "HeaderCollectionReusableView.h"

@implementation HeaderCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self creatHeaderView];
    }
    return self;
}

-(void)creatHeaderView{
    self.titleLabel = [[UILabel alloc]init];
    [self addSubview:self.titleLabel];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.titleLabel.superview);
    }];
    
    
}

@end
