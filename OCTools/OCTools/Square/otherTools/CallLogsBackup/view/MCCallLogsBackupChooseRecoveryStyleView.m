//
//  MCCallLogsBackupChooseRecoveryStyleView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/10/21.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCallLogsBackupChooseRecoveryStyleView.h"
#import "MCCallLogsBackupRecoveryRecordModel.h"

@interface MCCallLogsBackupChooseRecoveryStyleView()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *styleFirstView;
@property (nonatomic, strong) UIView *styleSecondView;
@property (nonatomic, strong) UILabel *backupDeviceLabel;
@property (nonatomic, strong) UILabel *backupDateLabel;
@end

@implementation MCCallLogsBackupChooseRecoveryStyleView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DF_COLOR_BGMAIN;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIView *sv = [UIView new];
    [self.scrollView addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
        make.width.mas_equalTo(self.scrollView);
        make.height.mas_greaterThanOrEqualTo(self.scrollView);
    }];
    
    ({
        [sv addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16);
            make.right.offset(-16);
            make.height.mas_equalTo(84);
            make.top.offset(0);
        }];
        
        [sv addSubview:self.styleFirstView];
        [self.styleFirstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_bottom).offset(24);
            make.left.right.equalTo(self.headView);
            make.height.mas_greaterThanOrEqualTo(64);
        }];
        
        [sv addSubview:self.styleSecondView];
        [self.styleSecondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.headView);
            make.top.equalTo(self.styleFirstView.mas_bottom).offset(24);
            make.bottom.offset(0);
            make.height.mas_greaterThanOrEqualTo(64);
        }];
    });
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = DF_COLOR_BGMAIN;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

-(UIView *)headView {
    if (!_headView) {
        _headView = [UIView new];
        _headView.backgroundColor = DF_COLOR_0x(0xE6F0FE);
        _headView.layer.cornerRadius = 8;
        
        UILabel *titleLab = [UILabel new];
        titleLab.text = @"已选择恢复记录";
        titleLab.textColor = DF_COLOR_0x(0x000A18);
        titleLab.font = [UIFont systemFontOfSize:16];
        
        [_headView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(8);
            make.top.offset(7);
            make.height.mas_equalTo(24);
        }];
        
        [_headView addSubview:self.backupDeviceLabel];
        [self.backupDeviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLab);
            make.top.equalTo(titleLab.mas_bottom).offset(4);
            make.right.offset(-70);
            make.height.mas_equalTo(18);
        }];
        
        [_headView addSubview:self.backupDateLabel];
        [self.backupDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLab);
            make.top.equalTo(self.backupDeviceLabel.mas_bottom).offset(4);
            make.right.offset(-70);
            make.height.mas_equalTo(18);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"重新选择" forState:UIControlStateNormal];
        [btn setTitleColor:DF_COLOR_0x(0x0065F2) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(reChooseAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_headView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.right.offset(-16);
        }];
    }
    return _headView;
}

-(UIView *)styleFirstView {
    if (!_styleFirstView) {
        _styleFirstView = [UIView new];
        _styleFirstView.backgroundColor = DF_COLOR_BGMAIN;
        
        UILabel *titleLab = [UILabel new];
        titleLab.text = @"云端通话记录覆盖手机（推荐）";
        titleLab.textColor = DF_COLOR_0x(0x000A18);
        titleLab.font = [UIFont systemFontOfSize:16];
        
        [_styleFirstView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(5);
            make.height.mas_equalTo(24);
        }];
        
        UILabel *descLab = [UILabel new];
        descLab.text = @"将云端通话记录下载到本地，并覆盖本地已有通话记录";
        descLab.textColor = DF_COLOR_0x_alpha(0x000A18, 0.5);
        descLab.font = [UIFont systemFontOfSize:12];
        descLab.numberOfLines = 0;
        
        [_styleFirstView addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.equalTo(titleLab.mas_bottom).offset(8);
            make.right.offset(-80);
            make.bottom.offset(0);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"开始恢复" forState:UIControlStateNormal];
        [btn setTitleColor:DF_COLOR_0x(0x0065F2) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.layer.cornerRadius = 12;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = DF_COLOR_0x(0x0065F2).CGColor;
        btn.layer.borderWidth = 0.5;
        btn.tag = RecoveryStyleCover;
        [btn addTarget:self action:@selector(startRecoveryAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_styleFirstView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.offset(0);
            make.size.mas_equalTo(CGSizeMake(64, 24));
        }];
    }
    return _styleFirstView;
}

-(UIView *)styleSecondView {
    if (!_styleSecondView) {
        _styleSecondView = [UIView new];
        _styleSecondView.backgroundColor = DF_COLOR_BGMAIN;
        
        UILabel *titleLab = [UILabel new];
        titleLab.text = @"云端通话记录合并手机";
        titleLab.textColor = DF_COLOR_0x(0x000A18);
        titleLab.font = [UIFont systemFontOfSize:16];
        
        [_styleSecondView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(5);
            make.height.mas_equalTo(24);
        }];
        
        UILabel *descLab = [UILabel new];
        descLab.text = @"在手机通话记录原基础上，将云端选择的通话记录新增的记录下载到本地，已存在的相同通话记录数据不受影响";
        descLab.textColor = DF_COLOR_0x_alpha(0x000A18, 0.5);
        descLab.font = [UIFont systemFontOfSize:12];
        descLab.numberOfLines = 0;
        
        [_styleSecondView addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.equalTo(titleLab.mas_bottom).offset(8);
            make.right.offset(-80);
            make.bottom.offset(-5);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"开始恢复" forState:UIControlStateNormal];
        [btn setTitleColor:DF_COLOR_0x(0x0065F2) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.layer.cornerRadius = 12;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = DF_COLOR_0x(0x0065F2).CGColor;
        btn.layer.borderWidth = 0.5;
        btn.tag = RecoveryStyleMerge;
        [btn addTarget:self action:@selector(startRecoveryAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_styleSecondView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.offset(0);
            make.size.mas_equalTo(CGSizeMake(64, 24));
        }];
    }
    return _styleSecondView;
}

-(UILabel *)backupDeviceLabel {
    if (!_backupDeviceLabel) {
        _backupDeviceLabel = [UILabel new];
        _backupDeviceLabel.textColor = DF_COLOR_0x_alpha(0x000A18, 0.5);
        _backupDeviceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _backupDeviceLabel;
}

-(UILabel *)backupDateLabel {
    if (!_backupDateLabel) {
        _backupDateLabel = [UILabel new];
        _backupDateLabel.textColor = DF_COLOR_0x_alpha(0x000A18, 0.5);
        _backupDateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _backupDateLabel;
}

#pragma mark - setter
-(void)setModel:(MCCallLogsBackupRecoveryRecordModel *)model {
    _model = model;
    self.backupDeviceLabel.text = [NSString stringWithFormat:@"备份设备：%@（%ld条）",model.backupDevice,model.backupCount];
    self.backupDateLabel.text = [NSString stringWithFormat:@"备份时间：%@",model.backupDate];
}

#pragma mark - action
-(void)reChooseAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(reChooseAction)]) {
        [self.delegate reChooseAction];
    }
}

-(void)startRecoveryAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(startRecoveryWithStyle:)]) {
        [self.delegate startRecoveryWithStyle:sender.tag];
    }
}
@end
