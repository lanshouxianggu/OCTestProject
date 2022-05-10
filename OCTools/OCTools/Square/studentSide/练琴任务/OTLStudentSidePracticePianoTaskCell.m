//
//  OTLStudentSidePracticePianoTaskCell.m
//  OCTools
//
//  Created by stray s on 2022/5/10.
//

#import "OTLStudentSidePracticePianoTaskCell.h"
#import "OTLStudentSidePracticePianoTaskMainView.h"

static const CGFloat sTopViewHeight = 56.f;

@interface OTLStudentSidePracticePianoTaskCell ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation OTLStudentSidePracticePianoTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(sTopViewHeight);
    }];
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.offset(-10);
        make.height.mas_greaterThanOrEqualTo(190);
    }];
}

-(void)setModel:(OTLStudentSidePracticePianoTaskModel *)model {
    _model = model;
    self.dateLabel.text = model.taskDateTime;
    self.rightLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
        make.text([NSString stringWithFormat:@"%.1f",model.totalAlreadyTime]).foregroundColor(UIColorFromRGB(0x3b3b3b)).font([UIFont systemFontOfSize:20 weight:UIFontWeightBold]);
        make.text([NSString stringWithFormat:@"/%.1f小时",model.totalNeedTime]).foregroundColor(UIColorFromRGB(0x999999)).font([UIFont systemFontOfSize:12]);
    }];
    for (UIView *subView in self.bottomView.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat mainViewWidth = (SCREEN_WIDTH-15*3)/2;
    for (int i=0; i<model.listModel.count; i++) {
        OTLStudentSidePracticePianoTaskMainView *mainView = [OTLStudentSidePracticePianoTaskMainView customerView];
        [mainView initData];
        
        UIView *shadowView = [UIView new];
        shadowView.layer.shadowColor = UIColor.blackColor.CGColor;
        shadowView.layer.shadowOpacity = 0.3;
        shadowView.layer.shadowOffset = CGSizeMake(2, 2);
        shadowView.layer.shadowRadius = 9;
        
        [self.bottomView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i%2==0) {
                make.left.offset(15);
            }else {
                make.left.offset(15+mainViewWidth+15);
            }
            make.top.offset(i/2*(174+15));
            make.height.mas_equalTo(174);
            make.width.mas_equalTo(mainViewWidth);
            if (model.listModel.count%2==0) {
                if (i==model.listModel.count-1||i==model.listModel.count-2) {
                    make.bottom.offset(-15);
                }
            }else {
                if (i==model.listModel.count-1) {
                    make.bottom.offset(-15);
                }
            }
        }];
        
        [shadowView addSubview:mainView];
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        
        mainView.listModel = model.listModel[i];
    }
}

#pragma mark - lazy
-(UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = UIColor.whiteColor;
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_calendar_task"]];
        [_topView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
            make.width.height.mas_equalTo(20);
        }];
        
        [_topView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(imageV.mas_right).offset(5);
            make.right.offset(-150);
        }];
        
        [_topView addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.right.offset(-15);
        }];
    }
    return _topView;
}

-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = UIColor.whiteColor;
    }
    return _bottomView;
}

-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.text = @"10.11-10.17";
        _dateLabel.textColor = UIColorFromRGB(0x3b3b3b);
        _dateLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    }
    return _dateLabel;
}

-(UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.text = @"0/3.5小时";
        _rightLabel.textColor = UIColorFromRGB(0x3b3b3b);
        _rightLabel.font = [UIFont systemFontOfSize:12];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _rightLabel;
}
@end
