//
//  OTLPracticePianoTaskVC.m
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import "OTLPracticePianoTaskVC.h"
#import "OTLPracticePianoTaskFirstPartView.h"
#import "OTLPracticePianoTaskSecondPartView.h"

@interface OTLPracticePianoTaskVC ()
@property (nonatomic, strong) OTLPracticePianoTaskFirstPartView *firstPartView;
@property (nonatomic, strong) UIView *secondPartView;
@property (nonatomic, strong) UIView *thirdPartView;
@end

@implementation OTLPracticePianoTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"练琴任务";
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIView *mainView = [UIView new];
    mainView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    [scrollView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
        make.width.equalTo(scrollView);
        make.height.mas_greaterThanOrEqualTo(scrollView);
    }];
    
    [mainView addSubview:self.firstPartView];
    [self.firstPartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [mainView addSubview:self.secondPartView];
    [self.secondPartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(140);
        make.top.equalTo(self.firstPartView.mas_bottom);
    }];
    
    [mainView addSubview:self.thirdPartView];
    [self.thirdPartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(148);
        make.top.equalTo(self.secondPartView.mas_bottom).offset(15);
        make.bottom.mas_lessThanOrEqualTo(-15);
    }];
}

#pragma mark - lazy
-(OTLPracticePianoTaskFirstPartView *)firstPartView {
    if (!_firstPartView) {
        _firstPartView = [[OTLPracticePianoTaskFirstPartView alloc] initWithFrame:CGRectZero];
        _firstPartView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    }
    return _firstPartView;
}

-(OTLPracticePianoTaskSecondPartView *)secondPartView {
    if (!_secondPartView) {
        _secondPartView = [[OTLPracticePianoTaskSecondPartView alloc] initWithFrame:CGRectZero];
        _secondPartView.backgroundColor = UIColor.whiteColor;
        _secondPartView.layer.cornerRadius = 9;
        _secondPartView.layer.masksToBounds = YES;
    }
    return _secondPartView;
}

-(UIView *)thirdPartView {
    if (!_thirdPartView) {
        _thirdPartView = [UIView new];
        _thirdPartView.backgroundColor = UIColor.whiteColor;
        _thirdPartView.layer.cornerRadius = 9;
    }
    return _thirdPartView;
}
@end
