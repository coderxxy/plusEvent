//
//  YDDbManager.m
//  plusevent
//
//  Created by coderXY on 2024/4/4.
//

#import "YDDbManager.h"
/** extern key */
NSString *const YD_DB_Tab = @"YD_DB_Tab";

@interface YDDbManager ()

@end

@implementation YDDbManager
// 1、创建表
- (void)createDB:(NSString *)dbName{
    bg_setDebug(YES);
    bg_setSqliteName(dbName?dbName:@"YD_DB");
    bg_setDisableCloseDB(YES);
}
// 2、添加
- (void)addModel:(id)model{
    
}
// 3、更新
// 4、删除
// 5、条件查询
// 6、获取全部


@end
