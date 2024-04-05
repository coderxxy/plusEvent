//
//  YDEventModel.h
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDEventModel : NSObject

/** beginTime */
@property (nonatomic, copy) NSString *beginTime;
/** beginDate */
@property (nonatomic, strong) NSDate *beginDate;
/** endTime */
@property (nonatomic, copy) NSString *endTime;
/** endDate */
@property (nonatomic, strong) NSDate *endDate;
/** event */
@property (nonatomic, copy) NSString *event;
/** name */
@property (nonatomic, copy) NSString *name;
/** date */
@property (nonatomic, copy) NSString *date;

+ (instancetype)modelWithName:(NSString *)name content:(NSString *)content beginT:(NSString *)beginT endT:(NSString *)endT date:(NSString *)date;

@end

@interface YDEventListModel : NSObject
/** 事件数据组 */
@property (nonatomic, strong) NSArray *events;
/** model */
+ (instancetype)modelWithSource:(NSMutableArray *)source;

@end

NS_ASSUME_NONNULL_END
