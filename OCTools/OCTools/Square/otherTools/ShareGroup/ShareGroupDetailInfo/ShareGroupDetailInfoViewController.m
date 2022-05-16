//
//  ShareGroupDetailInfoViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ShareGroupDetailInfoViewController.h"
#import "ShareGroupDetailInfoHeadSegementView.h"
#import "ShareMomentViewController.h"
#import "GroupFileViewController.h"
#import "ShareGroupDetailInfoToolBarView.h"

#define kHeadViewHeight 50
#define kToolBarHeight (60+kTabbarSafeBottomMargin)

@interface ShareGroupDetailInfoViewController () <
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    ShareGroupDetailInfoHeadSegementViewDelegate,
    GroupFileViewControllerDelegate,
    ShareGroupDetailInfoToolBarViewDelegate>

@property (nonatomic, strong) ShareGroupDetailInfoHeadSegementView *headView;
@property (nonatomic, strong) ShareGroupDetailInfoToolBarView *toolBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, strong) NSArray *childVcsArray;
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) UIBarButtonItem *rightAllItem;
@property (nonatomic, assign) BOOL isAllSelect;
@property (nonatomic, assign) NSInteger selectCount;

@property (nonatomic, strong) ShareMomentViewController *vc1;
@property (nonatomic, strong) GroupFileViewController *vc2;
@end

@implementation ShareGroupDetailInfoViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupUI];
    self.isAllSelect = NO;
    self.selectCount = 0;
}


-(void)setupUI {
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(kHeadViewHeight);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.headView.mas_bottom);
    }];
    
    self.vc1 = [ShareMomentViewController new];
    
    self.vc2 = [GroupFileViewController new];
    self.vc2.delegate = self;
    
    [self addChildViewController:self.vc1];
    [self addChildViewController:self.vc2];
    
    self.childVcsArray = @[self.vc1,self.vc2];
    self.rightAllItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.rightItem = [[UIBarButtonItem alloc] initWithTitle:@"全不选" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    
    [self.view addSubview:self.toolBar];
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.collectionView.mas_bottom);
        make.height.mas_equalTo(kToolBarHeight);
    }];
}

#pragma mark - action
-(void)rightItemAction:(UIBarButtonItem *)item {
    if ([item isEqual:self.rightAllItem]) {
        self.isAllSelect = YES;
        self.navigationItem.rightBarButtonItem = self.rightItem;
    }else{
        self.isAllSelect = NO;
        self.navigationItem.rightBarButtonItem = self.rightAllItem;
    }
}

#pragma mark - setter
-(void)setSubjectTitle:(NSString *)subjectTitle {
    _subjectTitle = subjectTitle;
    self.title = subjectTitle;
}

-(void)setIsAllSelect:(BOOL)isAllSelect {
    _isAllSelect = isAllSelect;
    self.vc2.isAllSelect = isAllSelect;
    if (isAllSelect) {
        self.selectCount = self.vc2.dataArray.count;
        self.vc2.selectCount = self.vc2.dataArray.count;
        self.title = [NSString stringWithFormat:@"已选中%ld项",self.vc2.dataArray.count];
        [self needShowToolBar:YES animated:YES];
    }else {
        self.title = @"选择文件";
        [self resetSelectCount];
        [self needShowToolBar:NO animated:YES];
    }
}

#pragma mark - resetData
-(void)resetSelectCount {
    self.selectCount = 0;
    self.vc2.selectCount = 0;
    self.vc2.isAllSelect = NO;
}

-(void)resetItemsData {
    if (self.selectCount>1) {
        self.toolBar.itemsArray = @[@{@"imageName":@"",@"title":@"下载"},
        @{@"imageName":@"",@"title":@"转存云盘"},
        @{@"imageName":@"",@"title":@"移动"},
        @{@"imageName":@"",@"title":@"删除"}];
    }else {
        self.toolBar.itemsArray = @[@{@"imageName":@"",@"title":@"下载"},
        @{@"imageName":@"",@"title":@"转存云盘"},
        @{@"imageName":@"",@"title":@"删除"},
        @{@"imageName":@"",@"title":@"更多"}];
    }
}

#pragma mark - lazy load
-(ShareGroupDetailInfoHeadSegementView *)headView {
    if (!_headView) {
        _headView = [ShareGroupDetailInfoHeadSegementView new];
        _headView.delegate = self;
    }
    return _headView;
}

-(ShareGroupDetailInfoToolBarView *)toolBar {
    if (!_toolBar) {
        _toolBar = [ShareGroupDetailInfoToolBarView new];
        _toolBar.delegate = self;
        _toolBar.backgroundColor = UIColor.whiteColor;
        _toolBar.layer.shadowColor = UIColor.blackColor.CGColor;
        _toolBar.layer.shadowOpacity = 0.5;
        _toolBar.layer.shadowOffset = CGSizeMake(8, 8);
        _toolBar.layer.shadowRadius = 10;
    }
    return _toolBar;
}

-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-kHeadViewHeight-kStatusBarAndNavigationBarHeight);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

#pragma mark - ShareGroupDetailInfoToolBarViewDelegate
-(void)didSelectIndexWithOperateType:(ShareGroupFileOperateType)operateType {
    switch (operateType) {
        case ShareGroupFileOperateTypeDownload:
            [TipProgress showText:@"下载"];
            break;
        case ShareGroupFileOperateTypeSave:
            break;
        case ShareGroupFileOperateTypeDelete:
            break;
        case ShareGroupFileOperateTypeMove:
            break;
        case ShareGroupFileOperateTypeMore:
            break;
        default:
            break;
    }
}

#pragma mark - ShareGroupDetailInfoHeadSegementViewDelegate
-(void)headViewSelectAtIndex:(int)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (index==0) {
        self.title = self.subjectTitle;
        self.navigationItem.rightBarButtonItem = nil;
        [self needShowToolBar:NO animated:NO];
    }else {
        self.title = @"选择文件";
    }
    if (index==0) {
        [self resetSelectCount];
    }
}

#pragma mark - GroupFileViewControllerDelegate
-(void)selectCountChange:(NSInteger)selectCount {
    self.selectCount = selectCount;
    if (selectCount==0) {
        self.title = @"选择文件";
        [self needShowToolBar:NO animated:YES];
    }else {
        self.title = [NSString stringWithFormat:@"已选中%ld项",selectCount];
        [self needShowToolBar:YES animated:YES];
        [self resetItemsData];
    }
    
    self.navigationItem.rightBarButtonItem = self.rightAllItem;
    if (selectCount == self.vc2.dataArray.count) {
        self.navigationItem.rightBarButtonItem = self.rightItem;
    }
}

-(void)needShowToolBar:(BOOL)show animated:(BOOL)animated {
    if (show) {
        if (animated) {
            [UIView animateWithDuration:0.35 animations:^{
                self.toolBar.transform = CGAffineTransformMakeTranslation(0, -kToolBarHeight);
            }];
        }else{
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, -kToolBarHeight);
        }
    }else {
        if (animated) {
            [UIView animateWithDuration:0.35 animations:^{
                self.toolBar.transform = CGAffineTransformIdentity;
            }];
        }else {
            self.toolBar.transform = CGAffineTransformIdentity;
        }
    }
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childVcsArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIViewController *vc = self.childVcsArray[indexPath.item];
    [cell.contentView addSubview:vc.view];
    vc.view.frame = cell.contentView.bounds;
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    [self.headView selectAtIndex:page];
    if (page==0) {
        self.navigationItem.rightBarButtonItem = nil;
        [self resetSelectCount];
        [self needShowToolBar:NO animated:YES];
    }
}
@end
