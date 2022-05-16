//
//  DiscoveryViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/18.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryHeadSegmentView.h"
#import "MCDiscoveryAllColumnViewController.h"

static CGFloat const kHeadSegmentHeight = 50;

@interface DiscoveryViewController () <UIScrollViewDelegate,DiscoveryHeadSegmentViewDelegate,MCDiscoveryAllColumnViewControllerDelegate>
@property (nonatomic, strong) DiscoveryHeadSegmentView *headSegmentView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) NSArray *itemsTitleArray;
@property (nonatomic, assign) NSInteger currentSelectIndex;
@property (nonatomic, strong) NSString *account;
@end

@implementation DiscoveryViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发现";
    self.view.backgroundColor = DF_COLOR_BGMAIN;
    
    [self getCacheColumns];
    
    self.currentSelectIndex = 0;
    [self.view addSubview:self.headSegmentView];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH*self.itemsTitleArray.count);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"所有栏目" style:UIBarButtonItemStylePlain target:self action:@selector(allColumnAction)];
}

-(void)allColumnAction {
    MCDiscoveryAllColumnViewController *vc = [[MCDiscoveryAllColumnViewController alloc] initWithTitleArray:self.itemsTitleArray currentSelectIndex:self.currentSelectIndex];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - MCDiscoveryAllColumnViewControllerDelegate
-(void)didClickItemAtIndex:(NSInteger)index {
    self.currentSelectIndex = index;
    [self.headSegmentView needMoveScrollWithIndex:index];
    [self.mainScrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:NO];
}

-(void)getCacheColumns {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *origionData = [defaults valueForKey:@"DiscoveryAllColumns"];
    NSMutableArray *origionArray = [NSKeyedUnarchiver unarchiveObjectWithData:origionData];
    BOOL hasFound = NO;
    if (origionArray) {
        for (NSDictionary *dic in origionArray) {
            //获取当前账号对应的标题数组
            NSString *account = dic[@"account"]?:@"";
            if ([account isEqualToString:self.account]) {
                NSArray *titlesArr = dic[@"columns"];
                self.itemsTitleArray = titlesArr;
                hasFound = YES;
                break;
            }
        }
    }
    if (!hasFound) {
        self.itemsTitleArray = @[@"推荐",@"内容广场",@"云课堂",@"咪咕精选",@"分享家",@"测试1",@"测试2",@"内容广场",@"云课堂",@"咪咕精选",@"分享家",@"测试1",@"测试2"];
    }
}

#pragma mark - lazy
//-(NSArray *)itemsTitleArray {
//    if (!_itemsTitleArray) {
//        _itemsTitleArray = @[@"推荐",@"内容广场",@"云课堂",@"咪咕精选",@"分享家",@"测试1",@"测试2"];
//    }
//    return _itemsTitleArray;
//}
-(DiscoveryHeadSegmentView *)headSegmentView {
    if (!_headSegmentView) {
        _headSegmentView = [[DiscoveryHeadSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadSegmentHeight) andItemTitles:self.itemsTitleArray];
        _headSegmentView.delegate = self;
    }
    return _headSegmentView;
}

-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        CGFloat mainScrollViewHeight = SCREEN_HEIGHT-kHeadSegmentHeight-kStatusBarAndNavigationBarHeight-kTabbarSafeBottomMargin;
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeadSegmentHeight, SCREEN_WIDTH, mainScrollViewHeight)];
        _mainScrollView.backgroundColor = UIColor.whiteColor;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.bounces = NO;
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.itemsTitleArray.count, mainScrollViewHeight);
    }
    return _mainScrollView;
}

-(UIView *)mainView {
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = UIColor.orangeColor;
        
        for (int i = 0; i < self.itemsTitleArray.count; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, CGRectGetWidth(self.mainScrollView.frame), CGRectGetHeight(self.mainScrollView.frame))];
            view.backgroundColor = UIColor.randomColor;
            [_mainView addSubview:view];
        }
    }
    return _mainView;
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = offsetX/width;
    [self.headSegmentView needMoveScrollWithIndex:page];
    self.currentSelectIndex = page;
    NSLog(@"%ld",page);
}

#pragma mark - DiscoveryHeadSegmentViewDelegate
-(void)didSelectItemAtIndex:(NSInteger)index {
    self.currentSelectIndex = index;
    [self.mainScrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:NO];
}

-(void)updateDataArrayAfterMove:(NSArray *)dataArray currentIndex:(NSInteger)currentIndex{
    //更新缓存
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *origionData = [defaults valueForKey:@"DiscoveryAllColumns"];
    NSMutableArray *origionArray = [NSKeyedUnarchiver unarchiveObjectWithData:origionData];
    if (!origionArray) {
        origionArray = [NSMutableArray array];
    }
    NSDictionary *dataDic = [NSDictionary dictionary];
    NSData *saveData = [NSData new];
    dataDic = @{@"account":self.account?:@"",@"columns":dataArray};
    [origionArray addObject:dataDic];
    saveData = [NSKeyedArchiver archivedDataWithRootObject:origionArray];
    [defaults setValue:saveData forKey:@"DiscoveryAllColumns"];
    [defaults synchronize];
    
    self.itemsTitleArray = [NSMutableArray arrayWithArray:dataArray];
    [self.headSegmentView updataUI:dataArray];
    [self didSelectItemAtIndex:currentIndex];
    [self.headSegmentView needMoveScrollWithIndex:currentIndex];
}
@end
