//
//  OTLPracticeWeekReportViewController.m
//  TeacherSide
//
//  Created by stray s on 2022/3/2.
//  Copyright © 2022 YueHe. All rights reserved.
//

#import "OTLPracticeWeekReportViewController.h"
#import "CPISegementView.h"
#import "OTLWeekReportDetailViewController.h"

@interface OTLPracticeWeekReportViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) CPISegementView *segementView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger lastSelectIndex;

@property (nonatomic, strong) OTLWeekReportDetailViewController *weekReportVC1;
@property (nonatomic, strong) OTLWeekReportDetailViewController *weekReportVC2;
@end

@implementation OTLPracticeWeekReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"练琴周报";
    
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.lastSelectIndex = 0;
    [self setupUI];
}

-(void)setupUI {
    UIView *segSuperView = [UIView new];
    segSuperView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    [self.view addSubview:segSuperView];
    [segSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [segSuperView addSubview:self.segementView];
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.bounces = NO;
    scrollV.pagingEnabled = YES;
    scrollV.delegate = self;
//    scrollV.contentSize = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT-TOP_HEIGHT-60);
    
    self.scrollView = scrollV;
    [self.view addSubview:scrollV];
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(segSuperView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    UIView *scrollMain = [UIView new];
    [scrollV addSubview:scrollMain];
    [scrollMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.height.equalTo(scrollV);
        make.width.mas_equalTo(SCREEN_WIDTH*2);
    }];
    
    UIView *scrollMainV1 = [UIView new];
    [scrollMain addSubview:scrollMainV1];
    [scrollMainV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    UIView *scrollMainV2 = [UIView new];
    [scrollMain addSubview:scrollMainV2];
    [scrollMainV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.left.equalTo(scrollMainV1.mas_right);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    self.weekReportVC1 = [[OTLWeekReportDetailViewController alloc] init];
    self.weekReportVC1.hasPractice = YES;
    [scrollMainV1 addSubview:self.weekReportVC1.view];
    [self.weekReportVC1.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    self.weekReportVC2 = [[OTLWeekReportDetailViewController alloc] init];
    self.weekReportVC2.hasPractice = NO;
    [scrollMainV2 addSubview:self.weekReportVC2.view];
    [self.weekReportVC2.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self.segementView setSelectIndex:page];
}

#pragma mark - lazy
-(CPISegementView *)segementView {
    if (!_segementView) {
        CPISegementConfiguration *segConfig = [[CPISegementConfiguration alloc] init];
        segConfig.lineHeight = 2;
        segConfig.lineColor = OTLAppMainColor;
        segConfig.lineLeftOffset = 25;
        segConfig.lineRightOffset = -25;
        segConfig.titleNormalFont = [UIFont systemFontOfSize:15];
        segConfig.titleSelectFont = [UIFont systemFontOfSize:15];
        segConfig.titleNormalColor = UIColor.darkTextColor;
        segConfig.titleSelectColor = OTLAppMainColor;
        
        _segementView = [[CPISegementView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-120, 0, 240, 44) titles:@[@"练琴学员(3)",@"未练琴学员(5)"] config:segConfig];
        WS(weakSelf)
        _segementView.selectBlock = ^(NSUInteger index) {
            if (index==weakSelf.lastSelectIndex) {
                return;
            }
            weakSelf.lastSelectIndex = index;
            [weakSelf.scrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
        };
    }
    return _segementView;
}

@end
