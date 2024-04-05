//
//  YDPluseventCell.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDPluseventCell.h"

@interface YDPluseventCell ()


@end

@implementation YDPluseventCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self cellSubviews];
    }
    return self;
}

- (void)cellSubviews{
    
    self.titleLab.backgroundColor = XYClearColor;
    self.subTitleLab.backgroundColor = XYClearColor;
    self.contentLab.backgroundColor = XYClearColor;
    
    [self.contentView addSubview:self.cellSuview];
    [self.cellSuview addSubview:self.titleLab];
    [self.cellSuview addSubview:self.subTitleLab];
    [self.cellSuview addSubview:self.outCricleView];
    [self.cellSuview addSubview:self.inCricleView];
    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.sepreteLine];
    [self.cellSuview addSubview:self.contentLab];
    
    [self.cellSuview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellSuview.mas_top).offset(20);
        make.left.equalTo(self.cellSuview.mas_left).offset(20);
        make.width.mas_equalTo(50);
    }];
    [self.subTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.bottom.equalTo(self.cellSuview.mas_bottom).offset(-20);
    }];
    
    [self.outCricleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.width.height.mas_equalTo(16.0);
        make.left.equalTo(self.titleLab.mas_right).offset(15);
    }];
    [self.inCricleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.outCricleView);
        make.width.height.mas_equalTo(6.0);
    }];
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.outCricleView.mas_right).offset(15);
        make.right.equalTo(self.cellSuview.mas_right).offset(-20);
        make.top.equalTo(self.outCricleView.mas_top).offset(-5);
    }];
    
    [self.topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.bottom.equalTo(self.outCricleView);
        make.width.mas_equalTo(1.0);
    }];
    [self.sepreteLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inCricleView.mas_bottom);
        make.centerX.equalTo(self.outCricleView);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(1.0);
    }];
    //
    self.outCricleView.layer.cornerRadius = 8.0;
    self.outCricleView.clipsToBounds = YES;
    self.inCricleView.layer.cornerRadius = 3.0;
    self.inCricleView.clipsToBounds = YES;
    [self.outCricleView layoutIfNeeded];
    [self.inCricleView layoutIfNeeded];
}

- (UIView *)outCricleView{
    if (!_outCricleView) {
        _outCricleView = [[UIView alloc] initWithFrame:CGRectZero];
        _outCricleView.backgroundColor = XYHexStrColor(@"#852392");
    }
    return _outCricleView;
}
- (UIView *)inCricleView{
    if (!_inCricleView) {
        _inCricleView = [[UIView alloc] initWithFrame:CGRectZero];
        _inCricleView.backgroundColor = XYHexStrColor(@"#FA1A64");
    }
    return _inCricleView;
}

- (UIView *)topLine{
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = XYHexStrColor(@"#FA1A64");
    }
    return _topLine;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
