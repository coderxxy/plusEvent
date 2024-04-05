//
//  YDBaseView.h
//  plusevent
//
//  Created by coderXY on 2024/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDBaseView : UIView
/** titleLab */
@property (nonatomic, strong) UILabel *titleLab;
/** subTitleLab */
@property (nonatomic, strong) UILabel *subTitleLab;
/** contentLab */
@property (nonatomic, strong) UILabel *contentLab;
/** imgView */
@property (nonatomic, strong) UIImageView *imgView;
@end

NS_ASSUME_NONNULL_END
