//
//  LCSquareTableViewCell.m
//  OCTools
//
//  Created by stray s on 2022/4/1.
//

#import "LCSquareTableViewCell.h"

@interface LCSquareTableViewCell ()
@property (nonatomic, strong) UIView *mainView;
@end

@implementation LCSquareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        
        UIView *mainView = [UIView new];
        mainView.backgroundColor = UIColor.whiteColor;
        mainView.layer.cornerRadius = 75;
        mainView.layer.shadowColor = UIColor.cyanColor.CGColor;
        mainView.layer.shadowOffset = CGSizeMake(0, 0);
        mainView.layer.shadowRadius = 15;
        mainView.layer.shadowOpacity = 0.8;
        self.mainView = mainView;
        
        [mainView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
        
        [self.contentView addSubview:mainView];
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.left.offset(50);
            make.centerX.offset(0);
        }];
    }
    return self;
}

-(void)setCornerRadius:(CGFloat)radius {
    self.mainView.layer.cornerRadius = radius;
}

-(UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = UIColorFromRGB(0x3b3b3b);
        _label.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBold];
    }
    return _label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
