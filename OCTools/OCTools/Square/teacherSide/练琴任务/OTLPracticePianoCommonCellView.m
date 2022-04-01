//
//  OTLPracticePianoCommonCellView.m
//  ChatClub
//
//  Created by stray s on 2022/3/31.
//  Copyright © 2022 ArcherMind. All rights reserved.
//

#import "OTLPracticePianoCommonCellView.h"
#import "OTLAddOrDeleteToolView.h"

@interface OTLPracticePianoCommonCellView ()
/// 是否可以展开
@property (nonatomic, assign) BOOL canExpand;
/// 标题
@property (nonatomic, copy) NSString *btnTitle;
@property (nonatomic, assign) PracticePianoTaskType taskType;
@property (nonatomic, strong) OTLAddOrDeleteToolView *toolView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign) BOOL isSelect;
@end

@implementation OTLPracticePianoCommonCellView

#pragma mark - initiation
-(instancetype)initWithFrame:(CGRect)frame
                   canExpand:(BOOL)canExpand
                    btnTitle:(NSString *)btnTitle
                    taskType:(PracticePianoTaskType)taskType
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0xf2f2f2);
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        self.taskType = taskType;
        self.canExpand = canExpand;
        self.btnTitle = btnTitle;
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
-(void)setupUI {
    UIView *topView = [UIView new];
    topView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"icon_check_normal"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"icon_check_selected"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setTitle:self.btnTitle forState:UIControlStateNormal];
    [selectBtn setTitleColor:UIColorFromRGB(0x3b3b3b) forState:UIControlStateNormal];
    [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    [topView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.mas_equalTo(120);
    }];
    
    if (self.taskType==PracticePianoTaskTypeSpeed) {
        [topView addSubview:self.toolView];
        [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.offset(0);
            make.width.mas_equalTo(142);
        }];
    }
    
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(56);
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(0);
    }];
}

#pragma mark - event
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.toolView endEditing:YES];
}

-(void)selectBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.canExpand) {
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(sender.selected?95:0);
        }];
    }
    if (self.selectActionBlock) {
        self.selectActionBlock(sender.selected);
    }
    self.layer.borderWidth = sender.selected?1:0;
    self.layer.borderColor = UIColorFromRGB(0xF7931E).CGColor;
}

#pragma mark - lazy
-(OTLAddOrDeleteToolView *)toolView {
    if (!_toolView) {
        int num = 0;
        if (self.taskType==PracticePianoTaskTypeSpeed) {
            num = 60;
        }else {
            num = 0;
        }
        _toolView = [[OTLAddOrDeleteToolView alloc] initWithFrame:CGRectZero currentNum:num];
    }
    return _toolView;
}

-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    }
    return _bottomView;
}
@end
