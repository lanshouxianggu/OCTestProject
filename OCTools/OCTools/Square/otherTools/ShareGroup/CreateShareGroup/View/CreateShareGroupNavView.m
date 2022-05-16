//
//  CreateShareGroupNavView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "CreateShareGroupNavView.h"

@implementation CreateShareGroupNavView

-(instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *sv = [UIView new];
    [self addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"新建共享群";
    titleLabel.textColor = UIColor.darkTextColor;
    titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    
    [sv addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    
    [sv addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(20);
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    
    [sv addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-20);
    }];
}

-(void)cancelAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navViewCancelAction)]) {
        [self.delegate navViewCancelAction];
    }
}

-(void)saveAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navViewSaveAction)]) {
        [self.delegate navViewSaveAction];
    }
}

@end
