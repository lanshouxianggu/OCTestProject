//
//  OTLPracticePianoTaskVC.m
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import "OTLPracticePianoTaskVC.h"
#import "OTLPracticePianoTaskFirstPartView.h"
#import "OTLPracticePianoTaskSecondPartView.h"
#import "OTLPianoTaskChooseCommonView.h"

@interface OTLPracticePianoTaskVC ()
@property (nonatomic, strong) OTLPracticePianoTaskFirstPartView *firstPartView;
@property (nonatomic, strong) OTLPracticePianoTaskSecondPartView *secondPartView;
@property (nonatomic, strong) UIView *thirdPartView;
@property (nonatomic, strong) OTLPianoTaskChooseCommonView *chooseView;
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
    
    [UIApplication.sharedApplication.keyWindow addSubview:self.chooseView];
}

#pragma mark - lazy
-(OTLPracticePianoTaskFirstPartView *)firstPartView {
    if (!_firstPartView) {
        _firstPartView = [[OTLPracticePianoTaskFirstPartView alloc] initWithFrame:CGRectZero];
        _firstPartView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        WS(weakSelf)
        [_firstPartView setSpeedTouchBlock:^(NSString * _Nonnull currentStr) {
            [weakSelf.chooseView showWithType:TaskChooseTypeSpeed selectStr:currentStr];
        }];
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

-(OTLPianoTaskChooseCommonView *)chooseView {
    if (!_chooseView) {
        _chooseView = [[OTLPianoTaskChooseCommonView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakSelf)
        [_chooseView setSelectBlock:^(TaskChooseType type, NSString * _Nonnull selectStr) {
            [weakSelf.firstPartView updateValue:selectStr];
        }];
    }
    return _chooseView;
}

-(void)dealloc {
    if (_chooseView) {
        [_chooseView removeFromSuperview];
        _chooseView = nil;
    }
}
@end
