//
//  MCCallLogsBackupSecondPartView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/10/20.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCCallLogsBackupSecondPartViewDelegate <NSObject>

-(void)startBackupAction;
-(void)startRecoveryAction;

@end

@interface MCCallLogsBackupSecondPartView : UIView
@property (nonatomic, weak) id<MCCallLogsBackupSecondPartViewDelegate> delegate;
@end

@interface MCCallLogsBackupSecondPartCell : UIView
-(instancetype)initWithLeftTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightBtnTitle;
@property (nonatomic, copy) void(^cellBlock)(void);
@end

NS_ASSUME_NONNULL_END
