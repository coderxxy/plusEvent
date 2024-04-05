//
//  YDEventSettingController.h
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDBaseController.h"

NS_ASSUME_NONNULL_BEGIN
// MARK: CALLBACK
typedef void(^YDAddEventFinishBlock)(YDEventModel *model);

@interface YDEventSettingController : YDBaseController
/** finishBlock */
@property (nonatomic, copy) YDAddEventFinishBlock finishBlock;
/** 日历日期 */
@property (nonatomic, strong) NSDate *calendarDate;
@end

NS_ASSUME_NONNULL_END
