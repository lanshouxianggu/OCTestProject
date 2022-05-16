//
//  MCCommonSearchNavView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/9/21.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCommonSearchNavView.h"

@interface MCCommonSearchNavView () <UITextFieldDelegate>
@property (nonatomic, strong) UIButton *cancelBtn;
@end

@implementation MCCommonSearchNavView

-(instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        [self setupUI];
        [self.textField becomeFirstResponder];
    }
    return self;
}

-(void)setupUI {
    UIView *mainView = [UIView new];
    mainView.backgroundColor = UIColor.whiteColor;
    
    [self addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [mainView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-15);
    }];
    
    UIView *searchView = [UIView new];
    searchView.backgroundColor = DF_COLOR_BGMAIN;
    searchView.layer.cornerRadius = 20;
    
    [mainView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.height.mas_equalTo(40);
        make.left.offset(15);
        make.right.equalTo(self.cancelBtn.mas_left).offset(-15);
    }];
    
    {
        UIImageView *searchImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
        [searchView addSubview:searchImageV];
        [searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        UITextField *textField = [UITextField new];
        textField.placeholder = @"搜索共享群、群成员、群文件";
        textField.font = [UIFont systemFontOfSize:15];
        textField.returnKeyType = UIReturnKeySearch;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.textField = textField;
        self.textField.delegate = self;
        
        [searchView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(searchImageV.mas_right).offset(15);
            make.right.offset(-15);
        }];
    };
}

-(UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(void)cancelAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCancel)]) {
        [self.delegate didClickCancel];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.superview endEditing:YES];
    if (textField.text.length == 0) {
        return NO;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSearch:)]) {
        [self.delegate didSearch:textField.text];
    }
    return YES;
}

-(void)textDidChange:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSearch:)]) {
        [self.delegate didSearch:textField.text];
    }
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchContentDidClear)]) {
        [self.delegate searchContentDidClear];
    }
    return YES;
}


@end
