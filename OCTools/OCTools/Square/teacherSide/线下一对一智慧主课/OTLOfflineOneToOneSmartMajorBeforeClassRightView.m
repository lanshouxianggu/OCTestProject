//
//  OTLOfflineOneToOneSmartMajorBeforeClassRightView.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLOfflineOneToOneSmartMajorBeforeClassRightView.h"
#import "OTLBackClassView.h"

@interface OTLOfflineOneToOneSmartMajorBeforeClassRightView () <UIScrollViewDelegate>
///回课
@property (nonatomic, strong) OTLBackClassView *backClassView;
///新课
@property (nonatomic, strong) OTLBackClassView *freshClassView;
///课后单
@property (nonatomic, strong) OTLBackClassView *afterClassSheetView;

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation OTLOfflineOneToOneSmartMajorBeforeClassRightView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = UIColor.whiteColor;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    //    scrollView.alwaysBounceVertical = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.height.equalTo(self);
    }];
    
    UIView *mainView = [UIView new];
    [scrollView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(scrollView);
        make.height.mas_greaterThanOrEqualTo(scrollView);
    }];
    
    [mainView addSubview:self.backClassView];
    [self.backClassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.equalTo(self);
    }];
    
    [mainView addSubview:self.freshClassView];
    [self.freshClassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.backClassView.mas_bottom);
        make.height.equalTo(self);
    }];
    
    [mainView addSubview:self.afterClassSheetView];
    [self.afterClassSheetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.freshClassView.mas_bottom);
        make.height.equalTo(self);
        make.bottom.offset(0);
    }];
}

-(void)scrollToIndex:(NSInteger)index {
    [self.scrollView scrollRectToVisible:CGRectMake(0, index*CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:NO];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.y/CGRectGetHeight(self.frame);
    if (self.scrollToIndexBlock) {
        self.scrollToIndexBlock(index);
    }
}

#pragma mark - lazy
-(OTLBackClassView *)backClassView {
    if (!_backClassView) {
        _backClassView = [OTLBackClassView new];
        _backClassView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    }
    return _backClassView;
}

-(OTLBackClassView *)freshClassView {
    if (!_freshClassView) {
        _freshClassView = [OTLBackClassView new];
        _freshClassView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    }
    return _freshClassView;
}

-(OTLBackClassView *)afterClassSheetView {
    if (!_afterClassSheetView) {
        _afterClassSheetView = [OTLBackClassView new];
        _afterClassSheetView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    }
    return _afterClassSheetView;
}
@end
