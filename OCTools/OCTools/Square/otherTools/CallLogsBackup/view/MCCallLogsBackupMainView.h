//
//  MCCallLogsBackupMainView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/10/14.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCCallLogsBackupMainViewDelegate <NSObject>

-(void)startRecoveryAction;

@end


typedef enum : NSUInteger {
    BackupOrRecoveryStatusOrigion,//初始化状态
    BackupOrRecoveryStatusNeedUpdate,//15天未备份
    BackupOrRecoveryStatusStarting,//备份中
    BackupOrRecoveryStatusFinished,//备份完成
    BackupOrRecoveryStatusFailed,//备份失败
    BackupOrRecoveryStatusPause,//备份暂停
} BackupOrRecoveryStatus;

@interface MCCallLogsBackupMainView : UIView
@property (nonatomic, weak) id<MCCallLogsBackupMainViewDelegate> delegate;
@property (nonatomic, assign) BackupOrRecoveryStatus status;
-(void)startRecovery;//开始恢复
-(void)startBackup;//开始备份
@end

NS_ASSUME_NONNULL_END
