//
//  OTLPracticePianoTaskFirstPartView.m
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import "OTLPracticePianoTaskFirstPartView.h"
#import "OTLAddOrDeleteToolView.h"
#import "OTLPianoTaskChooseCommonView.h"

@interface OTLPracticePianoTaskFirstPartView ()
@property (nonatomic, strong) OTLAddOrDeleteToolView *toolView;
@end

@implementation OTLPracticePianoTaskFirstPartView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI {
    [self addSubview:self.toolView];
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.width.mas_equalTo(142);
    }];
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"icon_check_normal"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"icon_check_selected"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setTitle:@"速度要求" forState:UIControlStateNormal];
    [selectBtn setTitleColor:UIColorFromRGB(0x3b3b3b) forState:UIControlStateNormal];
    [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    [self addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.right.equalTo(self.toolView.mas_left);
        make.width.mas_equalTo(100);
    }];
    
    UIImageView *imageV = [UIImageView new];
    imageV.backgroundColor = OTLAppMainColor;
    
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.offset(0);
    }];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目...";
    nameLabel.textColor = UIColorFromRGB(0x333333);
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageV.mas_right).offset(8);
        make.right.equalTo(selectBtn.mas_left).offset(-15);
        make.centerY.offset(0);
    }];
}

-(void)selectBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
}

-(void)updateValue:(NSString *)value {
    [self.toolView updateValue:value];
}

#pragma mark - lazy
-(OTLAddOrDeleteToolView *)toolView {
    if (!_toolView) {
        _toolView = [[OTLAddOrDeleteToolView alloc] initWithFrame:CGRectZero currentNum:60];
        WS(weakSelf)
        [_toolView setTouchBlock:^(NSString * _Nonnull currentStr) {
            if (weakSelf.speedTouchBlock) {
                weakSelf.speedTouchBlock(currentStr);
            }
        }];
    }
    return _toolView;
}
@end
