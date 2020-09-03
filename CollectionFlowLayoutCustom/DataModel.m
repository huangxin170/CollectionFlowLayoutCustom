//
//  DataModel.m
//  CollectionFlowLayoutCustom
//
//  Created by huangxin on 2020/9/3.
//  Copyright © 2020 huangxin. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

-(CGFloat)height{
    return _height > 40 ? _height : 40;
}

@end
