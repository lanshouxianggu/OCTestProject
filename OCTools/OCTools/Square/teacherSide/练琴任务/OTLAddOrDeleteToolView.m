//
//  OTLAddOrDeleteToolView.m
//  ChatClub
//
//  Created by stray s on 2022/3/31.
//  Copyright © 2022 ArcherMind. All rights reserved.
//

#import "OTLAddOrDeleteToolView.h"

static const NSInteger sMaxSpeed = 120;
static const NSInteger sMinSpeed = 20;

@interface OTLAddOrDeleteToolView ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) int currentNum;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation OTLAddOrDeleteToolView

-(instancetype)initWithFrame:(CGRect)frame currentNum:(int)currentNum {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        self.currentNum = currentNum;
//        self.textField.text = [NSString stringWithFormat:@"%d",self.currentNum];
        self.textLabel.text = [NSString stringWithFormat:@"%d",self.currentNum];
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
//    [self addSubview:self.textField];
//    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.offset(0);
//        make.size.mas_equalTo(CGSizeMake(48, 28));
//    }];
    
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.size.mas_equalTo(CGSizeMake(48, 28));
    }];
    
    UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchBtn addTarget:self action:@selector(touchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:touchBtn];
    [touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.size.mas_equalTo(CGSizeMake(48, 28));
    }];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"－" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:UIColorFromRGB(0x3b3b3b) forState:UIControlStateNormal];
    [deleteBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateDisabled];
    [deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
    [deleteBtn setBackgroundColor:UIColor.whiteColor];
    deleteBtn.layer.cornerRadius = 4;
    [deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn = deleteBtn;
    
    [self addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(28, 28));
//        make.right.equalTo(self.textField.mas_left).offset(-4);
        make.right.equalTo(self.textLabel.mas_left).offset(-4);
    }];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"＋" forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColorFromRGB(0x3b3b3b) forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateDisabled];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
    [addBtn setBackgroundColor:UIColor.whiteColor];
    addBtn.layer.cornerRadius = 4;
    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn = addBtn;
    
    [self addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(28, 28));
//        make.left.equalTo(self.textField.mas_right).offset(4);
        make.left.equalTo(self.textLabel.mas_right).offset(4);
    }];
}

#pragma mark - 更新
-(void)updateValue:(NSString *)value {
    self.textLabel.text = value;
    self.currentNum = [value intValue];
}

#pragma mark - 点击事件
-(void)touchBtnAction {
    if (self.touchBlock) {
        self.touchBlock(self.textLabel.text);
    }
}

#pragma mark - ＋事件
-(void)addBtnAction {
    self.currentNum++;
    [self addOrDeleteBtnEnableState];
    if (self.currentNum>sMaxSpeed) {
        self.currentNum=sMaxSpeed;
        return;
    }
//    self.textField.text = [NSString stringWithFormat:@"%d",self.currentNum];
    self.textLabel.text = [NSString stringWithFormat:@"%d",self.currentNum];
}

#pragma mark - －事件
-(void)deleteBtnAction {
    self.currentNum--;
    [self addOrDeleteBtnEnableState];
    if (self.currentNum<sMinSpeed) {
        self.currentNum=sMinSpeed;
        return;
    }
//    self.textField.text = [NSString stringWithFormat:@"%d",self.currentNum];
    self.textLabel.text = [NSString stringWithFormat:@"%d",self.currentNum];
}

-(void)addOrDeleteBtnEnableState {
    [self endEditing:YES];
    self.deleteBtn.enabled = self.currentNum>=sMinSpeed;
    self.addBtn.enabled = self.currentNum<=sMaxSpeed;
}

#pragma mark - lazy
-(UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _textLabel.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        _textLabel.textColor = UIColorFromRGB(0x3b3b3b);
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.layer.borderWidth = 1;
        _textLabel.layer.cornerRadius = 4;
    }
    return _textLabel;
}

-(UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _textField.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.layer.borderWidth = 1;
        _textField.layer.cornerRadius = 4;
    }
    return _textField;
}

@end
