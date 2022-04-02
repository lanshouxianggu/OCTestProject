//
//  OTLWeekReportDetailTableViewCell.m
//  TeacherSide
//
//  Created by stray s on 2022/3/2.
//  Copyright © 2022 YueHe. All rights reserved.
//

#import "OTLWeekReportDetailTableViewCell.h"

@interface OTLWeekReportDetailTableViewCell ()
@property (nonatomic, strong) NSArray *tasksList;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, assign) BOOL hasDraw;
@end

@implementation OTLWeekReportDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        self.hasDraw = NO;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *mainV = [UIView new];
    mainV.backgroundColor = UIColor.whiteColor;
    mainV.layer.cornerRadius = 8;
    self.mainView = mainV;
    
    [self.contentView addSubview:mainV];
    [mainV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-10);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    [mainV addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.left.top.offset(15);
    }];
    
    [mainV addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.mas_right).offset(12);
    }];
}

-(void)updateWithDataDic:(NSDictionary *)dic {
    if (dic && !self.hasDraw) {
        self.nameLabel.text = dic[@"name"]?:@"";
        self.tasksList = dic[@"tasks"];
        NSLog(@"开始绘制");
        OTLWeekReportPracticeDetailInfoView *tempInfoView = nil;
        for (int i = 0; i<self.tasksList.count; i++) {
            OTLWeekReportPracticeDetailInfoView *detailInfoView = [[OTLWeekReportPracticeDetailInfoView alloc] initWithFrame:CGRectZero hasPractice:self.hasPractice];
            NSDictionary *dic = self.tasksList[i];
            [detailInfoView updateWithDataDic:dic];
            
            [self.mainView addSubview:detailInfoView];
            [detailInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(10);
                make.right.offset(-10);
                if (i==0) {
                    make.top.equalTo(self.headImageView.mas_bottom).offset(15);
                }else {
                    make.top.equalTo(tempInfoView.mas_bottom).offset(8);
                }
                if (i==self.tasksList.count-1) {
                    make.bottom.offset(-20);
                }
                make.height.mas_greaterThanOrEqualTo(30);
//                if (self.hasPractice) {
//                    make.height.mas_equalTo(40+30*2);
//                }else {
//                    make.height.mas_equalTo(40);
//                }
            }];
            tempInfoView = detailInfoView;
        }
        self.hasDraw = YES;
    }
}

#pragma mark - lazy
-(UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _headImageView.layer.cornerRadius = 25;
    }
    return _headImageView;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = UIColor.darkTextColor;
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}
@end

@interface OTLWeekReportPracticeDetailInfoView ()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *hasCompleteLabel;
@property (nonatomic, assign) BOOL hasPractice;

@property (nonatomic, strong) OTLWeekReportPracticeDetailInfoSubView *daysView;//练琴天数
@property (nonatomic, strong) OTLWeekReportPracticeDetailInfoSubView *durationView;//练琴时长

@property (nonatomic, strong) OTLWeekReportPracticeDetailInfoSubView *testView;
@end

@implementation OTLWeekReportPracticeDetailInfoView

-(instancetype)initWithFrame:(CGRect)frame hasPractice:(BOOL)hasPractice {
    if (self = [super initWithFrame:frame]) {
        self.hasPractice = hasPractice;
        self.backgroundColor = UIColorFromRGB(0xf2f2f2);
        self.layer.cornerRadius = 8;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        if (!self.hasPractice) {
            make.bottom.offset(-10);
        }
    }];
    
    [self addSubview:self.hasCompleteLabel];
    [self.hasCompleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(10);
    }];
    
    if (self.hasPractice) {
        [self addSubview:self.daysView];
        [self.daysView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(30);
        }];
        
        [self addSubview:self.durationView];
        [self.durationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(self.daysView.mas_bottom);
            make.height.mas_equalTo(30);
            make.bottom.offset(-10);
        }];
        
//        [self addSubview:self.testView];
//        [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.offset(0);
//            make.top.equalTo(self.durationView.mas_bottom);
//            make.height.mas_equalTo(30);
//            make.bottom.offset(-10);
//        }];
    }
}

-(void)updateWithDataDic:(NSDictionary *)dic {
    if (dic) {
        self.dateLabel.text = dic[@"date"]?:@"";
        if (self.hasPractice) {
            BOOL hasComplete = [dic[@"hasDone"] boolValue];
            self.hasCompleteLabel.text = hasComplete?@"已完成":@"未完成";
            self.hasCompleteLabel.textColor = hasComplete?OTLAppMainColor:UIColorFromRGB(0x666666);
        }else {
            self.hasCompleteLabel.text = @"60分钟/天";
            self.hasCompleteLabel.textColor = UIColor.darkTextColor;
        }
        [self.daysView updateWithDataDic:dic];
        [self.durationView updateWithDataDic:dic];
    }
}

#pragma mark - lazy
-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = UIColor.darkTextColor;
        _dateLabel.font = [UIFont systemFontOfSize:15];
    }
    return _dateLabel;
}

-(UILabel *)hasCompleteLabel {
    if (!_hasCompleteLabel) {
        _hasCompleteLabel = [UILabel new];
        _hasCompleteLabel.textColor = UIColor.darkTextColor;
        _hasCompleteLabel.font = [UIFont systemFontOfSize:15];
    }
    return _hasCompleteLabel;
}

-(OTLWeekReportPracticeDetailInfoSubView *)daysView {
    if (!_daysView) {
        _daysView = [[OTLWeekReportPracticeDetailInfoSubView alloc] initWithFrame:CGRectZero type:PracticeTypeDays];
    }
    return _daysView;
}

-(OTLWeekReportPracticeDetailInfoSubView *)durationView {
    if (!_durationView) {
        _durationView = [[OTLWeekReportPracticeDetailInfoSubView alloc] initWithFrame:CGRectZero type:PracticeTypeDuration];
    }
    return _durationView;
}
-(OTLWeekReportPracticeDetailInfoSubView *)testView {
    if (!_testView) {
        _testView = [[OTLWeekReportPracticeDetailInfoSubView alloc] initWithFrame:CGRectZero type:PracticeTypeDays];
    }
    return _testView;
}
@end

@interface OTLWeekReportPracticeDetailInfoSubView ()
@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UILabel *rightLab;
@property (nonatomic, assign) PracticeType type;
@end

@implementation OTLWeekReportPracticeDetailInfoSubView

-(instancetype)initWithFrame:(CGRect)frame type:(PracticeType)type{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        [self setupUI];
        if (self.type==PracticeTypeDays) {
            self.leftLab.text = @"练琴天数";
        }else if (self.type==PracticeTypeDuration) {
            self.leftLab.text = @"练琴时长";
        }
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.offset(0);
    }];
    
    [self addSubview:self.rightLab];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.offset(0);
    }];
}

-(void)updateWithDataDic:(NSDictionary *)dic {
    NSString *days = dic[@"days"]?:@"";
    NSString *totalDays = dic[@"totalDays"]?:@"";
    NSString *time = dic[@"time"]?:@"";
    NSString *totalTime = dic[@"totalTime"]?:@"";
    
    if (self.type==PracticeTypeDays) {
        self.rightLab.text = [NSString stringWithFormat:@"%@/%@ 天",days,totalDays];
    }else if (self.type==PracticeTypeDuration) {
        self.rightLab.text = [NSString stringWithFormat:@"%@/%@ 小时",time,totalTime];
    }
}

#pragma mark - lazy
-(UILabel *)leftLab {
    if (!_leftLab) {
        _leftLab = [UILabel new];
        _leftLab.textColor = UIColorFromRGB(0x666666);
        _leftLab.font = [UIFont systemFontOfSize:12];
    }
    return _leftLab;
}

-(UILabel *)rightLab {
    if (!_rightLab) {
        _rightLab = [UILabel new];
        _rightLab.textColor = UIColorFromRGB(0x666666);;
        _rightLab.font = [UIFont systemFontOfSize:12];
    }
    return _rightLab;
}
@end
