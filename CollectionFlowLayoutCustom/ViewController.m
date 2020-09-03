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
#import "DataModel.h"
#import "HeaderCollectionReusableView.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,RootViewFlowLayoutDelegate>
@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    [self creatData];
    
}
-(void)creatUI{
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
    [self.collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
}
-(void)creatData{
    for (int sectionIndex = 0; sectionIndex < 3; sectionIndex ++ ) {
        NSMutableArray * itemArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < 50; i ++) {
               CGFloat height = arc4random()%100;
               DataModel * model = [[DataModel alloc]init];
               model.color = [UIColor colorWithRed:arc4random()%255 / 255.0 green:arc4random()%255 / 255.0 blue:arc4random()%255 / 255.0 alpha:1];
               model.title = [NSString stringWithFormat:@"第%d区的%d个数据",sectionIndex,i];
               model.height = height;
               [itemArray addObject:model];
           }
        [self.dataArray addObject:itemArray];
    }
   
    [self.collectionView reloadData];
}
#pragma mark delegate
-(CGFloat)collectionViewWithItemHeightIndex:(NSIndexPath *)indexPath{
    DataModel * model = self.dataArray[indexPath.section][indexPath.row];
    return model.height;
}
-(CGSize)collectionViewWithHeaderSizeIndex:(NSInteger)index{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}
-(CGSize)collectionViewWithFooterSizeIndex:(NSInteger)index{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RootCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.titleLabel.text = [NSString stringWithFormat:@"这是第%ld个区头",indexPath.section];
        view.backgroundColor = [UIColor blackColor];
        return view;
    }else{
        HeaderCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.titleLabel.text = [NSString stringWithFormat:@"这是第%ld个区尾",indexPath.section];
        view.backgroundColor = [UIColor lightGrayColor];
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
