//
//  ShareGroupDetailInfoHeadSegementView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ShareGroupDetailInfoHeadSegementView.h"

@interface ShareGroupDetailInfoHeadSegementView()
@property (nonatomic, strong) UIButton *momentBtn;
@property (nonatomic, strong) UIButton *fileBtn;
@property (nonatomic, strong) UILabel *momentLabel;
@property (nonatomic, strong) UILabel *fileLabel;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) NSArray *childVcsArray;
@end

@implementation ShareGroupDetailInfoHeadSegementView

-(instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.momentBtn];
    [self.momentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.bottom.offset(-5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    [self addSubview:self.fileBtn];
    [self.fileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.offset(0);
        make.bottom.offset(-5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.momentBtn);
        make.bottom.offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 4));
    }];
}

-(UIButton *)momentBtn {
    if (!_momentBtn) {
        _momentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_momentBtn setTitle:@"共享动态" forState:UIControlStateNormal];
        [_momentBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
//        [_momentBtn setTitleColor:UIColor.blueColor forState:UIControlStateSelected];
        _momentBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        _momentBtn.selected = YES;
        [_momentBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _momentBtn;
}

-(UIButton *)fileBtn {
    if (!_fileBtn) {
        _fileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fileBtn setTitle:@"群组文件" forState:UIControlStateNormal];
        [_fileBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
//        [_fileBtn setTitleColor:UIColor.blueColor forState:UIControlStateSelected];
        _fileBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _fileBtn.selected = NO;
        [_fileBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fileBtn;
}

-(UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColor.blueColor;
        _bottomLine.layer.cornerRadius = 2;
    }
    return _bottomLine;
}

#pragma mark - action
-(void)selectBtnAction:(UIButton *)sender {
    if ([sender isEqual:self.momentBtn]) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(headViewSelectAtIndex:)]) {
            [self.delegate headViewSelectAtIndex:0];
        }
        [self animationToIndex:0 animation:NO];
        return;
    }
    if ([sender isEqual:self.fileBtn]) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(headViewSelectAtIndex:)]) {
            [self.delegate headViewSelectAtIndex:1];
        }
        [self animationToIndex:1 animation:NO];
        return;
    }
}

-(void)selectAtIndex:(int)index {
    [self animationToIndex:index animation:YES];
}

-(void)animationToIndex:(int)index animation:(BOOL)animation{
    if (index==0) {
        if (self.momentBtn.isSelected) {
            return;
        }
        self.momentBtn.selected = YES;
        self.fileBtn.selected = NO;
        self.momentBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        [self.momentBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [self.fileBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        self.fileBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        if (animation) {
            [UIView animateWithDuration:0.35 animations:^{
                self.bottomLine.transform = CGAffineTransformIdentity;
            }];
        }else {
            self.bottomLine.transform = CGAffineTransformIdentity;
        }
        
    }else if (index==1) {
        if (self.fileBtn.isSelected) {
            return;
        }
        self.fileBtn.selected = YES;
        self.momentBtn.selected = NO;
        self.fileBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        [self.fileBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [self.momentBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        self.momentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        if (animation) {
            [UIView animateWithDuration:0.35 animations:^{
                self.bottomLine.transform = CGAffineTransformMakeTranslation(self.fileBtn.frame.origin.x-self.momentBtn.frame.origin.x, 0);
            }];
        }else {
            self.bottomLine.transform = CGAffineTransformMakeTranslation(self.fileBtn.frame.origin.x-self.momentBtn.frame.origin.x, 0);
        }
    }
}

@end
