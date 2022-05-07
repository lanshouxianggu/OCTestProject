//
//  OTLBackClassView.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLBackClassView.h"

@interface OTLBackClassView ()
@property (nonatomic, strong) UIView *mainView;
@end

@implementation OTLBackClassView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
}

#pragma mark - lazy
-(UIView *)mainView {
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = UIColor.whiteColor;
        _mainView.layer.cornerRadius = 9;
    }
    return _mainView;
}
@end
