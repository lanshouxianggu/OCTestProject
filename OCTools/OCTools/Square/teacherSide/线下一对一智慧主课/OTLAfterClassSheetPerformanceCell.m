//
//  OTLAfterClassSheetPerformanceCell.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLAfterClassSheetPerformanceCell.h"

@interface OTLAfterClassSheetPerformanceCell ()
@property (nonatomic, strong) UIImageView *starImageView1;
@property (nonatomic, strong) UIImageView *starImageView2;
@property (nonatomic, strong) UIImageView *starImageView3;
@property (nonatomic, strong) UIImageView *starImageView4;
@property (nonatomic, strong) UIImageView *starImageView5;

@property (nonatomic, strong) NSArray <UIImageView *> *starsImageViewArray;
@end

@implementation OTLAfterClassSheetPerformanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 9;
        
        self.starsImageViewArray = @[
            self.starImageView1,
            self.starImageView2,
            self.starImageView3,
            self.starImageView4,
            self.starImageView5
        ];
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zonghebianxian"]];
    
    [self.contentView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(15);
        make.width.height.mas_equalTo(28);
    }];
    
    UILabel *lab = [UILabel new];
    lab.text = @"综合表现";
    lab.textColor = UIColorFromRGB(0x3b3b3b);
    lab.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(imageV.mas_right).offset(8);
    }];
    
    [self.contentView addSubview:self.starImageView5];
    [self.starImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-15);
        make.width.height.mas_equalTo(22);
    }];
    
    [self.contentView addSubview:self.starImageView4];
    [self.starImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.equalTo(self.starImageView5.mas_left).offset(-15);
        make.width.height.equalTo(self.starImageView5);
    }];
    
    [self.contentView addSubview:self.starImageView3];
    [self.starImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.equalTo(self.starImageView4.mas_left).offset(-15);
        make.width.height.equalTo(self.starImageView5);
    }];
    
    [self.contentView addSubview:self.starImageView2];
    [self.starImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.equalTo(self.starImageView3.mas_left).offset(-15);
        make.width.height.equalTo(self.starImageView5);
    }];
    
    [self.contentView addSubview:self.starImageView1];
    [self.starImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.equalTo(self.starImageView2.mas_left).offset(-15);
        make.width.height.equalTo(self.starImageView5);
    }];
}

-(void)updateStars:(int)starCount {
    [self.starsImageViewArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.image = [UIImage imageNamed:@"icon_star_gray"];
    }];
    
    for (int i = 0; i<starCount; i++) {
        UIImageView *imageV = self.starsImageViewArray[i];
        imageV.image = [UIImage imageNamed:@"icon_star_slight"];
    }
}

#pragma mark - lazy

-(UIImageView *)starImageView1 {
    if (!_starImageView1) {
        _starImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_star_gray"]];
    }
    return _starImageView1;
}

-(UIImageView *)starImageView2 {
    if (!_starImageView2) {
        _starImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_star_gray"]];
    }
    return _starImageView2;
}

-(UIImageView *)starImageView3 {
    if (!_starImageView3) {
        _starImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_star_gray"]];
    }
    return _starImageView3;
}

-(UIImageView *)starImageView4 {
    if (!_starImageView4) {
        _starImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_star_gray"]];
    }
    return _starImageView4;
}

-(UIImageView *)starImageView5 {
    if (!_starImageView5) {
        _starImageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_star_gray"]];
    }
    return _starImageView5;
}
@end
