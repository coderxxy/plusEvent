//
//  YDPluseventController.m
//  plusevent
//
//  Created by coderXY on 2024/3/30.
//

#import "YDPluseventController.h"
#import "YDPluseventPresenter.h"
#import "YDEventSettingController.h"
#import "YDPluseventCell.h"


@interface YDPluseventController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/** homePresenter */
@property (nonatomic, strong) YDPluseventPresenter *homePresenter;
/** add event btn */
//@property (nonatomic, strong) UIButton *eventBtn;
/**  */
@property (nonatomic, strong) JhtFloatingBall *eventBtn;

@end

@implementation YDPluseventController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [YDEventListModel bg_clear:KEventDBName]; // 测试用
    // Do any additional setup after loading the view.
    [self navigationItemEvent];
    [self config];
    [self subviewsHandle];
    [self.homePresenter queryDataEvent];
}

- (void)navigationItemEvent{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:XY_Img(@"drawer_icon") style:UIBarButtonItemStylePlain target:self action:@selector(openDrawerAction)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:XY_Img(@"add_icon03") style:UIBarButtonItemStylePlain target:self action:@selector(addEvent)];
//    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)openDrawerAction{
    MMDrawerController *mmdc = (MMDrawerController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    [mmdc toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)addEvent{
    YDEventSettingController *setVC = [[YDEventSettingController alloc] init];
    // 选中的日期
    setVC.calendarDate = self.homePresenter.selectedDate;
    XY_Log(@"[xy-log], push:%@", self.homePresenter.selectedDate);
    // 构建外层数据结构
    NSMutableDictionary *dateEvetDic = [NSMutableDictionary dictionary];
    NSString *dateStr = [NSString stringWithFormat:@"%@", setVC.calendarDate];
    // 构建date key
    NSString *dateEventKey = [dateStr substringWithRange:NSMakeRange(0, 10)];
    // 事件数据源
    NSMutableArray *eventArr = [NSMutableArray array];
    // 从本地取出数据
    NSArray <YDEventListModel *>*localSource = [YDEventListModel bg_findAll:KEventDBName];
    YDEventListModel *localListModel = nil;
    NSMutableArray *tempSource = [NSMutableArray array];
    NSMutableArray *localListModelEvents = [NSMutableArray array];
    // events [@{date:[model、model]}, @{date:[model、model]}]
    if ([localSource count] > 0) {
        localListModel = [localSource firstObject];
        [localListModelEvents addObjectsFromArray:localListModel.events];
        [localListModel.events enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            if (dic[dateEventKey]) {
                [tempSource addObjectsFromArray:dic[dateEventKey]];
            }
        }];
    }
    weakify(self)
    setVC.finishBlock = ^(YDEventModel * _Nonnull model) { // [@{date:[model]}]
        [weakself.homePresenter.listDataSource addObject:model];  // 添加到数组中
        [weakself.listTab reloadData];
        //
        [tempSource addObject:model];                                     // 添加model到数组
        dateEvetDic[dateEventKey] = tempSource;                           // 将对应天的事件组装数据
        // 原本没有则添加 、有则更新
        if (localListModel) {
            __block BOOL updated = NO;
            [localListModel.events enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                if (dic[dateEventKey]) {
                    updated = YES;
                    [localListModelEvents replaceObjectAtIndex:idx withObject:dateEvetDic];
                    //
                    *stop = YES;
                    return;
                }
            }];
            if (!updated) {
                [localListModelEvents addObject:dateEvetDic];
            }
            localListModel.events = localListModelEvents;
            self.listModel = localListModel;
        }
        else{
            [localListModelEvents addObject:dateEvetDic];
            // 异步存储
            weakself.listModel.events = [localListModelEvents copy];
        }
//        [weakself.homePresenter.listDataSource addObject:model];
//        [weakself.homePresenter.listDataSource exchangeObjectAtIndex:0 withObjectAtIndex:self.homePresenter.listDataSource.count-1];

        // 每次查完 先清空表数据 下次再存入
        [YDEventListModel bg_clear:KEventDBName];
        [weakself.listModel bg_saveAsync:^(BOOL isSuccess) {
            XY_Log(@"[xy-log], save:%i", isSuccess);
        }];

        XY_Log(@"");
    };
    
    [self.navigationController pushViewController:setVC animated:YES];
}
// MARK: subviews
- (void)subviewsHandle{
    [self.view addSubview:self.calendar];
    [self.view addSubview:self.listTab];
//    [self.view addSubview:self.eventBtn];
    [self.calendar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset([UIDevice navBarHeight]);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(XYSCREEN_WIDTH*0.85);
    }];
    [self.listTab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendar.mas_bottom).offset(20);
        make.left.bottom.right.equalTo(self.view);
    }];
//    [self.eventBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(50.0);
//        make.right.equalTo(self.view.mas_right).offset(-5);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-([UIDevice safeBottomHeight] + XYSCREEN_HEIGHT/4));
//    }];
    self.eventBtn.layer.cornerRadius = 25.0;
    self.eventBtn.clipsToBounds = YES;
    [self.eventBtn layoutIfNeeded];
}
- (void)config{
    self.homePresenter.selectedDate = [self.calendar.today getNowDateFromat];
    self.listTab.tableHeaderView = self.header;
    self.listTab.delegate = (id<UITableViewDelegate>)self.homePresenter;
    self.listTab.dataSource = (id<UITableViewDataSource>)self.homePresenter;
    
    self.listTab.emptyDataSetSource = self;
    self.listTab.emptyDataSetDelegate = self;
    
    [self.listTab registerClass:[YDPluseventCell class] forCellReuseIdentifier:NSStringFromClass([YDPluseventCell class])];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return XY_Img(@"calendar_icon");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"What is your main job, today!\n Go to add!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: XYPlaceolderColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


// MARK: calendar
- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] init];
        _calendar.backgroundColor = XYWhiteColor;
        _calendar.appearance.todayColor = XYHexStrColor(@"#FA1A64");
        _calendar.appearance.weekdayTextColor = XYPlaceolderColor;
        _calendar.appearance.headerTitleColor = XYTextColor;
        _calendar.appearance.headerTitleFont = XY_FONTVALUE(15, 0.3);
        _calendar.appearance.selectionColor = XYThemeColor;             // 点击
        _calendar.appearance.eventDefaultColor = XYHexStrColor(@"#FA1A64");
        _calendar.layer.cornerRadius = 8.0;
        _calendar.clipsToBounds = YES;
        _calendar.delegate = (id<FSCalendarDelegate>)self.homePresenter;
        _calendar.dataSource = (id<FSCalendarDataSource>)self.homePresenter;
    }
    return _calendar;
}
- (JhtFloatingBall *)eventBtn{
    if (!_eventBtn) {
        _eventBtn = [[JhtFloatingBall alloc] initWithFrame:CGRectMake(KSCREENWIDTH-50-10, (KSCREENHEIGHT- KSCREENHEIGHT/4), 50, 50)];
        _eventBtn.stayMode = StayMode_Around;
        _eventBtn.image = XY_Img(@"add_icon_02");
        _eventBtn.delegate = (id<JhtFloatingBallDelegate>)self.homePresenter;
    }
    return _eventBtn;
}

- (YDPluseventTabHeader *)header{
    if (!_header) {
        _header = [[YDPluseventTabHeader alloc] initWithFrame:CGRectMake(0, 0, XYSCREEN_WIDTH, 50)];
        _header.delegate = (id<YDPluseventTabHeaderDelegate>)self.homePresenter;
    }
    return _header;
}
//- (UIButton *)eventBtn {
//    if (!_eventBtn) {
//        _eventBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////        [_eventBtn setImage:XY_Img(@"add_icon_01") forState:UIControlStateNormal];
//        _eventBtn.backgroundColor = XYHexStrColor(@"#FA1A64");
//        [_eventBtn setTitleColor:XYWhiteColor forState:UIControlStateNormal];
//        [_eventBtn setTitle:@"+" forState:UIControlStateNormal];
//        _eventBtn.titleLabel.font = XYFont_PF_Semibold(18.0);
//    }
//    return _eventBtn;
//}
// MARK: presenter
- (YDPluseventPresenter *)homePresenter {
    if (!_homePresenter) {
        _homePresenter = [[YDPluseventPresenter alloc] initWithController:self];
    }
    return _homePresenter;
}

- (YDEventListModel *)listModel {
    if (!_listModel) {
        _listModel = [[YDEventListModel alloc] init];
        _listModel.bg_tableName = KEventDBName;
    }
    return _listModel;
}

@end
