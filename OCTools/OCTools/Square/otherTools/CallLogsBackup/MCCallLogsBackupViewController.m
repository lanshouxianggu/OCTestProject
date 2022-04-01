//
//  MCCallLogsBackupViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/10/14.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCallLogsBackupViewController.h"
#import "MCCallLogsBackupMainView.h"
#import "MCCallLogsBackupChooseRecoveryRecordView.h"
#import "MCVideoMoreDetailView.h"

@interface MCCallLogsBackupViewController () <MCCallLogsBackupMainViewDelegate,MCCallLogsBackupChooseRecoveryRecordViewDelegate,MCVideoMoreDetailViewDelegate>
@property (nonatomic, strong) MCCallLogsBackupMainView *mainView;
@property (nonatomic, strong) MCCallLogsBackupChooseRecoveryRecordView *chooseView;
@property (nonatomic, strong) MCVideoMoreDetailView *moreDetailView;
@end

@implementation MCCallLogsBackupViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通话记录备份";
    self.view.backgroundColor = DF_COLOR_BGMAIN;
    
    [self.view addSubview:self.mainView];
//    [self.view addSubview:self.chooseView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.chooseView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.moreDetailView];
    
    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(detailButtonClick)];
    self.navigationItem.rightBarButtonItem = detailItem;
}

-(MCCallLogsBackupMainView *)mainView {
    if (!_mainView) {
        _mainView = [[MCCallLogsBackupMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mainView.backgroundColor = DF_COLOR_BGMAIN;
        _mainView.delegate = self;
    }
    return _mainView;
}

-(MCCallLogsBackupChooseRecoveryRecordView *)chooseView {
    if (!_chooseView) {
        _chooseView = [[MCCallLogsBackupChooseRecoveryRecordView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _chooseView.delegate = self;
    }
    return _chooseView;
}

-(MCVideoMoreDetailView *)moreDetailView {
    if (!_moreDetailView) {
        _moreDetailView = [[MCVideoMoreDetailView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _moreDetailView.delegate = self;
    }
    return _moreDetailView;
}

-(void)detailButtonClick {
    [UIView animateWithDuration:0.35 animations:^{
        self.moreDetailView.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.moreDetailView.backgroundColor = DF_COLOR_0x_alpha(0x000, 0.3);
        }];
    }];
}

#pragma mark - MCCallLogsBackupMainViewDelegate
-(void)startRecoveryAction {
    [UIView animateWithDuration:0.35 animations:^{
        self.chooseView.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.chooseView.backgroundColor = DF_COLOR_0x_alpha(0x000, 0.5);
        }];
    }];
}

#pragma mark - MCCallLogsBackupChooseRecoveryRecordViewDelegate
-(void)startRecoveryWithStyle:(RecoveryStyle)style {
    if (style==RecoveryStyleCover) {
//        [TipProgress showText:@"覆盖恢复"];
    }else if (style==RecoveryStyleMerge) {
//        [TipProgress showText:@"合并恢复"];
    }
    [self.mainView startRecovery];
}

#pragma mark - MCVideoMoreDetailViewDelegate
-(void)videoMoreDetailViewDeleteAction {
//    [TipProgress showText:@"删除"];
}

-(void)videoMoreDetailViewDownloadAction {
//    [TipProgress showText:@"下载"];
}

-(void)videoMoreDetailViewArticulationAction {
//    [TipProgress showText:@"清晰度"];
}

-(void)videoMoreDetailViewSpeedPlayAction {
//    [TipProgress showText:@"倍速播放"];
}

-(void)videoMoreDetailViewDetailInfoAction {
//    [TipProgress showText:@"详细信息"];
}
@end
