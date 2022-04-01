//
//  MCCallLogsBackupChooseRecoveryStyleView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/10/21.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RecoveryStyleCover,
    RecoveryStyleMerge,
} RecoveryStyle;

@protocol MCCallLogsBackupChooseRecoveryStyleViewDelegate <NSObject>

-(void)reChooseAction;
-(void)startRecoveryWithStyle:(RecoveryStyle)style;

@end

@class MCCallLogsBackupRecoveryRecordModel;
@interface MCCallLogsBackupChooseRecoveryStyleView : UIView
@property (nonatomic, weak) id<MCCallLogsBackupChooseRecoveryStyleViewDelegate> delegate;
@property (nonatomic, strong) MCCallLogsBackupRecoveryRecordModel *model;
@end

NS_ASSUME_NONNULL_END
