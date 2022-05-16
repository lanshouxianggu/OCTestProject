//
//  MCCommonSearchTitleCell.m
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCommonSearchTitleCell.h"

@implementation MCCommonSearchTitleCell
//- (instancetype)init{
//    abort();
//}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
//        self.contentView.layer.cornerRadius = 20;
//        self.contentView.layer.masksToBounds = YES;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    
    _setView = [UIView new];
    _setView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_setView];
    [_setView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = UIColor.darkGrayColor;
    _titleLabel.backgroundColor = DF_COLOR_BGMAIN;
    _titleLabel.layer.cornerRadius = 20;
    _titleLabel.layer.masksToBounds = YES;
    [_setView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_setView);
        make.centerY.equalTo(_setView);
        make.width.equalTo(self);
        make.height.mas_offset(40);
    }];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(5);
        make.top.offset(-5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

-(void)deleteAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickDeleteAtIndexPath:)]) {
        [self.delegate didClickDeleteAtIndexPath:self.indexPath];
    }
}
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wimplicit-retain-self"
//- (void)updateConstraints{
//
//    [_setView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.contentView);
//    }];
//
//    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_setView);
//        make.centerY.equalTo(_setView);
//        make.width.equalTo(self);
//        make.height.mas_offset(40);
//    }];
//
//    [super updateConstraints];
//}
//#pragma clang diagnostic pop

//- (void)didMoveToSuperview{
//    [self setNeedsUpdateConstraints];
//}
@end
