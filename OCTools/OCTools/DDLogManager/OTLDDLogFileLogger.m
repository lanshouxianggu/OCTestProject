//
//  OTLDDLogFileLogger.m
//  OCTools
//
//  Created by stray s on 2022/5/5.
//

#import "OTLDDLogFileLogger.h"
#import "OTLDDLogFileManagerDefault.h"

@interface OTLDDLogFileLogger ()
@property (nonatomic, assign) NSUInteger flag;
@property (nonatomic, copy) NSString *fileName;
@end

@implementation OTLDDLogFileLogger

-(instancetype)initWithFileName:(nonnull NSString *)fileName {
    //新建一个文件夹去保存
    if (self = [super init]) {
//        self.flag = flag;
        self.fileName = fileName;
        self.rollingFrequency = 60*60*24;
        self.logFileManager.maximumNumberOfLogFiles = 7;
//        NSString *logsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/%ld",(long)flag]];
        NSString *logsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/AppLogs"]];
        OTLDDLogFileManagerDefault *defaultLogFileManager = [[OTLDDLogFileManagerDefault alloc] initWithLogsDirectory:logsDirectory fileName:self.fileName];
        return [self initWithLogFileManager:defaultLogFileManager];
    }
    return self;
}

@end
