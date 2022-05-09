//
//  OTLAfterClassSheetVideoCollectionCell.m
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import "OTLAfterClassSheetVideoCollectionCell.h"

@interface OTLAfterClassSheetVideoCollectionCell ()
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *videoNameLabel;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIImageView *playImageView;
@property (nonatomic, strong) UIView *midiView;
@end

@implementation OTLAfterClassSheetVideoCollectionCell
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *topView = [UIView new];
    topView.backgroundColor = UIColor.whiteColor;
    topView.layer.cornerRadius = 9;
    topView.layer.masksToBounds = YES;
    
    [self addSubviewInTopView:topView];
    
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(160);
    }];
    
    [self.contentView addSubview:self.videoNameLabel];
    [self.videoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(topView.mas_bottom).offset(10);
    }];
}

-(void)addSubviewInTopView:(UIView *)topView {
    [topView addSubview:self.videoImageView];
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [topView addSubview:self.playImageView];
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.height.mas_equalTo(48);
    }];
    
    [topView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.top.right.offset(0);
    }];
    
    [topView addSubview:self.midiView];
    [self.midiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
        make.right.offset(-6);
        make.bottom.offset(-8);
    }];
}

#pragma mark - 删除
-(void)deleteAction {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

#pragma mark - lazy
-(UIImageView *)videoImageView {
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.backgroundColor = UIColor.cyanColor;
    }
    return _videoImageView;
}

-(UIImageView *)playImageView {
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_star_slight"]];
    }
    return _playImageView;
}

-(UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"icon_star_slight"] forState:UIControlStateNormal];
        
        [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

-(UILabel *)videoNameLabel {
    if (!_videoNameLabel) {
        _videoNameLabel = [UILabel new];
        _videoNameLabel.text = @"卡卡真神气";
        _videoNameLabel.textColor = UIColorFromRGB(0x999999);
        _videoNameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _videoNameLabel;
}

-(UIView *)midiView {
    if (!_midiView) {
        _midiView = [UIView new];
        _midiView.backgroundColor = OTLAppMainColor;
        _midiView.layer.cornerRadius = 4;
        UILabel *tipsLab = [UILabel new];
        tipsLab.text = @"MIDI";
        tipsLab.textColor = UIColor.whiteColor;
        tipsLab.font = [UIFont systemFontOfSize:12];
        tipsLab.textAlignment = NSTextAlignmentCenter;
        [_midiView addSubview:tipsLab];
        [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
    }
    return _midiView;
}
@end
