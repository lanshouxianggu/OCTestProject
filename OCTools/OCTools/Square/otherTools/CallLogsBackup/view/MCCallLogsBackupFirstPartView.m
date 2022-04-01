//
//  MCCallLogsBackupFirstPartView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/10/20.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCallLogsBackupFirstPartView.h"

static const CGFloat kRecordCellHeight = 25;

@interface MCCallLogsBackupFirstPartView() <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *backupDisplayView;
@property (nonatomic, strong) UIView *backupToastView;
@property (nonatomic, strong) UILabel *phoneNameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *toastLabel;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UISlider *sliderView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *recordArray;
@end

static const CGFloat kBackupDisplayWidth = 158;

@implementation MCCallLogsBackupFirstPartView

-(instancetype)init {
    if (self = [super init]) {
        self.startAngle = -M_PI_2;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.backupDisplayView];
    [self.backupDisplayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.height.mas_equalTo(kBackupDisplayWidth);
        make.top.offset(40);
    }];
    
    [self addSubview:self.backupToastView];
    [self.backupToastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.backupDisplayView);
        make.width.height.mas_equalTo(130);
    }];
    
    ({
        [self.backupToastView addSubview:self.toastLabel];
        [self.toastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.left.offset(24);
        }];
    });
    
    [self addSubview:self.phoneNameLabel];
    [self.phoneNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.backupDisplayView.mas_bottom).offset(30).priority(MASLayoutPriorityDefaultHigh);
    }];
    
    [self addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.phoneNameLabel.mas_bottom).offset(10);
//        make.left.offset(50);
//        make.centerX.offset(0);
//        make.height.mas_greaterThanOrEqualTo(20);
//        make.bottom.offset(-16);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(self.descLabel.mas_bottom).offset(10);
        make.bottom.offset(-10);
        make.height.mas_equalTo(0);
    }];
    
//    [self addSubview:self.sliderView];
//    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.offset(0);
//        make.bottom.offset(-10);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(20);
//    }];
}

#pragma mark - lazyload
-(UIView *)backupDisplayView {
    if (!_backupDisplayView) {
        _backupDisplayView = [UIView new];
        _backupDisplayView.backgroundColor = DF_COLOR_0x(0xE6F0FE);
        _backupDisplayView.layer.cornerRadius = kBackupDisplayWidth/2;
        
        [_backupDisplayView.layer addSublayer:self.shapeLayer];
    }
    return _backupDisplayView;
}

-(CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer new];
//        _shapeLayer.strokeColor = DF_COLOR_0x(0x0065F2).CGColor;
        _shapeLayer.fillColor = DF_COLOR_0x(0x0065F2).CGColor;
        _shapeLayer.lineWidth = 10;
    }
    return _shapeLayer;
}

-(UIView *)backupToastView {
    if (!_backupToastView) {
        _backupToastView = [UIView new];
        _backupToastView.backgroundColor = UIColor.whiteColor;
        _backupToastView.layer.cornerRadius = 130/2;
    }
    return _backupToastView;
}

-(UILabel *)phoneNameLabel {
    if (!_phoneNameLabel) {
        _phoneNameLabel = [UILabel new];
        _phoneNameLabel.text = @"本机名称：iPhoneX Max";
        _phoneNameLabel.textAlignment = NSTextAlignmentCenter;
        _phoneNameLabel.textColor = UIColor.darkTextColor;
        _phoneNameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    }
    return _phoneNameLabel;
}

-(UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.text = @"通话记录存于云端，安全永不丢失";
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.textColor = UIColor.darkGrayColor;
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.numberOfLines = 0;
        _descLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descLabel;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = DF_COLOR_BGMAIN;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kRecordCellHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:MCCallLogsBackupFirstPartRecordCell.class forCellReuseIdentifier:@"MCCallLogsBackupFirstPartRecordCell"];
    }
    return _tableView;
}

-(UILabel *)toastLabel {
    if (!_toastLabel) {
        _toastLabel = [UILabel new];
        _toastLabel.text = @"通话记录\n还未备份过";
        _toastLabel.textAlignment = NSTextAlignmentCenter;
        _toastLabel.numberOfLines = 0;
        _toastLabel.textColor = DF_COLOR_0x(0x000A18);
        _toastLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    }
    return _toastLabel;
}

-(UISlider *)sliderView {
    if (!_sliderView) {
        _sliderView = [UISlider new];
        _sliderView.value = 0;
        _sliderView.minimumValue = 0;
        _sliderView.maximumValue = 1;
        [_sliderView addTarget:self action:@selector(progressUpdateAction) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderView;
}

-(NSMutableArray *)recordArray {
    if (!_recordArray) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

#pragma mark - 根据状态刷新UI

#pragma mark - 更新进度
-(void)progressUpdateAction {
    [self updateProgress:self.sliderView.value type:CallLogsTypeBackup];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recordArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCCallLogsBackupFirstPartRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCCallLogsBackupFirstPartRecordCell"];
    if (!cell) {
        cell = [[MCCallLogsBackupFirstPartRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MCCallLogsBackupFirstPartRecordCell"];
    }
    cell.recordLabel.text = self.recordArray[indexPath.row];
    
    return cell;
}

#pragma mark - 刷新tableView的高度
-(void)updateTableViewHeight {
    CGFloat height = kRecordCellHeight*self.recordArray.count;
    if (self.recordArray.count>=5) {
        height = kRecordCellHeight*5;
    }
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(self.descLabel.mas_bottom).offset(10);
        make.bottom.offset(-10);
        make.height.mas_equalTo(height);
    }];
}


#pragma mark - 开始恢复
-(void)startRecovery {
    if (!self.timer) {
        //调用此方法创建的timer会默认添加到当前线程的RunLoop中，模式为NSDefaultRunLoopMode，
        //但当前线程是主线程时，当scrollView或其子类进行滚动的时候，UIKIT会自动将当前RunLoop切换为UITrackingRunLoopMode
        //导致定时器停止运行
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(recoveryUpdateProgress) userInfo:nil repeats:YES];
        
        self.timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(recoveryUpdateProgress) userInfo:nil repeats:YES];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)recoveryUpdateProgress {
    static float i = 0.0;
    if (i >=1) {
        i = 0.0;
        [self.timer invalidate];
        self.timer = nil;
        self.toastLabel.text = @"恢复完成";
        self.descLabel.text = @"恢复完成";
        [self.recordArray addObject:@"99条通话记录恢复成功，时间：2020/09/07 12:12"];
//        [self.tableView reloadData];
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        NSArray *indexArray = [NSArray arrayWithObjects:path, nil];
        [self.tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
        [self updateTableViewHeight];
        return;
    }
    i+=0.005;
    [self updateProgress:i type:CallLogsTypeRecovery];
}

#pragma mark - 开始备份
-(void)startBackup {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(backupUpdateProgress) userInfo:nil repeats:YES];
    }
}

-(void)backupUpdateProgress {
    static float i = 0.0;
    if (i >= 1) {
        i = 0.0;
        [self.timer invalidate];
        self.timer = nil;
        self.toastLabel.text = @"备份完成";
        self.descLabel.text = @"备份完成";
        [self.recordArray addObject:@"99条通话记录备份成功，时间：2020/09/07 12:12"];
//        [self.tableView reloadData];
        [self updateTableViewHeight];
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        NSArray *indexArray = [NSArray arrayWithObjects:path, nil];
        [self.tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationRight];
        
        return;
    }
    i+=0.05;
    [self updateProgress:i type:CallLogsTypeBackup];
}

#pragma mark - 更新进度
-(void)updateProgress:(CGFloat)progress type:(CallLogsType)type{
    //圆心
//    CGPoint circlePoint = CGPointMake(self.backupDisplayView.center.x/2-24, self.backupDisplayView.center.y/2+19);
    CGPoint circlePoint = CGPointMake(kBackupDisplayWidth/2, kBackupDisplayWidth/2);
    //圆半径
    CGFloat circleR = kBackupDisplayWidth/2;

    //根据当前进度求出结束位置
    CGFloat endAngle = 0;
    endAngle = self.startAngle+progress*M_PI*2;
    
    //动画绘制扇形
    CGFloat bgRadius = circleR+5;
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:circlePoint radius:bgRadius startAngle:self.startAngle endAngle:endAngle clockwise:YES];
    
    [bgPath addLineToPoint:circlePoint];
    [[UIColor orangeColor] set];
    [bgPath fill];
    self.shapeLayer.path = bgPath.CGPath;
    
    if (type==CallLogsTypeBackup) {
        self.toastLabel.text = [NSString stringWithFormat:@"%.f%%\n备份中", progress*100];
        self.descLabel.text = @"正在备份通话记录...";
        if (progress==1) {
            self.toastLabel.text = @"备份完成";
            self.descLabel.text = @"99条通话记录备份成功，时间：2020/09/07 12:12";
        }
    }else if (type==CallLogsTypeRecovery) {
        self.toastLabel.text = [NSString stringWithFormat:@"%.f%%\n恢复中", progress*100];
        self.descLabel.text = @"正在恢复通话记录...";
        if (progress==1) {
            self.toastLabel.text = @"恢复完成";
            self.descLabel.text = @"99条通话记录恢复成功，时间：2020/09/07 12:12";
        }
    }
}

-(void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end


@implementation MCCallLogsBackupFirstPartRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = DF_COLOR_BGMAIN;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UILabel *lab = [UILabel new];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = UIColor.darkGrayColor;
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentCenter;
    self.recordLabel = lab;
    
    [self.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.left.top.offset(5);
    }];
}
@end
