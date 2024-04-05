//
//  YDEventSettingController.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDEventSettingController.h"

@interface YDEventSettingController ()<YYTextViewDelegate>
/**  */
@property (nonatomic, strong) BRDatePickerView *datePickerView;
/**  */
@property (nonatomic, strong) YYTextView *textView;
/**  */
@property (nonatomic, strong) UITextField *shortDesTF;
/**  */
@property (nonatomic, strong) UIButton *beginBtn;
/**  */
@property (nonatomic, strong) UIButton *endBtn;
/**  */
@property (nonatomic, strong) UIButton *sureBtn;
/** YDEventModel */
@property (nonatomic, strong) YDEventModel *model;

@end

@implementation YDEventSettingController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self subviewsHandle];
    [self config];
}

- (void)subviewsHandle{
    self.navigationItem.title = @"添加日程";
    [self.view addSubview:self.textView];
    [self.view addSubview:self.beginBtn];
    [self.view addSubview:self.endBtn];
    [self.view addSubview:self.sureBtn];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset([UIDevice navBarHeight] + 20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(XYSCREEN_WIDTH*0.55);
    }];
    [self.beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView);
        make.top.equalTo(self.textView.mas_bottom).offset(10);
        make.right.equalTo(self.textView.mas_centerX).offset(-5);
        make.height.mas_equalTo(44.0);
    }];
    [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textView);
        make.top.equalTo(self.textView.mas_bottom).offset(10);
        make.left.equalTo(self.textView.mas_centerX).offset(5);
        make.height.mas_equalTo(44.0);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.beginBtn.mas_bottom).offset(10);
        make.left.equalTo(self.beginBtn.mas_centerX);
        make.right.equalTo(self.endBtn.mas_centerX);
        make.height.mas_equalTo(44.0);
    }];
    self.textView.layer.cornerRadius = 8;
    self.textView.clipsToBounds = YES;
    [self.textView layoutIfNeeded];
    [self.beginBtn layoutIfNeeded];
    [self.endBtn layoutIfNeeded];
}

- (void)configHandle{
    self.datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        NSLog(@"选择的值：%@", selectValue);
    };
}

- (void)config{
    self.model.date = [NSString stringWithFormat:@"%@", self.calendarDate];
    self.datePickerView.selectDate = [NSDate date];//[NSDate br_setYear:self.calendarDate.br_year  month:self.calendarDate.br_month day:self.calendarDate.br_day hour:self.calendarDate.br_hour minute:self.calendarDate.br_minute];//[NSDate date];//[NSDate br_setYear:2019 month:10 day:30 hour:0 minute:0];
    self.datePickerView.minDate = [NSDate br_setMonth:self.calendarDate.br_month day:self.calendarDate.br_day hour:0 minute:0];//[NSDate br_setYear:1949 month:3 day:12 hour:0 minute:0];// dd-MM-yyyy
    self.datePickerView.maxDate = [NSDate br_setMonth:self.calendarDate.br_month day:self.calendarDate.br_day hour:23 minute:59];//[NSDate br_setYear:2030 month:12 day:31 hour:0 minute:0];//[NSDate date];
}

- (void)clickEventSender:(UIButton *)sender{
    [self.textView endEditing:YES];
    NSInteger idx = sender.tag - 5000;
    __weak typeof(self) WeakSelf = self;
    self.datePickerView.resultBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        XY_Log(@"[xy-log], addEvent:%@", selectDate);
        if (0 == idx) { // begin
            // 对比 结束时间不能比开始时间小
            double diff = [selectDate diffWithEndDate:WeakSelf.model.endDate];
            if (WeakSelf.model.endDate && diff <= 0) {
                [SVProgressHUD showErrorWithStatus:@"结束日期不可小于等于开始日期"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return;
            }
            WeakSelf.model.beginTime = selectValue;
            WeakSelf.model.beginDate = selectDate;
            [WeakSelf.beginBtn setTitle:selectValue forState:UIControlStateNormal];
        }
        else if(1 == idx){
            double diff = [WeakSelf.model.beginDate diffWithEndDate:selectDate];
            if (diff <= 0 && WeakSelf.model.beginDate) {
                [SVProgressHUD showErrorWithStatus:@"结束日期不可小于等于开始日期"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return;
            }
            WeakSelf.model.endTime = selectValue;
            WeakSelf.model.endDate = selectDate;
            [WeakSelf.endBtn setTitle:selectValue forState:UIControlStateNormal];
        }
    };
    // 3.显示
    if (2 == idx) {
        if (self.model.event.length <= 0 || self.model.beginTime.length <= 0  || self.model.endTime.length <= 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入今日的日程内容且请不要忘记安排时间!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        [SVProgressHUD showWithStatus:@"正在保存..."];
        (!self.finishBlock)?:self.finishBlock(self.model);
        self.finishBlock = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [WeakSelf.navigationController popViewControllerAnimated:YES];
        });
        return;
    };
    [self.datePickerView show];
}

#pragma mark - YYTextViewDelegate
- (void)textViewDidEndEditing:(YYTextView *)textView{
    self.model.event = textView.text;
    //
    XY_Log(@"[xy-log]%@", textView.text);
}

- (YDEventModel *)model {
    if (!_model) {
        _model = [[YDEventModel alloc] init];
    }
    return _model;
}

#pragma mark - UI

- (UIButton *)beginBtn{
    if (!_beginBtn) {
        _beginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_beginBtn setTitle:@"开始时间" forState:UIControlStateNormal];
        [_beginBtn setTitleColor:XYThemeColor forState:UIControlStateNormal];
        _beginBtn.backgroundColor = XYWhiteColor;
        _beginBtn.layer.cornerRadius = 5.0;
        _beginBtn.clipsToBounds = YES;
        _beginBtn.tag = 5000;
        [_beginBtn addTarget:self action:@selector(clickEventSender:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beginBtn;
}

- (UIButton *)endBtn{
    if (!_endBtn) {
        _endBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_endBtn setTitle:@"结束时间" forState:UIControlStateNormal];
        [_endBtn setTitleColor:XYThemeColor forState:UIControlStateNormal];
        _endBtn.backgroundColor = XYWhiteColor;
        _endBtn.layer.cornerRadius = 5.0;
        _endBtn.clipsToBounds = YES;
        _endBtn.tag = 5001;
        [_endBtn addTarget:self action:@selector(clickEventSender:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:XYThemeColor forState:UIControlStateNormal];
        _sureBtn.backgroundColor = XYWhiteColor;
        _sureBtn.layer.cornerRadius = 5.0;
        _sureBtn.clipsToBounds = YES;
        _sureBtn.titleLabel.font = XY_FONTVALUE(15, 0.4);
        _sureBtn.tag = 5002;
        [_sureBtn addTarget:self action:@selector(clickEventSender:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sureBtn;
}

- (YYTextView *)textView{
    if (!_textView) {
        _textView = [[YYTextView alloc] initWithFrame:CGRectZero];
        _textView.backgroundColor = XYWhiteColor;
        _textView.font = XYFont_PF_Medium(13);
        _textView.textColor = XYTextColor;
        _textView.delegate = self;
//        _textView.dataDetectorTypes =
        _textView.placeholderText = @"行程安排...";
        _textView.placeholderTextColor = XYPlaceolderColor;
        if (@available(iOS 13.0, *)) {
            _textView.automaticallyAdjustsScrollIndicatorInsets = YES;
        } else {
            // Fallback on earlier versions
            _textView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }
    }
    return _textView;
}

- (BRDatePickerView *)datePickerView{
    if (!_datePickerView) {
        // 1.创建日期选择器
        _datePickerView = [[BRDatePickerView alloc] initWithPickerMode:BRDatePickerModeHM];
        // 2.设置属性
        _datePickerView.title = @"H/M";
        // datePickerView.selectValue = @"2019-10-30";
//        _datePickerView.selectDate = [NSDate br_setMonth:self.calendarDate.br_month day:self.calendarDate.br_day hour:self.calendarDate.br_hour minute:self.calendarDate.br_minute];//[NSDate date];//[NSDate br_setYear:2019 month:10 day:30 hour:0 minute:0];
//        _datePickerView.minDate = [NSDate br_setMonth:self.calendarDate.br_month day:self.calendarDate.br_day hour:0 minute:0];//[NSDate br_setYear:1949 month:3 day:12 hour:0 minute:0];// dd-MM-yyyy
//        _datePickerView.maxDate = [NSDate br_setMonth:self.calendarDate.br_month day:self.calendarDate.br_day hour:23 minute:59];//[NSDate br_setYear:2030 month:12 day:31 hour:0 minute:0];//[NSDate date];
//        _datePickerView.isAutoSelect = YES;
//        _datePickerView.showToday = YES;
        // 设置自定义样式
        BRPickerStyle *customStyle = [[BRPickerStyle alloc] init];
        customStyle.pickerColor = XYWhiteColor;//BR_RGB_HEX(0xd9dbdf, 1.0f);
        customStyle.pickerTextColor = XYTitleColor;
        customStyle.separatorColor = XYLineColor;
//        customStyle.selectRowColor = XYThemeColor;
        customStyle.selectRowTextColor = XYThemeColor;
        _datePickerView.pickerStyle = customStyle;
    }
    return _datePickerView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.textView endEditing:YES];
}

@end
