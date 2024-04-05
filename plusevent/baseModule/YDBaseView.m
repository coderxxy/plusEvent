//
//  YDBaseView.m
//  plusevent
//
//  Created by coderXY on 2024/3/30.
//

#import "YDBaseView.h"

@implementation YDBaseView

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = XYWhiteColor;
        _titleLab.numberOfLines = 0;
        _titleLab.font = XYFont_PF_Medium(15);
    }
    return _titleLab;
}

- (UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLab.textColor = [XYWhiteColor colorWithAlphaComponent:0.5];
        _subTitleLab.font = XYFont_PF_Medium(13);
        _subTitleLab.numberOfLines = 0;
    }
    return _subTitleLab;
}

- (UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLab.textColor = XYWhiteColor;
        _contentLab.font = XYFont_PF_Medium(15);
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imgView;
}

@end
