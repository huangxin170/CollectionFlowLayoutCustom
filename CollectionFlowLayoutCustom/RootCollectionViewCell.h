//
//  RootCollectionViewCell.h
//  瀑布流布局（组头和组尾）
//
//  Created by huangxin on 2020/9/2.
//  Copyright © 2020 huangxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DataModel;
@interface RootCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UIImageView * headerImageView;

@property (nonatomic , strong) DataModel * model;


@end

NS_ASSUME_NONNULL_END
