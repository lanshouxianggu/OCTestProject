//
//  SelectFirstView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/12/14.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "SelectFirstView.h"

@interface SelectFirstView()
@property (nonatomic, strong) NSMutableArray *btnsArray;
@property (nonatomic, strong) UIButton *lastSelectBtn;
@property (nonatomic, strong) UIView *mainView;
@end

@implementation SelectFirstView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DF_COLOR_BGMAIN;
        [self setupUI];
    }
    return self;
}

-(NSMutableArray *)btnsArray {
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}

-(void)setSelectTitleArray:(NSArray<NSString *> *)selectTitleArray {
    _selectTitleArray = selectTitleArray;
    
    [self.btnsArray removeAllObjects];
    for (UIView *subV in self.mainView.subviews) {
        [subV removeFromSuperview];
    }
    
    for (int i = 0; i < self.selectTitleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.selectTitleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:DF_COLOR_BGMAIN] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:UIColor.clearColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(selectBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnsArray addObject:btn];
        
        [self.mainView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.mas_equalTo(44);
            make.top.offset(i*44);
            if (i==self.selectTitleArray.count-1) {
                make.bottom.offset(-10);
            }
        }];
    }
}

-(void)setupUI {
    UIScrollView *scrollV = [UIScrollView new];
    scrollV.alwaysBounceVertical = YES;
    [self addSubview:scrollV];
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    UIView *sv = [UIView new];
    self.mainView = sv;
    [scrollV addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
        make.width.equalTo(scrollV);
        make.height.mas_greaterThanOrEqualTo(scrollV);
    }];
}

-(void)selectBtnsAction:(UIButton *)selectBtn {
    if ([selectBtn isEqual:self.lastSelectBtn]) {
        return;
    }
    selectBtn.selected = !selectBtn.selected;
    self.lastSelectBtn = selectBtn;
    for (UIButton *btn in self.btnsArray) {
        if (btn.tag != selectBtn.tag) {
            btn.selected = NO;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(btnSelectWithTitle:)]) {
        [self.delegate btnSelectWithTitle:selectBtn.titleLabel.text];
    }
}

@end
