//
//  ViewController.m
//  CollectionFlowLayoutCustom
//
//  Created by huangxin on 2020/9/2.
//  Copyright © 2020 huangxin. All rights reserved.
//

#import "ViewController.h"
#import "RootViewFlowLayout.h"
#import "RootCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,RootViewFlowLayoutDelegate>
@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RootViewFlowLayout * flow = [[RootViewFlowLayout alloc]init];
    flow.lineSpacing = 10;
    flow.interSpacing = 10;
    flow.edg = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.colum = 3;
    flow.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[RootCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    for (int i = 0; i < 100; i ++) {
        CGFloat height = arc4random()%100;
        [self.dataArray addObject:@(height > 20 ? height : 20)];
    }
    [self.collectionView reloadData];
    
}
#pragma mark delegate
-(CGFloat)collectionViewWithItemHeightIndex:(NSInteger)index{
    return [self.dataArray[index] floatValue];
}
-(CGSize)collectionViewWithHeaderSizeIndex:(NSInteger)index{
    return CGSizeMake(100, 50);
}
-(CGSize)collectionViewWithFooterSizeIndex:(NSInteger)index{
    return CGSizeMake(200, 30);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RootCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255 / 255.0 green:arc4random()%255 / 255.0 blue:arc4random()%255 / 255.0 alpha:1];
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.backgroundColor = [UIColor redColor];
        return view;
    }else{
        UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.backgroundColor = [UIColor yellowColor];
        return view;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了 %ld 区的 %ld item",indexPath.section,indexPath.row);
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end
