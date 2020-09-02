//
//  RootViewFlowLayout.h
//  瀑布流布局（组头和组尾）
//
//  Created by huangxin on 2020/9/2.
//  Copyright © 2020 huangxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RootViewFlowLayoutDelegate <NSObject>

/// 获取外部高度
/// @param index index description
-(CGFloat)collectionViewWithItemHeightIndex:(NSInteger)index;

/// 获取外部头高度
/// @param index index description
-(CGSize)collectionViewWithHeaderSizeIndex:(NSInteger)index;

/// 获取外部尾盖度
/// @param index index description
-(CGSize)collectionViewWithFooterSizeIndex:(NSInteger)index;

@end

@interface RootViewFlowLayout : UICollectionViewFlowLayout


/// 行间距
@property (nonatomic , assign) CGFloat lineSpacing;

/// 列间距
@property (nonatomic , assign) CGFloat interSpacing;

/// 列数
@property (nonatomic , assign) NSInteger colum;

/// 边缘布局
@property (nonatomic , assign) UIEdgeInsets edg;

@property (nonatomic , weak) id<RootViewFlowLayoutDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
