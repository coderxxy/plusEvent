//
//  YDPluseventCell.h
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YDPluseventCell : YDBaseTableViewCell
/** 内侧圈 */
@property (nonatomic, strong) UIView *inCricleView;
/** 外侧圈 */
@property (nonatomic, strong) UIView *outCricleView;
/** line */
@property (nonatomic, strong) UIView *topLine;
@end

NS_ASSUME_NONNULL_END
