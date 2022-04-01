//
//  OTLPracticePianoTaskSecondCell.m
//  OCTools
//
//  Created by stray s on 2022/4/1.
//

#import "OTLPracticePianoTaskSecondCell.h"

@implementation OTLPracticePianoTaskSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *mainView = [UIView new];
    mainView.backgroundColor = UIColor.whiteColor;
    mainView.layer.cornerRadius = 10;
    
    [self.contentView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.bottom.offset(0);
        make.centerX.offset(0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
