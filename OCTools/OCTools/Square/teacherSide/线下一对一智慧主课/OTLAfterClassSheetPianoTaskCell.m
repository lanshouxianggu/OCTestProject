//
//  OTLAfterClassSheetPianoTaskCell.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLAfterClassSheetPianoTaskCell.h"

@interface OTLAfterClassSheetPianoTaskCell ()
@property (nonatomic, strong) UIView *topView;
///练琴时长view
@property (nonatomic, strong) OTLAfterClassSheetPianoTaskNormalView *practiceDurationView;
///练琴天数view
@property (nonatomic, strong) OTLAfterClassSheetPianoTaskNormalView *practiceDaysView;
@end

@implementation OTLAfterClassSheetPianoTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 9;
        
        [self setupUI];
        [self loadData];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.contentView addSubview:self.practiceDurationView];
    [self.practiceDurationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(38);
    }];
    
    [self.contentView addSubview:self.practiceDaysView];
    [self.practiceDaysView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.practiceDurationView.mas_bottom);
        make.height.mas_equalTo(38);
        make.bottom.offset(-10);
    }];
}

-(void)loadData {
    [self.practiceDurationView updateRightValue:@"30分钟"];
    [self.practiceDaysView updateRightValue:@"3天"];
}

#pragma mark - lazy
-(UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lianqinjilu"]];
        
        [_topView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
            make.width.height.mas_equalTo(28);
        }];
        
        UILabel *lab = [UILabel new];
        lab.text = @"练琴任务";
        lab.textColor = UIColorFromRGB(0x3b3b3b);
        lab.font = [UIFont systemFontOfSize:16];
        
        [_topView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(imageV.mas_right).offset(8);
        }];
    }
    return _topView;
}

-(OTLAfterClassSheetPianoTaskNormalView *)practiceDurationView {
    if (!_practiceDurationView) {
        _practiceDurationView = [[OTLAfterClassSheetPianoTaskNormalView alloc] initWithLeftTitle:@"每日练琴时长"];
    }
    return _practiceDurationView;
}

-(OTLAfterClassSheetPianoTaskNormalView *)practiceDaysView {
    if (!_practiceDaysView) {
        _practiceDaysView = [[OTLAfterClassSheetPianoTaskNormalView alloc] initWithLeftTitle:@"未来一周练琴天数"];
    }
    return _practiceDaysView;
}

@end

@interface OTLAfterClassSheetPianoTaskNormalView ()
@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation OTLAfterClassSheetPianoTaskNormalView

-(instancetype)initWithLeftTitle:(NSString *)leftTitle {
    if (self = [super init]) {
        [self setupUI];
        self.leftLabel.text = leftTitle;
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(15);
    }];
    
    [self addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-15);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(72);
    }];
    
    [self.rightView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
}

-(void)updateRightValue:(NSString *)value {
    self.rightLabel.text = value;
}

#pragma mark - lazy
-(UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.textColor = UIColorFromRGB(0x999999);
        _leftLabel.font = [UIFont systemFontOfSize:12];
    }
    return _leftLabel;
}

-(UIView *)rightView {
    if (!_rightView) {
        _rightView = [UIView new];
        _rightView.layer.cornerRadius = 4;
        _rightView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        _rightView.layer.borderWidth = 1;
    }
    return _rightView;
}

-(UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.textColor = UIColorFromRGB(0x3b3b3b);
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightLabel;
}
@end
