//
//  MCCallLogsBackupFirstPartView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/10/20.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCallLogsBackupMainView.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CallLogsTypeBackup,//通话记录备份
    CallLogsTypeRecovery,//通话记录恢复
} CallLogsType;

@interface MCCallLogsBackupFirstPartView : UIView
//-(void)updateProgress:(CGFloat)progress type:(CallLogsType)type;

-(void)startRecovery;//开始恢复
-(void)startBackup;//开始备份
@end

@interface MCCallLogsBackupFirstPartRecordCell : UITableViewCell
@property (nonatomic, strong) UILabel *recordLabel;
@property (nonatomic, assign) BackupOrRecoveryStatus backupState;
@end

NS_ASSUME_NONNULL_END
