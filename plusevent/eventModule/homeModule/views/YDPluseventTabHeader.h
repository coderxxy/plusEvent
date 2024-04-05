//
//  YDPluseventTabHeader.h
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YDPluseventTabHeaderDelegate <NSObject>

- (void)clickMore;

@end

@interface YDPluseventTabHeader : YDBaseView

/** moreBtn */
@property (nonatomic, strong) UIButton *moreBtn;
/** YDPluseventTabHeaderDelegate */
@property (nonatomic, weak) id <YDPluseventTabHeaderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
