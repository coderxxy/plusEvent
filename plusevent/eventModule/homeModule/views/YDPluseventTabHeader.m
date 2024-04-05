//
//  YDPluseventTabHeader.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDPluseventTabHeader.h"

@implementation YDPluseventTabHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.moreBtn];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(25);
            make.right.equalTo(self.mas_centerX);
        }];
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(44);
            make.right.equalTo(self.mas_right).offset(-25);
//            make.left.equalTo(self.mas_centerX);
        }];
    }
    return self;
}

- (void)clickEvent {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickMore)]) {
        [self.delegate clickMore];
    }
}

- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:XY_Img(@"more") forState:UIControlStateNormal];
        _moreBtn.backgroundColor = XYThemeColor;
        [_moreBtn addTarget:self action:@selector(clickEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

@end
