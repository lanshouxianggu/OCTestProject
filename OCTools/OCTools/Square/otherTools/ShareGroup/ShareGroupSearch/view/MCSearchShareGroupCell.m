//
//  MCSearchShareGroupCell.m
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCSearchShareGroupCell.h"

@interface MCSearchShareGroupCell ()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *subNameLabel;
@end

@implementation MCSearchShareGroupCell

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
        make.left.offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(15);
        make.right.offset(-40);
        make.top.equalTo(self.headImageView.mas_top).offset(5);
    }];
    
    [self.contentView addSubview:self.subNameLabel];
    [self.subNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLabel);
        make.bottom.equalTo(self.headImageView.mas_bottom).offset(-5);
    }];
    
    UIImageView *arrowImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    [self.contentView addSubview:arrowImageV];
    [arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-20);
    }];
}

-(UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = DF_COLOR_BGMAIN;
    }
    return _headImageView;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = UIColor.darkTextColor;
        _nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    }
    return _nameLabel;
}

-(UILabel *)subNameLabel {
    if (!_subNameLabel) {
        _subNameLabel = [UILabel new];
        _subNameLabel.textColor = UIColor.darkGrayColor;
        _subNameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _subNameLabel;
}

-(void)setGroupModel:(MCSearchShareGroupModel *)groupModel {
    _groupModel = groupModel;
    NSString *nameStr = [NSString stringWithFormat:@"%@",groupModel.shareGroupName];
    self.nameLabel.text = [NSString stringWithFormat:@"%@（%@人）",nameStr,groupModel.memberCount];
    NSString *subNameStr = [NSString stringWithFormat:@"%@、%@",groupModel.nickName,groupModel.memberName];
    self.subNameLabel.text = [NSString stringWithFormat:@"成员：%@",subNameStr];
    if (groupModel.searchKey.length>0) {
        NSMutableAttributedString *nameAttrStr = [[NSMutableAttributedString alloc] initWithString:nameStr];
        
        NSArray *rangeArr = [self getDuplicateSubStrLocInCompleteStr:nameStr withSubStr:groupModel.searchKey];
        for (NSNumber *location in rangeArr) {
            NSRange keyRange = NSMakeRange([location intValue], groupModel.searchKey.length);
            [nameAttrStr addAttributes:@{NSForegroundColorAttributeName:UIColor.blueColor} range:keyRange];
        }
        
        NSMutableAttributedString *subNameAttrStr = [[NSMutableAttributedString alloc] initWithString:subNameStr];
//        NSRange keyRange = [subNameStr rangeOfString:groupModel.searchKey];
//        [subNameAttrStr addAttributes:@{NSForegroundColorAttributeName:UIColor.blueColor} range:keyRange];
        rangeArr = [self getDuplicateSubStrLocInCompleteStr:subNameStr withSubStr:groupModel.searchKey];
        for (NSNumber *location in rangeArr) {
            NSRange keyRange = NSMakeRange([location intValue], groupModel.searchKey.length);
            [subNameAttrStr addAttributes:@{NSForegroundColorAttributeName:UIColor.blueColor} range:keyRange];
        }
        
        [nameAttrStr appendAttributedString:[NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
            make.text(@"（");
            make.text([NSString stringWithFormat:@"%@",groupModel.memberCount]);
            make.text(@"人）");
        }]];
        self.nameLabel.attributedText = nameAttrStr;
        [subNameAttrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"成员："] atIndex:0];
        self.subNameLabel.attributedText = subNameAttrStr;
    }
}

-(void)setFileModel:(MCSearchGroupFileModel *)fileModel {
    _fileModel = fileModel;
    NSString *nameStr = fileModel.fileName;
    self.nameLabel.text = nameStr;
    NSString *subNameStr = fileModel.groupName;
    self.subNameLabel.text = [NSString stringWithFormat:@"来自共享群：%@",subNameStr];
    if (fileModel.searchKey.length>0) {
        NSMutableAttributedString *nameAttrStr = [[NSMutableAttributedString alloc] initWithString:nameStr];
//        NSRange keyRange = [nameStr rangeOfString:fileModel.searchKey];
//        [nameAttrStr addAttributes:@{NSForegroundColorAttributeName:UIColor.blueColor} range:keyRange];
        NSArray *rangeArr = [self getDuplicateSubStrLocInCompleteStr:nameStr withSubStr:fileModel.searchKey];
        for (NSNumber *location in rangeArr) {
            NSRange keyRange = NSMakeRange([location intValue], fileModel.searchKey.length);
            [nameAttrStr addAttributes:@{NSForegroundColorAttributeName:UIColor.blueColor} range:keyRange];
        }
        
        NSMutableAttributedString *subNameAttrStr = [[NSMutableAttributedString alloc] initWithString:subNameStr];
//        keyRange = [subNameStr rangeOfString:fileModel.searchKey];
//        [subNameAttrStr addAttributes:@{NSForegroundColorAttributeName:UIColor.blueColor} range:keyRange];
        rangeArr = [self getDuplicateSubStrLocInCompleteStr:subNameStr withSubStr:fileModel.searchKey];
        for (NSNumber *location in rangeArr) {
            NSRange keyRange = NSMakeRange([location intValue], fileModel.searchKey.length);
            [subNameAttrStr addAttributes:@{NSForegroundColorAttributeName:UIColor.blueColor} range:keyRange];
        }
        
        self.nameLabel.attributedText = nameAttrStr;
        [subNameAttrStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"来自共享群："] atIndex:0];
        self.subNameLabel.attributedText = subNameAttrStr;
    }
}

//获取字符串中所有相同的字符串的location数组
- (NSMutableArray *)getDuplicateSubStrLocInCompleteStr:(NSString *)completeStr withSubStr:(NSString *)subStr
{
    NSArray * separatedStrArr = [completeStr componentsSeparatedByString:subStr];
    NSMutableArray * locMuArr = [[NSMutableArray alloc]init];
    
    NSInteger index = 0;
    for (NSInteger i = 0; i<separatedStrArr.count-1; i++) {
        NSString * separatedStr = separatedStrArr[i];
        index = index + separatedStr.length;
        NSNumber * loc_num = [NSNumber numberWithInteger:index];
        [locMuArr addObject:loc_num];
        index = index+subStr.length;
    }
    return locMuArr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
