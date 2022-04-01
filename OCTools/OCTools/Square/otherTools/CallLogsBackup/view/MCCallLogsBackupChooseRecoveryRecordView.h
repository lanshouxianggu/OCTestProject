//
//  MCCallLogsBackupChooseRecoveryRecordView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/10/20.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCallLogsBackupChooseRecoveryStyleView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MCCallLogsBackupChooseRecoveryRecordViewDelegate <NSObject>

-(void)startRecoveryWithStyle:(RecoveryStyle)style;

@end

@interface MCCallLogsBackupChooseRecoveryRecordView : UIView
@property (nonatomic, weak) id<MCCallLogsBackupChooseRecoveryRecordViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
