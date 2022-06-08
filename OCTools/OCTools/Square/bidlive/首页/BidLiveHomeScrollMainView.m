//
//  BidLiveHomeScrollMainView.m
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import "BidLiveHomeScrollMainView.h"
#import "BidLiveHomeHeadView.h"
#import "BidLiveHomeFloatView.h"
#import "Masonry.h"
#import "LCConfig.h"
#import "BidLiveBundleRecourseManager.h"

#import "BidLiveHomeScrollTopMainView.h"
#import "BidLiveHomeScrollLiveMainView.h"
#import "BidLiveHomeScrollSpeechMainView.h"
#import "BidLiveHomeScrollYouLikeMainView.h"
#import "BidLiveHomeNetworkModel.h"
#import "BidLiveHomeVideoGuaideModel.h"

#define kTopMainBannerViewHeight (UIApplication.sharedApplication.statusBarFrame.size.height>20?210:180)

#define kTopMainViewHeight (kTopMainBannerViewHeight+100+10+30+10+SCREEN_HEIGHT*0.18)
#define kLiveMainViewHeight (140*8+90+90+70+110)
#define kSpeechMainViewHeight (90+4*280+60)
#define kYouLikeMainViewHeight (110+5*280+4*10)

@interface BidLiveHomeScrollMainView () <UIScrollViewDelegate>
@property (nonatomic, strong) BidLiveHomeHeadView *topSearchView;
@property (nonatomic, strong) BidLiveHomeFloatView *floatView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *mainView;
///topView，包括图片广告轮播，按钮模块，文字滚动，直播页
@property (nonatomic, strong) BidLiveHomeScrollTopMainView *topMainView;
///直播专场
@property (nonatomic, strong) BidLiveHomeScrollLiveMainView *liveMainView;
///联拍讲堂
@property (nonatomic, strong) BidLiveHomeScrollSpeechMainView *speechMainView;
///猜你喜欢
@property (nonatomic, strong) BidLiveHomeScrollYouLikeMainView *youlikeMainView;
///上一次讲堂视频的数量
@property (nonatomic, assign) NSInteger lastVideosCount;
///名家讲堂当前页码
@property (nonatomic, assign) int speechPageIndex;
///第一页名家讲堂列表数据
@property (nonatomic, strong) NSArray *speechOrigionArray;
@end

@implementation BidLiveHomeScrollMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.speechPageIndex = 1;
        [self setupUI];
        
        WS(weakSelf)
#pragma mark - 全球拍卖点击事件
        [self.topMainView setGlobalSaleClickBlock:^{
            !weakSelf.globalSaleClickBlock?:weakSelf.globalSaleClickBlock();
        }];
#pragma mark - 鉴定点击事件
        [self.topMainView setAppraisalClickBlock:^{
            !weakSelf.appraisalClickBlock?:weakSelf.appraisalClickBlock();
        }];
#pragma mark - 国内拍卖点击事件
        [self.topMainView setCountrySaleClickBlock:^{
            !weakSelf.countrySaleClickBlock?:weakSelf.countrySaleClickBlock();
        }];
#pragma mark - 送拍点击事件
        [self.topMainView setSendClickBlock:^{
            !weakSelf.sendClickBlock?:weakSelf.sendClickBlock();
        }];
#pragma mark - 讲堂点击事件
        [self.topMainView setSpeechClassClickBlock:^{
            !weakSelf.speechClassClickBlock?:weakSelf.speechClassClickBlock();
        }];
#pragma mark - 资讯点击事件
        [self.topMainView setInformationClickBlock:^{
            !weakSelf.informationClickBlock?:weakSelf.informationClickBlock();
        }];
#pragma mark - 直播专场海外点击事件
        [self.liveMainView setAbroadClickBlock:^{
                    
        }];
#pragma mark - 直播专场国内点击事件
        [self.liveMainView setInternalClickBlock:^{
                    
        }];
        
#pragma mark - 联拍讲堂更多点击事件
        [self.speechMainView setMoreClickBlock:^{
            weakSelf.speechPageIndex++;
            [weakSelf loadHomeHotCourseData];
        }];
#pragma mark - 联拍讲堂收起点击事件
        [self.speechMainView setRetractingClickBlock:^{
            weakSelf.speechPageIndex = 1;
            weakSelf.speechMainView.videosArray = [NSMutableArray arrayWithArray:weakSelf.speechOrigionArray];
            [weakSelf.speechMainView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(90+weakSelf.speechMainView.videosArray.count*280+60);
            }];
            [weakSelf.speechMainView.tableView reloadData];
            CGFloat offsetY = CGRectGetMaxY(weakSelf.liveMainView.frame)+(weakSelf.lastVideosCount-5)*280-150;
            [weakSelf.mainScrollView setContentOffset:CGPointMake(0, offsetY) animated:YES];
        }];
        
        [self loadData];
    }
    return self;
}

#pragma mark - 加载数据
-(void)loadData {
    [self loadBannerData];
    [self loadCMSArticleData];
    [self loadGlobalLiveData];
    [self loadHomeHotCourseData];
    [self loadHomeVideoGuaideData];
}

#pragma mark - 加载广告轮播数据
-(void)loadBannerData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageBannerList:11 client:@"wx" completion:^(NSArray<BidLiveHomeBannerModel *> * _Nonnull bannerList) {
        [weakSelf.topMainView updateBanners:bannerList];
    }];
}

#pragma mark - 加载动态滚动数据
-(void)loadCMSArticleData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageArticleList:1 pageSize:5 completion:^(NSArray * _Nonnull cmsArticleList) {
        [weakSelf.topMainView updateCMSArticleList:cmsArticleList];
    }];
}

#pragma mark - 加载全球直播列表数据
-(void)loadGlobalLiveData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageGlobalLiveList:@"all" completion:^(NSArray<BidLiveHomeGlobalLiveModel *> * _Nonnull liveList) {
        NSMutableArray *totalArray = [NSMutableArray arrayWithArray:liveList];
        NSRange range1 = NSMakeRange(0, totalArray.count/2);
        NSRange range2 = NSMakeRange(totalArray.count/2, totalArray.count/2);
        NSArray *array1 = [totalArray subarrayWithRange:range1];
        NSArray *array2 = [totalArray subarrayWithRange:range2];
        weakSelf.liveMainView.firstPartLiveArray = array1;
        weakSelf.liveMainView.secondPartLiveArray = array2;
        
        [weakSelf.liveMainView reloadData];
    }];
}

#pragma mark - 加载名家讲堂列表数据
-(void)loadHomeHotCourseData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageHotCourse:self.speechPageIndex pageSize:4 pageCount:0 completion:^(BidLiveHomeHotCourseModel * _Nonnull courseModel) {
        [weakSelf.speechMainView.videosArray addObjectsFromArray:courseModel.list];
        if (weakSelf.speechPageIndex==1) {
            weakSelf.speechOrigionArray = courseModel.list;
        }
        [weakSelf.speechMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90+weakSelf.speechMainView.videosArray.count*280+60);
        }];
        weakSelf.lastVideosCount = weakSelf.speechMainView.videosArray.count;
        [weakSelf.speechMainView reloadData];
    }];
}

#pragma mark - 加载视频导览列表数据
-(void)loadHomeVideoGuaideData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageVideoGuaideList:1 pageSize:20 isNoMore:false isLoad:true scrollLeft:@"" completion:^(BidLiveHomeVideoGuaideModel * _Nonnull courseModel) {
        [weakSelf.topMainView updateVideoGuaideList:courseModel.list];
    }];
}

-(void)setupUI {
    [self addSubview:self.mainScrollView];
    CGFloat origionY = -UIApplication.sharedApplication.statusBarFrame.size.height;
//    if (UIApplication.sharedApplication.statusBarFrame.size.height>20) {
//        origionY = -UIApplication.sharedApplication.statusBarFrame.size.height;
//    }
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(origionY, 0, 0, 0));
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [self addSubview:self.topSearchView];
    [self addSubview:self.floatView];
    
    [self.mainScrollView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
        make.width.equalTo(self.mainScrollView);
        make.height.mas_greaterThanOrEqualTo(self.mainScrollView);
    }];
    
    [self.mainView addSubview:self.topMainView];
    [self.topMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(kTopMainViewHeight);
    }];
    
    [self.mainView addSubview:self.liveMainView];
    [self.liveMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.topMainView.mas_bottom);
        make.height.mas_equalTo(kLiveMainViewHeight);
    }];
    
    [self.mainView addSubview:self.speechMainView];
    [self.speechMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.liveMainView.mas_bottom);
        make.height.mas_equalTo(kSpeechMainViewHeight);
    }];
    
    [self.mainView addSubview:self.youlikeMainView];
    [self.youlikeMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.speechMainView.mas_bottom).offset(-40);
        make.height.mas_equalTo(kYouLikeMainViewHeight);
        make.bottom.offset(-10);
    }];
    
    [self.mainView insertSubview:self.youlikeMainView belowSubview:self.speechMainView];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<CGRectGetHeight(self.topSearchView.frame)) {
        CGFloat alpha = offsetY/CGRectGetHeight(self.topSearchView.frame);
        NSLog(@"alpha = %f",alpha);
        self.topSearchView.backgroundColor = UIColorFromRGBA(0xf2f2f2, alpha);
    }else {
        self.topSearchView.backgroundColor = UIColorFromRGBA(0xf2f2f2,1);
    }
    CGFloat likeViewMaxY = CGRectGetMaxY(self.youlikeMainView.frame)-kYouLikeMainViewHeight/2;
    if (offsetY>=likeViewMaxY) {
        [self.youlikeMainView.likesArray addObject:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
        NSInteger likesArrayCount = self.youlikeMainView.likesArray.count;
        [self.youlikeMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(likesArrayCount*kYouLikeMainViewHeight);
        }];
        [self.youlikeMainView.collectionView reloadData];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.15 animations:^{
        self.floatView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
       [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
       // 停止类型3
       BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
       if (dragToDragStop) {
          [self scrollViewDidEndScroll];
       }
  }
}

#pragma mark - scrollView 停止滚动监测
- (void)scrollViewDidEndScroll {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.15 animations:^{
            self.floatView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    });
}

#pragma mark - lazy
-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.delegate = self;
//        _mainScrollView.bounces = NO;
    }
    return _mainScrollView;
}

-(UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _mainView;
}

-(BidLiveHomeHeadView *)topSearchView {
    if (!_topSearchView) {
        CGFloat height = 80;
        if (UIApplication.sharedApplication.statusBarFrame.size.height>20) {
            height = 100;
        }
        _topSearchView = [[BidLiveHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        WS(weakSelf)
        [_topSearchView setSearchClickBlock:^{
            !weakSelf.searchClickBlock?:weakSelf.searchClickBlock();
        }];
    }
    return _topSearchView;
}

-(BidLiveHomeFloatView *)floatView {
    if (!_floatView) {
        _floatView = [[BidLiveHomeFloatView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-30, SCREEN_HEIGHT-130, 60, 60)];
    }
    return _floatView;
}

-(BidLiveHomeScrollTopMainView *)topMainView {
    if (!_topMainView) {
        _topMainView  = [[BidLiveHomeScrollTopMainView alloc] initWithFrame:CGRectZero];
        _topMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        WS(weakSelf)
        [_topMainView setBannerClick:^(BidLiveHomeBannerModel * _Nonnull model) {
            !weakSelf.bannerClick?:weakSelf.bannerClick(model);
        }];
    }
    return _topMainView;
}

-(BidLiveHomeScrollLiveMainView *)liveMainView {
    if (!_liveMainView) {
        _liveMainView = [[BidLiveHomeScrollLiveMainView alloc] initWithFrame:CGRectZero];
        _liveMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _liveMainView;
}

-(BidLiveHomeScrollSpeechMainView *)speechMainView {
    if (!_speechMainView) {
        _speechMainView = [[BidLiveHomeScrollSpeechMainView alloc] initWithFrame:CGRectZero];
        _speechMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _speechMainView;
}

-(BidLiveHomeScrollYouLikeMainView *)youlikeMainView {
    if (!_youlikeMainView) {
        _youlikeMainView = [[BidLiveHomeScrollYouLikeMainView alloc] initWithFrame:CGRectZero];
        _youlikeMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _youlikeMainView;
}
@end
