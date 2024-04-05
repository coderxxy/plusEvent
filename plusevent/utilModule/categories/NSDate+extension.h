//
//  NSDate+extension.h
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (extension)
/** 日期比较 */
- (double)diffWithEndDate:(NSDate *)endDate;
/** 获取真实日期 */
- (NSDate *)getNowDateFromat;
@end

NS_ASSUME_NONNULL_END
