//
//  YDEventModel.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDEventModel.h"

@implementation YDEventModel

+ (instancetype)modelWithName:(NSString *)name content:(NSString *)content beginT:(NSString *)beginT endT:(NSString *)endT date:(NSString *)date{
    YDEventModel *model = [[YDEventModel alloc] init];
    model.name = name;
    model.event = content;
    model.beginTime = beginT;
    model.endTime = endT;
    model.date = date;
    return model;
}

@end


@implementation YDEventListModel

+ (instancetype)modelWithSource:(NSMutableArray *)source{
    YDEventListModel *model = [[YDEventListModel alloc] init];
    model.events = [source copy];
    return model;
}

@end
