//
//  ShareGroupTableViewCell.m
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ShareGroupTableViewCell.h"

@interface ShareGroupTableViewCell()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation ShareGroupTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.mas_right).offset(8);
    }];
    
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headImageView);
        make.left.equalTo(self.nameLabel);
    }];
    
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(self.nameLabel);
    }];
}

-(void)updateDataWithMode:(ShareGroupModel *)model {
    if (model.headImageUrl) {
        
    }
    self.nameLabel.text = model.groupName;
    self.descLabel.text = model.groupDesc;
    self.dateLabel.text = model.updateDate;
}

#pragma mrak - lazy load
-(UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = UIColor.orangeColor;
        _headImageView.layer.cornerRadius = 20;
    }
    return _headImageView;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = UIColor.darkTextColor;
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}

-(UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.textColor = UIColor.darkGrayColor;
        _descLabel.font = [UIFont systemFontOfSize:13];
    }
    return _descLabel;
}

-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = UIColor.darkGrayColor;
        _dateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dateLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
