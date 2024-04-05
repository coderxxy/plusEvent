//
//  NSDate+extension.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "NSDate+extension.h"

@implementation NSDate (extension)
// MARK: 日期比较
- (double)diffWithEndDate:(NSDate *)endDate{
    double begin = [self timeIntervalSince1970] * 1000;
    double end = [endDate timeIntervalSince1970] * 1000;
    double diff = end - begin;
    XY_Log(@"[xy-log], diff:%.2f", diff);
    return diff;
}
// 获取真实日期
- (NSDate *)getNowDateFromat{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    return destinationDateNow;
}
@end
