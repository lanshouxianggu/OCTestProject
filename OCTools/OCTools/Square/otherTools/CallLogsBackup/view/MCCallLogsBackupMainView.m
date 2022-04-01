//
//  MCCallLogsBackupMainView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/10/14.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCallLogsBackupMainView.h"
#import "MCCallLogsBackupFirstPartView.h"
#import "MCCallLogsBackupSecondPartView.h"

@interface MCCallLogsBackupMainView () <MCCallLogsBackupSecondPartViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MCCallLogsBackupFirstPartView *firstView;
@property (nonatomic, strong) MCCallLogsBackupSecondPartView *secondView;
@end

@implementation MCCallLogsBackupMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(self.frame.size.height);
    }];
    
    UIView *sv = [UIView new];
    sv.backgroundColor = DF_COLOR_BGMAIN;
    
    [self.scrollView addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.width.mas_equalTo(self.scrollView);
        make.height.mas_equalTo(self.scrollView);
        make.bottom.offset(-100);
    }];
    
    [sv addSubview:self.firstView];
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_greaterThanOrEqualTo(302);
    }];
    
    [sv addSubview:self.secondView];
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(96);
        make.top.equalTo(self.firstView.mas_bottom);
    }];
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = DF_COLOR_BGMAIN;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

-(MCCallLogsBackupFirstPartView *)firstView {
    if (!_firstView) {
        _firstView = [MCCallLogsBackupFirstPartView new];
        _firstView.backgroundColor = DF_COLOR_BGMAIN;
    }
    return _firstView;
}

-(MCCallLogsBackupSecondPartView *)secondView {
    if (!_secondView) {
        _secondView = [MCCallLogsBackupSecondPartView new];
        _secondView.backgroundColor = DF_COLOR_BGMAIN;
        _secondView.delegate = self;
    }
    return _secondView;
}

-(void)startBackup {
    [self.firstView startBackup];
}

-(void)startRecovery {
    [self.firstView startRecovery];
}

#pragma mark - MCCallLogsBackupSecondPartViewDelegate
-(void)startBackupAction {
    [self.firstView startBackup];
}

-(void)startRecoveryAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(startRecoveryAction)]) {
        [self.delegate startRecoveryAction];
    }
}
@end
