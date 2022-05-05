//
//  OTLDDLogFileManagerDefault.m
//  OCTools
//
//  Created by stray s on 2022/5/5.
//

#import "OTLDDLogFileManagerDefault.h"

@interface OTLDDLogFileManagerDefault ()
@property (nonatomic, strong) NSString *fileName;
@end

@implementation OTLDDLogFileManagerDefault

-(instancetype)initWithLogsDirectory:(NSString *)logsDirectory fileName:(NSString *)name {
    //logsDirectory日志自定义路径
    if (self = [super initWithLogsDirectory:logsDirectory]) {
        self.fileName = name;
    }
    return self;
}

#pragma mark - Override methods
-(NSString *)newLogFileName {
    //重写文件名
    NSDateFormatter *dateFormatter = [self logFileDateFormatter];
    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@-%@.log",self.fileName,formattedDate];;
}

-(NSDateFormatter *)logFileDateFormatter {
    //获取当前线程的字典
    NSMutableDictionary *dic = [[NSThread currentThread] threadDictionary];
    //设置日期格式
    NSString *dateFormat = @"yyyy'-'MM'-'dd";
    NSString *key = [NSString stringWithFormat:@"logFileDateFormatter.%@",dateFormat];
    NSDateFormatter *dateFormatter = dic[key];
    
    if (!dateFormatter) {
        //设置日期格式
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        dic[key] = dateFormatter;
    }
    return dateFormatter;
}
@end
