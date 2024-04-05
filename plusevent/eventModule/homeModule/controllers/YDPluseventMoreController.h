//
//  YDPluseventMoreController.h
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDBaseController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^YDRefreshBlock)(void);

@interface YDPluseventMoreController : YDBaseController

/**  */
@property (nonatomic, copy) YDRefreshBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END
