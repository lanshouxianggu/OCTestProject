//
//  MCDiscoveryAllColumnViewController.m
//  ChatClub
//
//  Created by 刘创 on 2021/7/16.
//  Copyright © 2021 ArcherMind. All rights reserved.
//

#import "MCDiscoveryAllColumnViewController.h"
#import "MCDiscoveryColumnCell.h"
#import "BMDragCellCollectionView.h"

@interface MCDiscoveryAllColumnViewController () <BMDragCellCollectionViewDelegate,BMDragCollectionViewDataSource>
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIView *tipsView;
@property (nonatomic, strong) BMDragCellCollectionView *collectionView;
@property (nonatomic, copy) NSString *currentSelectTitle;
@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, assign) NSInteger currentSelectIndex;
@end

@implementation MCDiscoveryAllColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"所有栏目";
}

-(instancetype)initWithTitleArray:(NSArray *)titlesArray currentSelectIndex:(NSInteger)currentSelectInde {
    if (self = [super init]) {
        self.titlesArray = [NSMutableArray arrayWithArray:titlesArray];
        self.currentSelectIndex = currentSelectInde;
        self.currentSelectTitle = [self.titlesArray objectAtIndex:self.currentSelectIndex]?:@"";
        
        [self addNavigationView];
        [self addTipsView];
        [self addCollectionView];
    }
    return self;
}

-(void)addNavigationView {
    UIView *naviView = [UIView new];
    naviView.backgroundColor = UIColor.whiteColor;
    self.navigationView = naviView;
    [self.view addSubview:naviView];
    [naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(kStatusBarAndNavigationBarHeight);
    }];
    
    UIView *naviMainView = [UIView new];
    naviMainView.backgroundColor = UIColor.whiteColor;
    [naviView addSubview:naviMainView];
    [naviMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"所有栏目";
    
    [naviMainView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.offset(0);
    }];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [naviMainView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.right.offset(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
}

-(void)addTipsView {
    UIView *tipsView = [UIView new];
    tipsView.backgroundColor = UIColor.whiteColor;
    self.tipsView = tipsView;
    
    [self.view addSubview:tipsView];
    [tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.navigationView.mas_bottom).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *tipsLabel = [UILabel new];
    tipsLabel.text = @"点击进入栏目   |   长按可拖动排序";
    tipsLabel.textColor = UIColor.grayColor;
    tipsLabel.font = [UIFont systemFontOfSize:14];
    
    [tipsView addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.bottom.offset(-10);
    }];
}

-(void)addCollectionView {
    [self.collectionView registerClass:MCDiscoveryColumnCell.class forCellWithReuseIdentifier:@"MCDiscoveryColumnCell"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(100);
        make.top.equalTo(self.tipsView.mas_bottom).offset(10);
    }];
}

-(BMDragCellCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-15*3-12*2)/4, 40);
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[BMDragCellCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dragCellAlpha = 0.9;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MCDiscoveryColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCDiscoveryColumnCell" forIndexPath:indexPath];
    cell.columnTitleLabel.text = self.titlesArray[indexPath.item];
    cell.mainView.layer.borderWidth = indexPath.item==0?0:1;
    cell.mainView.backgroundColor = indexPath.item==0?UIColor.lightGrayColor:UIColor.whiteColor;
    cell.columnTitleLabel.textColor = indexPath.item==self.currentSelectIndex?UIColor.blueColor:UIColor.blackColor;
    return cell;
}

-(NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView {
    return self.titlesArray;
}

-(void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.titlesArray = [newDataArray mutableCopy];
    NSInteger afterMoveIndex = [self.titlesArray indexOfObject:self.currentSelectTitle];
    self.currentSelectIndex = afterMoveIndex;
}

-(BOOL)dragCellCollectionViewShouldBeginExchange:(BMDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (destinationIndexPath.section == 0 && destinationIndexPath.item == 0) {
        return NO;
    }
    return YES;
}

-(BOOL)dragCellCollectionViewShouldBeginMove:(BMDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.item == 0) {
        return NO;
    }
    return YES;
}

- (void)dragCellCollectionViewDidEndDrag:(BMDragCellCollectionView *)dragCellCollectionView {
    NSLog(@"dragCellCollectionViewDidEndDrag");
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView beganDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    NSLog(@"beganDragAtPoint %@   - %@", NSStringFromCGPoint(point), indexPath);
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView changedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"changedDragAtPoint %@   - %@", NSStringFromCGPoint(point), indexPath);
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    NSLog(@"endedDragAtPoint %@   - %@", NSStringFromCGPoint(point), indexPath);
}

- (BOOL)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView endedDragAutomaticOperationAtPoint:(CGPoint)point section:(NSInteger)section indexPath:(NSIndexPath *)indexPath {
    if (section == 1) {
        // 如果拖到了第一组松开就移动 而且内部不自动处理
        [dragCellCollectionView dragMoveItemToIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        return NO;
    }
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClickItemAtIndex:)]) {
            [self.delegate didClickItemAtIndex:indexPath.item];
        }
    }];
    
}

-(void)closeAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateDataArrayAfterMove:currentIndex:)]) {
        [self.delegate updateDataArrayAfterMove:self.titlesArray currentIndex:self.currentSelectIndex];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
