//
//  OTLAfterClassSheetPianoTaskCell.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLAfterClassSheetPianoTaskCell.h"

@interface OTLAfterClassSheetPianoTaskCell ()
@property (nonatomic, strong) UIView *topView;
@end

@implementation OTLAfterClassSheetPianoTaskCell

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
}

#pragma mark - lazy
-(UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lianqinjilu"]];
        
        [_topView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
            make.width.height.mas_equalTo(28);
        }];
        
        UILabel *lab = [UILabel new];
        lab.text = @"练琴任务";
        lab.textColor = UIColorFromRGB(0x3b3b3b);
        lab.font = [UIFont systemFontOfSize:16];
        
        [_topView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(imageV.mas_right).offset(8);
        }];
    }
    return _topView;
}

@end
