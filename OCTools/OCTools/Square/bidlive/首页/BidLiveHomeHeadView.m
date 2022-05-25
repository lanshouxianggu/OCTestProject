//
//  BidLiveHomeHeadView.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveHomeHeadView.h"

@interface BidLiveHomeHeadView ()

@end

@implementation BidLiveHomeHeadView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGBA(0xf2f2f2, 0);
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *searchView = [UIView new];
    searchView.backgroundColor = UIColor.whiteColor;
    searchView.layer.cornerRadius = 15;
    searchView.layer.masksToBounds = YES;
    
    [self addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.bottom.offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *lab = [UILabel new];
    lab.text = @"请输入关键字搜索";
    lab.textColor = UIColorFromRGB(0x3b3b3b);
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    
    [searchView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.centerX.offset(10);
    }];
    
    UIImageView *imageV = [UIImageView new];
    imageV.backgroundColor = UIColor.cyanColor;
    [searchView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.offset(0);
        make.right.equalTo(lab.mas_left).offset(-8);
    }];
    
    UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchBtn addTarget:self action:@selector(touchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:touchBtn];
    [touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

-(void)touchBtnAction {
    
}

@end
