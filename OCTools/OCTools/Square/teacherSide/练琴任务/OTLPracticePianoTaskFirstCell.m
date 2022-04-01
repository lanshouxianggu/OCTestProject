//
//  OTLPracticePianoTaskFirstCell.m
//  ChatClub
//
//  Created by stray s on 2022/3/31.
//  Copyright © 2022 ArcherMind. All rights reserved.
//

#import "OTLPracticePianoTaskFirstCell.h"
#import "OTLPracticePianoCommonCellView.h"

@interface OTLPracticePianoTaskFirstCell ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) OTLPracticePianoCommonCellView *speedView;
@property (nonatomic, strong) OTLPracticePianoCommonCellView *decompositionView;
@property (nonatomic, strong) OTLPracticePianoCommonCellView *allPracticeView;
@property (nonatomic, strong) OTLPracticePianoCommonCellView *intelligentView;

///是否选中速度要求
@property (nonatomic, assign) BOOL isSelectSpeed;
///是否选中分解练习
@property (nonatomic, assign) BOOL isSelectDecomposition;
///是否选中全曲练习
@property (nonatomic, assign) BOOL isSelectAllPractice;
///是否选中智能测评
@property (nonatomic, assign) BOOL isSelectIntelligent;
@end

@implementation OTLPracticePianoTaskFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *mainView = [UIView new];
    mainView.backgroundColor = UIColor.whiteColor;
    mainView.backgroundColor = UIColor.whiteColor;
    mainView.layer.cornerRadius = 10;
    mainView.layer.masksToBounds = YES;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    [self.contentView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.bottom.offset(0);
    }];
    
    [mainView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(131);
    }];
    
    [mainView addSubview:self.decompositionView];
    [self.decompositionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(56);
        make.top.equalTo(self.topView.mas_bottom).offset(15);
    }];
    
    [mainView addSubview:self.allPracticeView];
    [self.allPracticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(56);
        make.top.equalTo(self.decompositionView.mas_bottom).offset(15);
    }];
    
    [mainView addSubview:self.intelligentView];
    [self.intelligentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(56);
        make.top.equalTo(self.allPracticeView.mas_bottom).offset(15);
        make.bottom.offset(-15);
    }];
}


#pragma mark - lazy
-(UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = UIColor.whiteColor;
        
        UILabel *lab1 = [UILabel new];
        lab1.text = @"练琴任务";
        lab1.textColor = UIColorFromRGB(0x3b3b3b);
        lab1.font = [UIFont systemFontOfSize:16];
        
        [_topView addSubview:lab1];
        [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(18);
        }];
        
        UILabel *lab2 = [UILabel new];
        lab2.text = @"(请按照1天的任务，进行布置)";
        lab2.textColor = UIColorFromRGB(0x999999);
        lab2.font = [UIFont systemFontOfSize:12];
        
        [_topView addSubview:lab2];
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lab1);
            make.left.equalTo(lab1.mas_right).offset(10);
        }];
        
        [_topView addSubview:self.speedView];
        [self.speedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-15);
            make.top.equalTo(lab1.mas_bottom).offset(20);
            make.height.mas_equalTo(56);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xe5e5e5);
        
        [_topView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(0);
            make.height.mas_equalTo(0.5);
            make.left.offset(15);
            make.right.offset(-15);
        }];
    }
    return _topView;
}

-(OTLPracticePianoCommonCellView *)speedView {
    if (!_speedView) {
        _speedView = [[OTLPracticePianoCommonCellView alloc] initWithFrame:CGRectZero canExpand:NO btnTitle:@"速度要求" taskType:PracticePianoTaskTypeSpeed];
        _speedView.backgroundColor = UIColor.whiteColor;
    }
    return _speedView;
}

-(OTLPracticePianoCommonCellView *)decompositionView {
    if (!_decompositionView) {
        _decompositionView = [[OTLPracticePianoCommonCellView alloc] initWithFrame:CGRectZero canExpand:YES btnTitle:@"分解练习" taskType:PracticePianoTaskTypeDecompostion];
        WS(weakSelf)
        [_decompositionView setSelectActionBlock:^(BOOL isSelect) {
            weakSelf.isSelectDecomposition = isSelect;
            [weakSelf.decompositionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(isSelect?151:56);
            }];
            if (weakSelf.updateConstraintBlock) {
                weakSelf.updateConstraintBlock(weakSelf.isSelectDecomposition, weakSelf.isSelectAllPractice, weakSelf.isSelectIntelligent);
            }
        }];
    }
    return _decompositionView;
}

-(OTLPracticePianoCommonCellView *)allPracticeView {
    if (!_allPracticeView) {
        _allPracticeView = [[OTLPracticePianoCommonCellView alloc] initWithFrame:CGRectZero canExpand:YES btnTitle:@"全曲练习" taskType:PracticePianoTaskTypeWhole];
        
        WS(weakSelf)
        [_allPracticeView setSelectActionBlock:^(BOOL isSelect) {
            weakSelf.isSelectAllPractice = isSelect;
            [weakSelf.allPracticeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(isSelect?151:56);
            }];
            if (weakSelf.updateConstraintBlock) {
                weakSelf.updateConstraintBlock(weakSelf.isSelectDecomposition, weakSelf.isSelectAllPractice, weakSelf.isSelectIntelligent);
            }
        }];
    }
    return _allPracticeView;
}

-(OTLPracticePianoCommonCellView *)intelligentView {
    if (!_intelligentView) {
        _intelligentView = [[OTLPracticePianoCommonCellView alloc] initWithFrame:CGRectZero canExpand:YES btnTitle:@"智能测评" taskType:PracticePianoTaskTypeIntelligent];
        
        WS(weakSelf)
        [_intelligentView setSelectActionBlock:^(BOOL isSelect) {
            weakSelf.isSelectIntelligent = isSelect;
            [weakSelf.intelligentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(isSelect?151:56);
            }];
            if (weakSelf.updateConstraintBlock) {
                weakSelf.updateConstraintBlock(weakSelf.isSelectDecomposition, weakSelf.isSelectAllPractice, weakSelf.isSelectIntelligent);
            }
        }];
    }
    return _intelligentView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
