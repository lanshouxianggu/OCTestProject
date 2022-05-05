//
//  OTLDDLogFileManagerDefault.h
//  OCTools
//
//  Created by stray s on 2022/5/5.
//

#import "DDFileLogger.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTLDDLogFileManagerDefault : DDLogFileManagerDefault
- (instancetype)initWithLogsDirectory:(NSString *)logsDirectory fileName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
