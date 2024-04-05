//
//  YDPluseventMoreController.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDPluseventMoreController.h"
#import "YDPluseventCell.h"

@interface YDPluseventMoreController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
/** dataSource */
@property (nonatomic, strong) NSMutableArray *listDataSource;
@property (nonatomic, strong) YDEventListModel *listModel;
@end

@implementation YDPluseventMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationItemEvent];
    [self subviewsHandle];
    [self queryData];
}

- (void)subviewsHandle{
    self.listTab.delegate = self;
    self.listTab.dataSource = self;
    self.listTab.emptyDataSetSource = self;
    self.listTab.emptyDataSetDelegate = self;
    [self.listTab registerClass:[YDPluseventCell class] forCellReuseIdentifier:NSStringFromClass([YDPluseventCell class])];
    [self.view addSubview:self.listTab];
    [self.listTab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

- (void)navigationItemEvent{
    self.navigationItem.title = @"Agenda";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:XY_Img(@"back_icon") style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)backAction{
    (!self.refreshBlock)?:self.refreshBlock();
    self.refreshBlock = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)queryData{
    NSArray * source = [YDEventListModel bg_findAll:KEventDBName];
    XY_Log(@"[xy-log], source:\n%@", source);
    if ([source count] > 0) {
        self.listModel = [source firstObject];
        if ([self.listModel.events count] > 0) {
            [self.listDataSource addObjectsFromArray:self.listModel.events];
        }
    }
    [self.listTab reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.listDataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *eventDic = self.listDataSource[section];
    NSArray *eventSource = [eventDic allValues];
    return [eventSource count]>0?[[eventSource firstObject] count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDPluseventCell *cell = [self.listTab dequeueReusableCellWithIdentifier:NSStringFromClass([YDPluseventCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //
    NSDictionary *eventDic = self.listDataSource[indexPath.section];
    NSArray *eventSource = [eventDic allValues];
    if ([eventSource count] > 0) {
        NSArray *events = [eventSource firstObject];
        YDEventModel *model = events[indexPath.row];
        [self updateCellWithModel:model cell:cell idxPath:indexPath];
    }
    return cell;
}
// MARK:  UPDATE CELL
- (void)updateCellWithModel:(YDEventModel *)model cell:(YDPluseventCell *)cell idxPath:(NSIndexPath *)idxPath{
    cell.topLine.hidden = (0 == idxPath.row);
    cell.outCricleView.hidden = (0 == idxPath.row%2);
    cell.cellSuview.backgroundColor = (0 == idxPath.row%2)?XYHEXCOLOR(@"#ffffff", 0.05):XYClearColor;
//    cell.titleLab.text = [model.beginTime length] > 5?[model.beginTime substringWithRange:NSMakeRange([model.beginTime length] -5, 5)]:model.beginTime;
//    cell.subTitleLab.text = [model.endTime length] > 5?[model.endTime substringWithRange:NSMakeRange([model.endTime length] -5, 5)]:model.endTime;
    cell.titleLab.text = model.beginTime;
    cell.subTitleLab.text = model.endTime;
    cell.contentLab.text = model.event;
    if (idxPath.row == [self.listDataSource count] - 1) {
        [cell.sepreteLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell.cellSuview);
        }];
    }
    else {
        [cell.sepreteLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell.contentView);
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *eventDic = self.listDataSource[indexPath.section];
    NSArray *eventSource = [eventDic allValues];
    NSArray *dateArr = [eventDic allKeys];
    if ([eventSource count] <= 0 || !eventSource) return;
    NSArray *events = [eventSource firstObject];
    NSString *dateKey = [dateArr firstObject]; //  日期 key
    NSMutableArray *tempSource = [NSMutableArray array];
    [tempSource addObjectsFromArray:events];
    YDEventModel *model = events[indexPath.row];
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"删除提示" message:@"是否确认删除本条日程安排！"];
    alertView.buttonCancelBgColor = XYThemeColor;
    weakify(self)
    [alertView addAction:[TYAlertAction actionWithTitle:@"删除" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        strongify(self)
        [tempSource removeObject:model];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        tempDic[dateKey] = tempSource;
        self.listDataSource[indexPath.section] = tempDic;
        [self.listTab reloadData];
        [YDEventListModel bg_clear:KEventDBName];
        if ([self.listDataSource count]<= 0) return;
        self.listModel.events = self.listDataSource;
        [self.listModel bg_saveAsync:^(BOOL isSuccess) {
            XY_Log(@"[xy-log], save:%i", isSuccess);
        }];
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
//        [alertView hideView];
    }]];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *eventDic = self.listDataSource[section];
    NSArray *dateArr = [eventDic allKeys];
    NSArray *eventSource = [eventDic allValues];
    NSString *date = [dateArr firstObject];
    NSArray *events = [eventSource firstObject];
    if ([events count] > 0) {
        NSString *count = [NSString stringWithFormat:@"%@ (%ld events)",date, events.count];
        return count;
    }
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (!sectionTitle) return nil;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 0, 320, 25);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset = CGSizeMake(-1.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:15];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    
    return view;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return XY_Img(@"calendar_icon");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No more agenda!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: XYPlaceolderColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSMutableArray *)listDataSource{
    if (!_listDataSource) {
        _listDataSource = [[NSMutableArray alloc] init];
    }
    return _listDataSource;
}

@end
