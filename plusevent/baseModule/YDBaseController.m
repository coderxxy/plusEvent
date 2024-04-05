//
//  YDBaseController.m
//  plusevent
//
//  Created by coderXY on 2024/3/30.
//

#import "YDBaseController.h"

@interface YDBaseController ()

@end

@implementation YDBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#1428A8"];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (UITableView *)listTab{
    if (!_listTab) {
        _listTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTab.backgroundColor = XYThemeColor;
    }
    return _listTab;
}

@end
