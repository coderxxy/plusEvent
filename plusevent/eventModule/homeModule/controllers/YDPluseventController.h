//
//  YDPluseventController.h
//  plusevent
//
//  Created by coderXY on 2024/3/30.
//

#import "YDBaseController.h"
#import "FSCalendar.h"
#import "YDPluseventTabHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface YDPluseventController : YDBaseController
/** calendar */
@property (nonatomic, strong) FSCalendar *calendar;
/** YDPluseventTabHeader */
@property (nonatomic, strong) YDPluseventTabHeader *header;
/**  */
@property (nonatomic, strong) YDEventListModel *listModel;
@end

NS_ASSUME_NONNULL_END
