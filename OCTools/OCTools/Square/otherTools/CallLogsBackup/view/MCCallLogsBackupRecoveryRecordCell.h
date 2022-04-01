//
//  MCCallLogsBackupRecoveryRecordCell.h
//  ChatClub
//
//  Created by ArcherMind on 2020/10/21.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCCallLogsBackupRecoveryRecordCellDelegate <NSObject>

-(void)recoevryActionWithIndexPath:(NSIndexPath *)indexPath;

@end

@class MCCallLogsBackupRecoveryRecordModel;
@interface MCCallLogsBackupRecoveryRecordCell : UITableViewCell
-(void)updateCellWithModel:(MCCallLogsBackupRecoveryRecordModel *)model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<MCCallLogsBackupRecoveryRecordCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
