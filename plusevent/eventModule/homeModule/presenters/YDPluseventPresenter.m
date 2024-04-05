//
//  YDPluseventPresenter.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDPluseventPresenter.h"
#import "YDPluseventController.h"
#import "YDEventSettingController.h"
#import "YDPluseventMoreController.h"
#import "YDPluseventCell.h"

@interface YDPluseventPresenter ()<JhtFloatingBallDelegate, YDPluseventTabHeaderDelegate>
/** NSDateFormatter */
@property (nonatomic, strong) NSDateFormatter *formatter;
/** NSCalendar */
@property (nonatomic, strong) NSCalendar *gregorian;

@end

@implementation YDPluseventPresenter
- (instancetype)initWithController:(UIViewController *)controller{
    self = [super initWithController:controller];
    if (self) {
        self.homeController = (YDPluseventController *)controller;
    }
    return self;
}
- (void)defaultConfig{
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"YYYY-MM-dd";
    
//    NSDate *date = [self.formatter dateFromString:@"2016-09-10"];
//    //
//    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
//    NSInteger era = [self.gregorian component:NSCalendarUnitEra fromDate:date];
//    NSInteger year = [self.gregorian component:NSCalendarUnitYear fromDate:date];
//    NSInteger month = [self.gregorian component:NSCalendarUnitMonth fromDate:date];
//    NSInteger day = [self.gregorian component:NSCalendarUnitDay fromDate:date];
//    NSInteger hour = [self.gregorian component:NSCalendarUnitHour fromDate:date];
//    NSInteger minute = [self.gregorian component:NSCalendarUnitMinute fromDate:date];
    
//    BOOL isToday = [self.gregorian isDateInToday:date];
//    BOOL isYesterday = [self.gregorian isDateInYesterday:date];
//    BOOL isTomorrow = [self.gregorian isDateInTomorrow:date];
//    BOOL isWeekend = [self.gregorian isDateInWeekend:date];
}

- (void)queryDataEvent{
    NSArray * source = [YDEventListModel bg_findAll:KEventDBName];
    XY_Log(@"[xy-log], source:\n%@", source);
    YDEventListModel *listModel = [source firstObject];
    [self.listDataSource removeAllObjects];
    //
    NSString *dateKey = [NSString stringWithFormat:@"%@", self.selectedDate];
    dateKey = [dateKey substringWithRange:NSMakeRange(0, 10)];
    if ([listModel.events count] > 0) {
        [listModel.events enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *events = dic[dateKey];
            if ([events count] > 0) {
                self.homeController.header.titleLab.text = [NSString stringWithFormat:@"%ld events", [events count]];
                [self.listDataSource addObjectsFromArray:events];
                *stop = YES;
                return;
            }
            else{
                self.homeController.header.titleLab.text = nil;
            }
        }];
    }
    else{
        self.homeController.header.titleLab.text = nil;
    }
    [self.homeController.listTab reloadData];
}

#pragma mark - JhtFloatingBallDelegate
- (void)tapFloatingBall{
    YDEventSettingController *setVC = [[YDEventSettingController alloc] init];
    [self.homeController.navigationController pushViewController:setVC animated:YES];
}

#pragma mark - YDPluseventTabHeaderDelegate
- (void)clickMore{
    YDPluseventMoreController *moreVC = [[YDPluseventMoreController alloc] init];
    weakify(self)
    moreVC.refreshBlock = ^{
        [weakself queryDataEvent];
    };
    [self.homeController.navigationController pushViewController:moreVC animated:YES];
}

- (NSMutableArray *)listDataSource{
    if (!_listDataSource) {
        _listDataSource = [[NSMutableArray alloc] init];
    }
    return _listDataSource;
}

@end
