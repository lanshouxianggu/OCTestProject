//
//  OTLDDLogFormatter.m
//  OCTools
//
//  Created by stray s on 2022/5/5.
//

#import "OTLDDLogFormatter.h"

@implementation OTLDDLogFormatter

-(NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    return [NSString stringWithFormat:@"fileName:%@ | function:%@ | line:%@ | message:%@",
            [logMessage fileName], logMessage->_function, @(logMessage->_line), logMessage->_message];
}

@end
