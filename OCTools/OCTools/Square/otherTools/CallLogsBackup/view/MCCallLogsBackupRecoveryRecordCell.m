//
//  MCCallLogsBackupRecoveryRecordCell.m
//  ChatClub
//
//  Created by ArcherMind on 2020/10/21.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCallLogsBackupRecoveryRecordCell.h"
#import "MCCallLogsBackupRecoveryRecordModel.h"

@interface MCCallLogsBackupRecoveryRecordCell()
@property (nonatomic, strong) UILabel *deviceLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *recoveryBtn;
@end

@implementation MCCallLogsBackupRecoveryRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = DF_COLOR_BGMAIN;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.recoveryBtn];
    [self.recoveryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(48, 24));
        make.right.offset(-16);
    }];
    
    [self.contentView addSubview:self.deviceLabel];
    [self.deviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(10);
        make.right.equalTo(self.recoveryBtn.mas_left).offset(-10);
    }];
    
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.deviceLabel);
        make.bottom.offset(-10);
    }];
}

-(UILabel *)deviceLabel {
    if (!_deviceLabel) {
        _deviceLabel = [UILabel new];
        _deviceLabel.textColor = DF_COLOR_0x(0x000A18);
        _deviceLabel.font = [UIFont systemFontOfSize:16];
    }
    return _deviceLabel;
}

-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = DF_COLOR_0x_alpha(0x000A18, 0.5);
        _dateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dateLabel;
}

-(UIButton *)recoveryBtn {
    if (!_recoveryBtn) {
        _recoveryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recoveryBtn setTitle:@"恢复" forState:UIControlStateNormal];
        [_recoveryBtn setTitleColor:DF_COLOR_0x(0x0065F2) forState:UIControlStateNormal];
        _recoveryBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _recoveryBtn.layer.cornerRadius = 12;
        _recoveryBtn.layer.masksToBounds = YES;
        _recoveryBtn.layer.borderColor = DF_COLOR_0x(0x0065F2).CGColor;
        _recoveryBtn.layer.borderWidth = 0.5;
        
        [_recoveryBtn addTarget:self action:@selector(recoveryAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recoveryBtn;
}

-(void)recoveryAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(recoevryActionWithIndexPath:)]) {
        [self.delegate recoevryActionWithIndexPath:self.indexPath];
    }
}

-(void)updateCellWithModel:(MCCallLogsBackupRecoveryRecordModel *)model {
    self.deviceLabel.text = [NSString stringWithFormat:@"备份设备：%@ （%ld条）",model.backupDevice,model.backupCount];
    self.dateLabel.text = [NSString stringWithFormat:@"备份时间：%@",model.backupDate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
