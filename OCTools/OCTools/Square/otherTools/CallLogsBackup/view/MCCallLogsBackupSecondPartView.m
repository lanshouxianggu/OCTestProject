//
//  MCCallLogsBackupSecondPartView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/10/20.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCallLogsBackupSecondPartView.h"

@interface MCCallLogsBackupSecondPartView()
@property (nonatomic, strong) MCCallLogsBackupSecondPartCell *firstCell;
@property (nonatomic, strong) MCCallLogsBackupSecondPartCell *secondCell;
@end

@implementation MCCallLogsBackupSecondPartView

-(instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *mainView = [UIView new];
    mainView.backgroundColor = UIColor.whiteColor;
    mainView.layer.cornerRadius = 8;
    
    [self addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.bottom.offset(0);
    }];
    
    [mainView addSubview:self.firstCell];
    [self.firstCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(48);
    }];
    
    [mainView addSubview:self.secondCell];
    [self.secondCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(48);
    }];
}

-(MCCallLogsBackupSecondPartCell *)firstCell {
    if (!_firstCell) {
        _firstCell = [[MCCallLogsBackupSecondPartCell alloc] initWithLeftTitle:@"一键备份至云端" rightBtnTitle:@"开始备份"];
        __weak typeof(self) weakSelf = self;
        _firstCell.cellBlock = ^{
//            [TipProgress showText:@"开始备份"];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(startBackupAction)]) {
                [weakSelf.delegate startBackupAction];
            }
        };
    }
    return _firstCell;
}

-(MCCallLogsBackupSecondPartCell *)secondCell {
    if (!_secondCell) {
        _secondCell = [[MCCallLogsBackupSecondPartCell alloc] initWithLeftTitle:@"一键恢复至本地" rightBtnTitle:@"开始恢复"];
        __weak typeof(self) weakSelf = self;
        _secondCell.cellBlock = ^{
//            [TipProgress showText:@"开始恢复"];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(startRecoveryAction)]) {
                [weakSelf.delegate startRecoveryAction];
            }
        };
    }
    return _secondCell;
}

@end

@interface MCCallLogsBackupSecondPartCell()
@property (nonatomic, strong) NSString *leftTitle;
@property (nonatomic, strong) NSString *rightBtnTitle;
@end

@implementation MCCallLogsBackupSecondPartCell

-(instancetype)initWithLeftTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightBtnTitle {
    if (self = [super init]) {
        self.leftTitle = leftTitle;
        self.rightBtnTitle = rightBtnTitle;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UILabel *leftLabel = [UILabel new];
    leftLabel.text = self.leftTitle;
    leftLabel.font = [UIFont systemFontOfSize:16];
    leftLabel.textColor = DF_COLOR_0x(0x000A18);
    
    [self addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(16);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:self.rightBtnTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:DF_COLOR_0x(0x0065F2) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-16);
    }];
}

-(void)rightBtnAction:(UIButton *)sender {
    if (self.cellBlock) {
        self.cellBlock();
    }
}

@end
