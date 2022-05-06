//
//  OTLDDLogFormatter.m
//  OCTools
//
//  Created by stray s on 2022/5/5.
//

#import "OTLDDLogFormatter.h"

@implementation OTLDDLogFormatter

-(NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *dateStr = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
    dateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *logType = @"";
    switch (logMessage.flag) {
        case DDLogFlagError:logType = @"Error";break;
        case DDLogFlagInfo:logType=@"Info";break;
        case DDLogFlagWarning:logType=@"Warn";break;
        case DDLogFlagDebug:logType=@"Debug";break;
        case DDLogFlagVerbose:logType=@"Verbose";break;
        default:
            break;
    }
    
    NSString *logMsg = [NSString stringWithFormat:@"fileName:%@ | function:%@ | line:%@ | %@ log:%@",
                        [logMessage fileName], logMessage->_function, @(logMessage->_line), logType, logMessage->_message];
    
    NSString *formatStr = [NSString stringWithFormat:@"%@ %@",dateStr,logMsg];
    
    return formatStr;
}

@end
