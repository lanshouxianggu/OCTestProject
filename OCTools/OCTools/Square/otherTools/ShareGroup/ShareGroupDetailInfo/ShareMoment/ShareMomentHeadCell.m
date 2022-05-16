//
//  ShareMomentHeadCell.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/4.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ShareMomentHeadCell.h"

@implementation ShareMomentHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    self.contentView.backgroundColor = DF_COLOR_0x(0xf8f8f8);
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"最近更新";
    titleLabel.textColor = UIColor.darkTextColor;
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(20);
    }];
    
    UIImageView *arrowImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    [self.contentView addSubview:arrowImageV];
    [arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.right.offset(-20);
    }];
    
//    [self.contentView addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
//        make.top.equalTo(titleLabel.mas_bottom).offset(5);
//        make.bottom.offset(-10);
//    }];
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/5, self.frame.size.height-40);
        _collectionView.backgroundColor = UIColor.orangeColor;
        
    }
    return _collectionView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
