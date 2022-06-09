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
#import "BidLiveHomeScrollAnchorMainView.h"
#import "BidLiveHomeScrollHighlightLotsView.h"
#import "BidLiveHomeNetworkModel.h"
#import "BidLiveHomeVideoGuaideModel.h"

#define kTopMainBannerViewHeight (UIApplication.sharedApplication.statusBarFrame.size.height>20?210:180)

#define kTopMainViewHeight (kTopMainBannerViewHeight+100+10+30+10+SCREEN_HEIGHT*0.18)
#define kLiveMainViewHeight (140*8+90+90+70+110)

#define kAnchorCellHeight (SCREEN_WIDTH-30)*11/18

#define kAnchorMainViewHeight (90+4*kAnchorCellHeight+60)
#define kSpeechMainViewHeight (90+4*280+60)
#define kYouLikeMainViewHeight (110+5*280+4*10)

#define kHightlightLotsMainViewHeight (SCREEN_HEIGHT*1/3+20+90)

@interface BidLiveHomeScrollMainView () <UIScrollViewDelegate>
@property (nonatomic, strong) BidLiveHomeHeadView *topSearchView;
@property (nonatomic, strong) BidLiveHomeFloatView *floatView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *mainView;
///topView，包括图片广告轮播，按钮模块，文字滚动，直播页
@property (nonatomic, strong) BidLiveHomeScrollTopMainView *topMainView;
///直播专场
@property (nonatomic, strong) BidLiveHomeScrollLiveMainView *liveMainView;
///精选主播
@property (nonatomic, strong) BidLiveHomeScrollAnchorMainView *anchorMainView;
///联拍讲堂
@property (nonatomic, strong) BidLiveHomeScrollSpeechMainView *speechMainView;
///焦点拍品
@property (nonatomic, strong) BidLiveHomeScrollHighlightLotsView *highlightLotsMainView;

///猜你喜欢
@property (nonatomic, strong) BidLiveHomeScrollYouLikeMainView *youlikeMainView;
///上一次讲堂视频的数量
@property (nonatomic, assign) NSInteger lastVideosCount;
///名家讲堂当前页码
@property (nonatomic, assign) int speechPageIndex;
///第一页名家讲堂列表数据
@property (nonatomic, strong) NSArray *speechOrigionArray;

///上一次精选主播的数量
@property (nonatomic, assign) NSInteger lastAnchorsCount;
///精选主播当前页码
@property (nonatomic, assign) int anchorPageIndex;
///第一页精选主播列表数据
@property (nonatomic, strong) NSArray *anchorOrigionArray;

///猜你喜欢当前页码
@property (nonatomic, assign) int youlikePageIndex;

@property (nonatomic, strong) NSMutableArray *youlikePageIndexArray;

@end

@implementation BidLiveHomeScrollMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.speechPageIndex = 1;
        self.anchorPageIndex = 1;
        self.youlikePageIndex = 0;
        self.youlikePageIndexArray = [NSMutableArray arrayWithArray:@[@(82),@(81),@(67),@(3),
                                                                      @(71),@(44),@(8),@(40),@(106),
                                                                      @(47),@(94),@(19),@(7),@(87),
                                                                      @(26),@(21),@(111),@(63),@(28),
                                                                      @(39),@(17),@(60),@(9),@(15),
                                                                      @(54),@(68),@(101),@(84),@(2),
                                                                      @(57),@(12),@(85),@(61),@(16),
                                                                      @(5),@(73),@(41),@(34),@(29),
                                                                      @(62),@(89),@(6),@(30),@(27),
                                                                      @(32),@(108),@(117),@(91),@(116),
                                                                      @(11),@(114),@(115),@(72),@(97),
                                                                      @(90),@(88),@(107),@(92),@(86),
                                                                      @(53),@(36),@(22),@(56),@(59),
                                                                      @(75),@(55),@(105),@(112),@(70),
                                                                      @(58),@(110),@(38),@(104),@(65),
                                                                      @(1),@(45),@(98),@(24),@(10),
                                                                      @(83),@(33),@(35),@(43),@(48),
                                                                      @(49),@(100),@(93),@(14),@(50),
                                                                      @(37),@(31),@(96),@(79),@(46),
                                                                      @(103),@(64),@(13),@(76),@(118),
                                                                      @(66),@(99),@(102),@(51),@(52),
                                                                      @(25),@(18),@(4),@(109),@(95),
                                                                      @(23),@(74),@(78),@(80),@(77),
                                                                      @(113),@(20),@(69),@(31),@(15),
                                                                      @(77),@(19),@(117),@(28),@(21),
                                                                      @(91),@(70),@(78),@(56),@(27),]];
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
#pragma mark - 精选主播更多点击事件
        [self.anchorMainView setMoreClickBlock:^{
            weakSelf.anchorPageIndex++;
            [weakSelf loadHomeAnchorListData];
        }];
#pragma mark - 精选主播收起点击事件
        [self.anchorMainView setRetractingClickBlock:^{
            weakSelf.anchorPageIndex = 1;
            weakSelf.anchorMainView.anchorsArray = [NSMutableArray arrayWithArray:weakSelf.anchorOrigionArray];
            [weakSelf.anchorMainView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(90+weakSelf.anchorMainView.anchorsArray.count*kAnchorCellHeight+60);
            }];
            [weakSelf.anchorMainView reloadData];
            
            CGFloat offsetY = CGRectGetMaxY(weakSelf.liveMainView.frame)+(weakSelf.lastAnchorsCount-5)*kAnchorCellHeight-150;
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
    [self loadHomeAnchorListData];
    [self loadGuessYouLikeListData];
    [self loadHomeHighliahtLotsListData];
}

#pragma mark - 设置UI
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
    
    [self.mainView addSubview:self.anchorMainView];
    [self.anchorMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.liveMainView.mas_bottom);
        make.height.mas_equalTo(kAnchorMainViewHeight);
    }];
    
    [self.mainView addSubview:self.speechMainView];
    [self.speechMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.anchorMainView.mas_bottom);
        make.height.mas_equalTo(kSpeechMainViewHeight);
    }];
    
    [self.mainView addSubview:self.highlightLotsMainView];
    [self.highlightLotsMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.speechMainView.mas_bottom);
        make.height.mas_equalTo(kHightlightLotsMainViewHeight);
    }];
    
    [self.mainView addSubview:self.youlikeMainView];
    [self.youlikeMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.highlightLotsMainView.mas_bottom).offset(-40);
        make.height.mas_equalTo(kYouLikeMainViewHeight);
        make.bottom.offset(-10);
    }];
    
    [self.mainView insertSubview:self.youlikeMainView belowSubview:self.speechMainView];
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
    [BidLiveHomeNetworkModel getHomePageArticleList:1 pageSize:5 completion:^(NSArray<BidLiveHomeCMSArticleModel *> * _Nonnull cmsArticleList) {
        [weakSelf.topMainView updateCMSArticleList:cmsArticleList];
        [weakSelf.liveMainView updateBannerArray:cmsArticleList];
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

#pragma mark - 加载精选主播列表数据
-(void)loadHomeAnchorListData {
    WS(weakSelf)
    
    [BidLiveHomeNetworkModel getHomePageAnchorList:self.anchorPageIndex pageSize:4 pageCount:0 isContainBeforePage:false completion:^(BidLiveHomeAnchorModel * _Nonnull model) {
        [weakSelf.anchorMainView.anchorsArray addObjectsFromArray:model.list];
        if (weakSelf.anchorPageIndex==1) {
            weakSelf.anchorOrigionArray = model.list;
        }
        [weakSelf.anchorMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90+weakSelf.anchorMainView.anchorsArray.count*kAnchorCellHeight+60);
        }];
        weakSelf.lastAnchorsCount = weakSelf.anchorMainView.anchorsArray.count;
        [weakSelf.anchorMainView reloadData];
    }];
}

#pragma mark - 加载焦点拍品列表数据
-(void)loadHomeHighliahtLotsListData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageHighlightLotsList:1 pageSize:20 isNoMore:false isLoad:true scrollLeft:@"" completion:^(BidLiveHomeHighlightLotsModel * _Nonnull courseModel) {
        [weakSelf.highlightLotsMainView updateHighlightLotsList:courseModel.list];
    }];
}

#pragma mark - 加载猜你喜欢列表数据
-(void)loadGuessYouLikeListData {
    WS(weakSelf)
    [BidLiveHomeNetworkModel getHomePageGuessYouLikeList:self.youlikePageIndex completion:^(BidLiveHomeGuessYouLikeModel * _Nonnull model) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:model.list];
        if (weakSelf.youlikePageIndex==0 && model.list.count>10) {
            [weakSelf.youlikeMainView.likesArray removeAllObjects];
            NSRange range1 = NSMakeRange(0, 10);
            NSRange range2 = NSMakeRange(10, model.list.count-10);
            NSArray *array1 = [tempArray subarrayWithRange:range1];
            NSArray *array2 = [tempArray subarrayWithRange:range2];
            [weakSelf.youlikeMainView.likesArray addObject:array1];
            [weakSelf.youlikeMainView.likesArray addObject:array2];
        }else {
            if (model.list) {
                [weakSelf.youlikeMainView.likesArray addObject:model.list];
            }
        }
        NSInteger likesArrayCount = weakSelf.youlikeMainView.likesArray.count;
        [weakSelf.youlikeMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(likesArrayCount*kYouLikeMainViewHeight);
        }];
        [weakSelf.youlikeMainView.collectionView reloadData];
    }];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<CGRectGetHeight(self.topSearchView.frame)) {
        CGFloat alpha = offsetY/CGRectGetHeight(self.topSearchView.frame);
        self.topSearchView.backgroundColor = UIColorFromRGBA(0xf2f2f2, alpha);
    }else {
        self.topSearchView.backgroundColor = UIColorFromRGBA(0xf2f2f2,1);
    }
    CGFloat likeViewMaxY = CGRectGetMaxY(self.youlikeMainView.frame)-kYouLikeMainViewHeight/2-90;
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
    CGFloat maximumOffset = size.height;
    
    if (currentOffset>=maximumOffset) {
        NSLog(@"划到底部了");
        if (self.youlikePageIndexArray.firstObject) {
            int currentPage = [[self.youlikePageIndexArray firstObject] intValue];
            self.youlikePageIndex = currentPage;
            [self loadGuessYouLikeListData];
            [self.youlikePageIndexArray removeObjectAtIndex:0];
        }
    }
    
    CGFloat statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    if (fabs(offsetY)==statusBarHeight) {
        return;
    }
    [UIView animateWithDuration:0.35 animations:^{
//        self.floatView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        self.floatView.alpha = 0;
    }];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    CGFloat offsetY = scrollView.contentOffset.y;
//    CGFloat statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
//    if (fabs(offsetY)==statusBarHeight) {
//        return;
//    }
//    [UIView animateWithDuration:0.15 animations:^{
////        self.floatView.transform = CGAffineTransformMakeScale(0.001, 0.001);
//        self.floatView.alpha = 0;
//    }];
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
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.35 animations:^{
//            self.floatView.transform = CGAffineTransformMakeScale(1, 1);
            self.floatView.alpha = 1;
        }];
//    });
}

#pragma mark - lazy
-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.delegate = self;
        _mainScrollView.bounces = NO;
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

-(BidLiveHomeScrollAnchorMainView *)anchorMainView {
    if (!_anchorMainView) {
        _anchorMainView = [[BidLiveHomeScrollAnchorMainView alloc] initWithFrame:CGRectZero];
        _anchorMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _anchorMainView;
}

-(BidLiveHomeScrollSpeechMainView *)speechMainView {
    if (!_speechMainView) {
        _speechMainView = [[BidLiveHomeScrollSpeechMainView alloc] initWithFrame:CGRectZero];
        _speechMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _speechMainView;
}

-(BidLiveHomeScrollHighlightLotsView *)highlightLotsMainView {
    if (!_highlightLotsMainView) {
        _highlightLotsMainView = [[BidLiveHomeScrollHighlightLotsView alloc] initWithFrame:CGRectZero];
        _highlightLotsMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _highlightLotsMainView;
}

-(BidLiveHomeScrollYouLikeMainView *)youlikeMainView {
    if (!_youlikeMainView) {
        _youlikeMainView = [[BidLiveHomeScrollYouLikeMainView alloc] initWithFrame:CGRectZero];
        _youlikeMainView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    }
    return _youlikeMainView;
}
@end
