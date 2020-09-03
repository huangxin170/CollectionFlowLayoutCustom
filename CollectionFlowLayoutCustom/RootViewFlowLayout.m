//
//  RootViewFlowLayout.m
//  瀑布流布局（组头和组尾）
//
//  Created by huangxin on 2020/9/2.
//  Copyright © 2020 huangxin. All rights reserved.
//

#import "RootViewFlowLayout.h"

@interface RootViewFlowLayout ()

/// 布局信息
@property (nonatomic , strong) NSMutableArray * attriArray;

/// 高度信息
@property (nonatomic , strong) NSMutableDictionary * cellHeightDic;

@end

@implementation RootViewFlowLayout
//初始化
-(void)prepareLayout{
    
    //每列获取初始化高度
    for (int i = 0; i < self.colum; i ++) {
        [self.cellHeightDic setValue:@(self.edg.top) forKey:[NSString stringWithFormat:@"%d",i]];
    }
    
    //获取所有的区
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int sectionIndex = 0; sectionIndex < sectionCount; sectionIndex ++ ) {
        
        NSIndexPath * headerOrFooterIndexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
        UICollectionViewLayoutAttributes * headerAttri = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:headerOrFooterIndexPath];
        [self.attriArray addObject:headerAttri];
        
        //获取所有的cell
        NSInteger cellCount = [self.collectionView numberOfItemsInSection:sectionIndex];
        for (int cellIndex = 0; cellIndex < cellCount; cellIndex ++ ) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:cellIndex inSection:sectionIndex];
            UICollectionViewLayoutAttributes * itemAttri = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attriArray addObject:itemAttri];
        }
        
        UICollectionViewLayoutAttributes * footerAttri = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:headerOrFooterIndexPath];
        [self.attriArray addObject:footerAttri];
        
    }
    
}
//重写item布局
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    //获取最短的一列
    __block NSString * minColum = @"0";
    [self.cellHeightDic enumerateKeysAndObjectsUsingBlock:^(NSString * colum, NSNumber * value_y, BOOL * _Nonnull stop) {
        if ([value_y floatValue] < [self.cellHeightDic[minColum] floatValue]) {
            minColum = colum;
        }
    }];
    //获取item的宽度
    CGFloat w =  (self.collectionView.frame.size.width - self.edg.left - self.edg.right - (self.colum - 1) * self.interSpacing ) / self.colum;
    CGFloat h = self.edg.top;
    //获取item高度
    if ([self.delegate respondsToSelector:@selector(collectionViewWithItemHeightIndex:)]) {
        h = [self.delegate collectionViewWithItemHeightIndex:indexPath];
    }
    
    CGFloat x = self.edg.left + [minColum intValue]* (self.interSpacing + w);
    CGFloat y = [self.cellHeightDic[minColum] floatValue];
    //如果不是在顶部，则需要加上行间距
    if (y != self.edg.top) {
        y += self.lineSpacing;
    }
    
    self.cellHeightDic[minColum] = @(y + h);
    
    UICollectionViewLayoutAttributes * attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attri.frame = CGRectMake(x, y, w, h);
    return attri;
    
}

//重写头和尾布局
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    //获取最长的一列
    __block NSString * maxIndex = @"0";
    [self.cellHeightDic enumerateKeysAndObjectsUsingBlock:^(NSString * colum, NSNumber * value_y, BOOL * _Nonnull stop) {
        if ([value_y floatValue] > [self.cellHeightDic[maxIndex] floatValue]) {
            maxIndex = colum;
        }
    }];
    
    //头布局
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionViewLayoutAttributes * headerAttri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
        
        CGSize headerSize = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(collectionViewWithHeaderSizeIndex:)]) {
            headerSize = [self.delegate collectionViewWithHeaderSizeIndex:indexPath.row];
        }
        CGFloat x = self.edg.left;
        CGFloat y = [self.cellHeightDic[maxIndex] floatValue] + self.edg.bottom;
        if (headerSize.width == [UIScreen mainScreen].bounds.size.width) {
            headerSize.width = headerSize.width - self.edg.left - self.edg.right;
        }
        headerAttri.frame = CGRectMake(x, y, headerSize.width, headerSize.height);
        //更新所有列的高度
        for (int i = 0; i < self.colum; i ++) {
            [self.cellHeightDic setValue:@(y + headerSize.height) forKey:[NSString stringWithFormat:@"%d",i]];
        }
        return headerAttri;
    }
    //尾布局
    else{
        UICollectionViewLayoutAttributes * footerAttri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
        
        CGSize footerSize = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(collectionViewWithFooterSizeIndex:)]) {
            footerSize = [self.delegate collectionViewWithFooterSizeIndex:indexPath.row];
        }
        CGFloat x = self.edg.left;
        CGFloat y = [self.cellHeightDic[maxIndex] floatValue] + self.edg.bottom;
        footerAttri.frame = CGRectMake(x, y, footerSize.width - self.edg.left - self.edg.right, footerSize.height);
        //更新所有列的高度
        for (int i = 0; i < self.colum;  i ++) {
            [self.cellHeightDic setValue:@(y + footerSize.height) forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        return footerAttri;
    }
}

//赋值布局
-(NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attriArray;
}
//返回最大的高度（所有的布局加起来）
-(CGSize)collectionViewContentSize{
    __block NSString * maxIndex = @"0";
    [self.cellHeightDic enumerateKeysAndObjectsUsingBlock:^(NSString * colum, NSNumber * value_y, BOOL * _Nonnull stop) {
        if ([value_y floatValue] > [self.cellHeightDic[maxIndex] floatValue]) {
            maxIndex = colum;
        }
    }];
    return CGSizeMake(0, [self.cellHeightDic[maxIndex] floatValue]);
}
-(NSMutableArray *)attriArray{
    if (!_attriArray) {
        _attriArray = [[NSMutableArray alloc]init];
    }
    return _attriArray;
}
-(NSMutableDictionary *)cellHeightDic{
    if (!_cellHeightDic) {
        _cellHeightDic = [[NSMutableDictionary alloc]init];
    }
    return _cellHeightDic;
}


@end
