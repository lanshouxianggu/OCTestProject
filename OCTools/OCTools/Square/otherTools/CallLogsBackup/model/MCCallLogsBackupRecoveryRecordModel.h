//
//  MCCallLogsBackupRecoveryRecordModel.h
//  ChatClub
//
//  Created by ArcherMind on 2020/10/21.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCCallLogsBackupRecoveryRecordModel : NSObject
@property (nonatomic, strong) NSString *backupDevice;
@property (nonatomic, strong) NSString *backupDate;
@property (nonatomic, assign) NSInteger backupCount;
@end

NS_ASSUME_NONNULL_END
