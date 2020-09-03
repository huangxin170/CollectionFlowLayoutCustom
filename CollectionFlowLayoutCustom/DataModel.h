//
//  DataModel.h
//  CollectionFlowLayoutCustom
//
//  Created by huangxin on 2020/9/3.
//  Copyright © 2020 huangxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject

@property (nonatomic , strong) UIColor * color;
@property (nonatomic , copy) NSString * title;
@property (nonatomic , assign) CGFloat height;

@end

NS_ASSUME_NONNULL_END
