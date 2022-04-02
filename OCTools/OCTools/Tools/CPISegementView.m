//
//  CPISegementView.m
//  FORMUSIC
//
//  Created by yuehe on 2018/7/18.
//  Copyright © 2018年 云上钢琴. All rights reserved.
//

#import "CPISegementView.h"

@interface CPISegementView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *currentBtn;

@property (nonatomic, strong) CPISegementConfiguration *config;
@end


@implementation CPISegementView

- (instancetype)initWithFrame:(CGRect)frame titles:(nullable NSArray<NSString *> *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *currentBtn;
        if (!_config) {
            self.config = [CPISegementConfiguration new];
            self.config.lineLeftOffset = 12;
            self.config.lineRightOffset = -12;
            self.config.lineBottomOffset = -5;
            self.config.lineColor = UIColor.whiteColor;
            self.config.lineHeight = 3;
            self.config.lineCornerRadius = 1.5;
            self.config.btnSpacing = 20;
            self.config.titleNormalColor = [UIColor whiteColor];
            self.config.titleSelectColor = [UIColor whiteColor];
            self.config.titleNormalFont = [UIFont fontWithName:MediumStr size:16];
            self.config.titleSelectFont = [UIFont fontWithName:BoldStr size:16];
        }
        self.buttons = [[NSMutableArray<UIButton *> alloc] init];
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTintColor:UIColor.clearColor];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:self.config.titleNormalColor forState:UIControlStateNormal];
            [btn setTitleColor:self.config.titleSelectColor forState:UIControlStateSelected];
            btn.titleLabel.font = self.config.titleNormalFont;
            [self addSubview:btn];
            if (i == 0) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self);
                    make.bottom.equalTo(self);
                    make.top.equalTo(self);
                }];
            } else if (i == titles.count - 1) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(currentBtn.mas_right).offset(self.config.btnSpacing);
                    make.right.equalTo(self);
                    make.bottom.equalTo(self);
                    make.top.equalTo(self);
                    make.width.equalTo(currentBtn);
                }];
            } else {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(currentBtn.mas_right).offset(self.config.btnSpacing);
                    make.bottom.equalTo(self);
                    make.top.equalTo(self);
                    make.width.equalTo(currentBtn);
                }];
            }
            currentBtn = btn;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttons addObject:btn];
            
      
        }
        
        if (titles.count > 0) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = self.config.lineColor;
            lineView.layer.cornerRadius = self.config.lineCornerRadius;
            [self addSubview:lineView];
            self.lineView = lineView;
            
            [self setSelectIndex:0];
        }
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles config:(CPISegementConfiguration *)config {
    self.config = config;
    return [self initWithFrame:frame titles:titles];
}

- (void)clickBtn:(UIButton *)btn
{
    if (self.buttons.count != 0) {
        NSUInteger index = [self.buttons indexOfObject:btn];
        [self setSelectIndex:index];
    }
}

- (void)setSelectIndex:(NSUInteger)index
{
    if (self.buttons.count != 0) {
        self.currentBtn.titleLabel.font = self.config.titleNormalFont;
        self.currentBtn.selected = NO;
        UIButton *btn = self.buttons[index];
        btn.titleLabel.font = self.config.titleSelectFont;
        btn.selected = YES;
        self.currentBtn = btn;
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btn).offset(self.config.lineLeftOffset);
            make.right.equalTo(btn).offset(self.config.lineRightOffset);
            make.bottom.equalTo(btn).offset(self.config.lineBottomOffset);
            make.height.mas_equalTo(self.config.lineHeight);
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.lineView layoutIfNeeded];
        }];
        
        if (self.selectBlock) {
            self.selectBlock(index);
        }
    }
}

@end

@implementation CPISegementConfiguration



@end
