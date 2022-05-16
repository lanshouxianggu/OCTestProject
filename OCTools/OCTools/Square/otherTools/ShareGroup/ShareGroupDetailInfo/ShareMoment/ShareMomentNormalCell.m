//
//  ShareMomentNormalCell.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/4.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ShareMomentNormalCell.h"

@implementation ShareMomentNormalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *sv = [UIView new];
    sv.backgroundColor = UIColor.whiteColor;
    self.mainView = sv;
    
    [self.contentView addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.bottom.offset(0);
    }];
    
    UIImageView *headImageView = [UIImageView new];
    headImageView.backgroundColor = UIColor.orangeColor;
    headImageView.layer.cornerRadius = 15;
    
    [sv addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
