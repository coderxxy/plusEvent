//
//  YDPluseventPresenter+tabDelegate.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDPluseventPresenter+tabDelegate.h"
#import "YDPluseventController.h"
#import "YDPluseventCell.h"

@interface YDPluseventPresenter ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation YDPluseventPresenter (tabDelegate)
// 去除 Category is implementing a method which will also be implemented by its primary class 警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDPluseventCell *cell = [self.homeController.listTab dequeueReusableCellWithIdentifier:NSStringFromClass([YDPluseventCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YDEventModel *model = self.listDataSource[indexPath.row];
    [self updateCellWithModel:model cell:cell idxPath:indexPath];
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
    //
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
    YDEventModel *model = self.listDataSource[indexPath.row];
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"删除提示" message:@"是否确认删除本条日程安排！"];
    alertView.buttonCancelBgColor = XYThemeColor;
    // 重新组装数据
    NSMutableDictionary *todayDic = [NSMutableDictionary dictionary];
    NSString *dateKey = [NSString stringWithFormat:@"%@", self.selectedDate];
    dateKey = [dateKey substringWithRange:NSMakeRange(0, 10)];
    weakify(self)
    [alertView addAction:[TYAlertAction actionWithTitle:@"删除" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        strongify(self)
        [self.listDataSource removeObject:model];
        [self.homeController.listTab reloadData];
        // 更新数据
        if ([self.listDataSource count] > 0) {
            todayDic[dateKey] = self.listDataSource;
            //
            NSArray * source = [YDEventListModel bg_findAll:KEventDBName];
            XY_Log(@"[xy-log], source:\n%@", source);
            YDEventListModel *listModel = [source firstObject];
            NSMutableArray *tempEvents = [NSMutableArray array];
            [tempEvents addObjectsFromArray:listModel.events];
            [listModel.events enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj[dateKey]) {
                    [tempEvents replaceObjectAtIndex:idx withObject:todayDic];
                }
            }];
            [YDEventListModel bg_clear:KEventDBName];
            self.homeController.listModel.events = tempEvents;
            [self.homeController.listModel bg_saveAsync:^(BOOL isSuccess) {
                XY_Log(@"[xy-log], save:%i", isSuccess);
            }];
        }
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
//        [alertView hideView];
    }]];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self.homeController presentViewController:alertController animated:YES completion:nil];
}

#pragma clang diagnostic pop
@end
