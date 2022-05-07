//
//  OTLAfterClassSheetVideoCell.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLAfterClassSheetVideoCell.h"

@interface OTLAfterClassSheetVideoCell ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *tipsLabel;
@end

@implementation OTLAfterClassSheetVideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 9;
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.contentView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.topView.mas_bottom);
    }];
}

#pragma mark - 相册上传
-(void)assertUpload {
    
}

#pragma mark - lazy
-(UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shipinghuigu"]];
        
        [_topView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
            make.width.height.mas_equalTo(28);
        }];
        
        UILabel *lab = [UILabel new];
        lab.text = @"课堂视频";
        lab.textColor = UIColorFromRGB(0x3b3b3b);
        lab.font = [UIFont systemFontOfSize:16];
        
        [_topView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(imageV.mas_right).offset(8);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"书本批注" forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x76C0EF) forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        btn.layer.cornerRadius = 12;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = UIColorFromRGB(0x76C0EF).CGColor;
        btn.layer.borderWidth = 1;
        
        [btn addTarget:self action:@selector(assertUpload) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.size.mas_equalTo(CGSizeMake(72, 24));
            make.right.offset(-15);
        }];
    }
    return _topView;
}

-(UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        _tipsLabel.text = @"视频记录老师示范/知识重点/学生问题";
        _tipsLabel.textColor = UIColorFromRGB(0x999999);
        _tipsLabel.font = [UIFont systemFontOfSize:12];
    }
    return _tipsLabel;
}
@end
