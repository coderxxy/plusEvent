//
//  YDBaseTableViewCell.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDBaseTableViewCell.h"

@implementation YDBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = XYThemeColor;
    }
    return self;
}

- (UIView *)cellSuview{
    if (!_cellSuview) {
        _cellSuview = [[UIView alloc] initWithFrame:CGRectZero];
        _cellSuview.backgroundColor = XYHEXCOLOR(@"#ffffff", 0.05);
    }
    return _cellSuview;
}

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

- (UIView *)sepreteLine{
    if (!_sepreteLine) {
        _sepreteLine = [[UIView alloc] initWithFrame:CGRectZero];
        _sepreteLine.backgroundColor = XYHexStrColor(@"#FA1A64");
    }
    return _sepreteLine;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imgView;
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
