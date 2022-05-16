//
//  MCDiscoveryColumnCell.m
//  ChatClub
//
//  Created by 刘创 on 2021/7/16.
//  Copyright © 2021 ArcherMind. All rights reserved.
//

#import "MCDiscoveryColumnCell.h"

@interface MCDiscoveryColumnCell()
@end

@implementation MCDiscoveryColumnCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    self.mainView = [UIView new];
    self.mainView.backgroundColor = UIColor.whiteColor;
    self.mainView.layer.cornerRadius = 20;
    self.mainView.layer.borderColor = UIColor.grayColor.CGColor;
    self.mainView.layer.borderWidth = 1;
    
    [self addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:15];
    self.columnTitleLabel = titleLabel;
    [self.mainView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

@end
