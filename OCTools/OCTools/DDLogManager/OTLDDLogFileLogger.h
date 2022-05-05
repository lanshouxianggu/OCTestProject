//
//  OTLDDLogFileLogger.h
//  OCTools
//
//  Created by stray s on 2022/5/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLDDLogFileLogger : DDFileLogger
-(instancetype)initWithFileName:(nonnull NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
