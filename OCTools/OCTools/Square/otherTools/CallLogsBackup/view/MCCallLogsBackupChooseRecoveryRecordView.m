//
//  MCCallLogsBackupChooseRecoveryRecordView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/10/20.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCallLogsBackupChooseRecoveryRecordView.h"
#import "MCCallLogsBackupRecoveryRecordModel.h"
#import "MCCallLogsBackupRecoveryRecordCell.h"

@interface MCCallLogsBackupChooseRecoveryRecordView () <UITableViewDelegate,UITableViewDataSource,MCCallLogsBackupRecoveryRecordCellDelegate,MCCallLogsBackupChooseRecoveryStyleViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) MCCallLogsBackupChooseRecoveryStyleView *chooseRecoveryStyleView;
@end

@implementation MCCallLogsBackupChooseRecoveryRecordView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        [self setupUI];
        [self initData];
    }
    return self;
}

-(void)initData {
    NSArray *tempArray = @[@{@"device":@"iPhone 6s",@"date":@"2020/08/20 14:25",@"count":@"18"},
    @{@"device":@"一加8 plus",@"date":@"2020/08/10 14:25",@"count":@"78"},
    @{@"device":@"iPhone X",@"date":@"2020/08/20 14:25",@"count":@"95"},
    @{@"device":@"红米Note8 pro",@"date":@"2020/08/20 14:25",@"count":@"65"}];
    
    for (NSDictionary *dic in tempArray) {
        MCCallLogsBackupRecoveryRecordModel *model = [MCCallLogsBackupRecoveryRecordModel new];
        model.backupDevice = [dic valueForKey:@"device"];
        model.backupDate = [dic valueForKey:@"date"];
        model.backupCount = [[dic valueForKey:@"count"] integerValue];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

-(void)setupUI {
    UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchBtn addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:touchBtn];
    touchBtn.frame = self.bounds;
    
    UIView *mainView = [UIView new];
    mainView.backgroundColor = DF_COLOR_BGMAIN;
    mainView.layer.cornerRadius = 16;
    [self addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(16);
        make.height.mas_equalTo(404);
    }];
    
    ({
        UILabel *titleLab = [UILabel new];
        titleLab.text = @"选择恢复记录";
        titleLab.textColor = DF_COLOR_0x(0x000A18);
        titleLab.font = [UIFont systemFontOfSize:16];
        self.titleLabel = titleLab;
        
        [mainView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(24);
        }];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:DF_COLOR_0x_alpha(0x000A18, 0.5) forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        cancelBtn.backgroundColor = UIColor.whiteColor;
        cancelBtn.layer.cornerRadius = 8;
        cancelBtn.layer.masksToBounds = YES;
        [cancelBtn addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
        
        [mainView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16);
            make.right.offset(-16);
            make.height.mas_equalTo(44);
            make.bottomMargin.offset(-32);
        }];
        
        [mainView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(titleLab.mas_bottom).offset(20);
            make.bottom.equalTo(cancelBtn.mas_top).offset(-15);
        }];
        
        [mainView addSubview:self.chooseRecoveryStyleView];
        [self.chooseRecoveryStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.tableView);
        }];
    });
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = DF_COLOR_BGMAIN;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        [_tableView registerClass:MCCallLogsBackupRecoveryRecordCell.class forCellReuseIdentifier:@"MCCallLogsBackupRecoveryRecordCell"];
    }
    return _tableView;
}

-(MCCallLogsBackupChooseRecoveryStyleView *)chooseRecoveryStyleView {
    if (!_chooseRecoveryStyleView) {
        _chooseRecoveryStyleView = [[MCCallLogsBackupChooseRecoveryStyleView alloc] initWithFrame:CGRectZero];
        _chooseRecoveryStyleView.hidden = YES;
        _chooseRecoveryStyleView.delegate = self;
    }
    return _chooseRecoveryStyleView;
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCCallLogsBackupRecoveryRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCCallLogsBackupRecoveryRecordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[MCCallLogsBackupRecoveryRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MCCallLogsBackupRecoveryRecordCell"];
    }
    MCCallLogsBackupRecoveryRecordModel *model = self.dataArray[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    [cell updateCellWithModel:model];
    return cell;
}

#pragma mark - MCCallLogsBackupRecoveryRecordCellDelegate
-(void)recoevryActionWithIndexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = @"选择恢复方式";
    self.chooseRecoveryStyleView.hidden = NO;
    self.tableView.hidden = YES;
    MCCallLogsBackupRecoveryRecordModel *model = self.dataArray[indexPath.row];
    self.chooseRecoveryStyleView.model = model;
}

#pragma mark - MCCallLogsBackupChooseRecoveryStyleViewDelegate
-(void)reChooseAction {
    self.titleLabel.text = @"选择恢复记录";
    self.chooseRecoveryStyleView.hidden = YES;
    self.tableView.hidden = NO;
}

-(void)startRecoveryWithStyle:(RecoveryStyle)style {
    if (self.delegate && [self.delegate respondsToSelector:@selector(startRecoveryWithStyle:)]) {
        [self.delegate startRecoveryWithStyle:style];
    }
    [self touchAction];
}

#pragma mark - 空白处点击事件
-(void)touchAction {
    self.backgroundColor = UIColor.clearColor;
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        self.tableView.hidden = NO;
        self.chooseRecoveryStyleView.hidden = YES;
    }];
}
@end
