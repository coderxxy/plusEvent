//
//  YDPluseventPresenter.h
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDBasePresenter.h"
@class YDPluseventController;

NS_ASSUME_NONNULL_BEGIN

@interface YDPluseventPresenter : YDBasePresenter
/** dataSource */
@property (nonatomic, strong) NSMutableArray *listDataSource;
/** YDPluseventController */
@property (nonatomic, weak) YDPluseventController *homeController;
/** 选中的日期 */
@property (nonatomic, strong) NSDate *selectedDate;
/** data event */
- (void)queryDataEvent;
@end

NS_ASSUME_NONNULL_END
