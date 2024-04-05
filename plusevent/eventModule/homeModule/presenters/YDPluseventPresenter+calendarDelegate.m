//
//  YDPluseventPresenter+calendarDelegate.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDPluseventPresenter+calendarDelegate.h"
#import "YDPluseventController.h"

@interface YDPluseventPresenter ()<FSCalendarDelegate, FSCalendarDataSource>

@end

@implementation YDPluseventPresenter (calendarDelegate)
#pragma mark - FSCalendarDelegate, FSCalendarDataSource
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
//    NSDate *tempDate = [self getNowDateFromatAnDate:date];
    self.selectedDate = [date getNowDateFromat];
    [self queryDataEvent];
    XY_Log(@"[xy-log], %@,\n %@", date, calendar.selectedDate);
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated{
    [self.homeController.calendar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(bounds.size.height));
        // Do other updates
    }];
    [self.homeController.view layoutIfNeeded];
}
@end
