//
//  CommonServiceCollectionViewCell.m
//  ChatClub
//
//  Created by ArcherMind on 2020/12/16.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "CommonServiceCollectionViewCell.h"

@interface CommonServiceCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation CommonServiceCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(-15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.left.offset(5);
    }];
}

-(void)updateWithDic:(NSDictionary *)dataDic {
    self.imageView.image = [UIImage imageNamed:dataDic[@"image"]];
    self.titleLabel.text = dataDic[@"title"];
}

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColor.darkTextColor;
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
