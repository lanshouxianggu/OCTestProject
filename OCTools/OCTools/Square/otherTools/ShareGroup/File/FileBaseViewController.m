//
//  FileBaseViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/7.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "FileBaseViewController.h"
#import "FileBaseReusableView.h"
#import "FileBaseFlowCell.h"
#import "FileBaseListCell.h"
#import "FileBaseModel.h"
#import "FileModel.h"
#import "LCLongPressGestureRecognizer.h"
#import "FileVerticalIndicatorView.h"

#define kSmallItemWidth      (SCREEN_WIDTH-24-self.minimumColoumSpace*9)/10
#define kMediumItemWidth     (SCREEN_WIDTH-24-self.minimumColoumSpace*3)/4
#define kBigItemWidth        (SCREEN_WIDTH-24-self.minimumColoumSpace)/2

#define kSmallItemSize       CGSizeMake(kSmallItemWidth,kSmallItemWidth)
#define kMediumItemSize      CGSizeMake(kMediumItemWidth,kMediumItemWidth)
#define kBigItemSize         CGSizeMake(kBigItemWidth,kBigItemWidth)
#define kListItemSize        CGSizeMake(SCREEN_WIDTH, 60)
#define kHeaderReferenceSize CGSizeMake(SCREEN_WIDTH, 50)

#define kIndicatorViewWidth  50
#define kIndicatorViewHeight 30

typedef NS_ENUM(NSUInteger, FileSortType) {
    FileSortTypeList,       //列表模式
    FileSortTypeSmall,      //小图模式
    FileSortTypeMedium,     //中图模式
    FileSortTypeBig,         //大图模式
};

@interface FileBaseViewController () <UICollectionViewDelegate,UICollectionViewDataSource,FileBaseReusableViewDelegate,FileBaseListCellDelegate,FileVerticalIndicatorViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionViewFlowLayout *listLayout;
@property (nonatomic, assign) NSInteger minimumRowSpace;
@property (nonatomic, assign) NSInteger minimumColoumSpace;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, strong) FileBaseFlowCell *lastSelectCell;
@property (nonatomic, assign) BOOL canSelect;
@property (nonatomic, assign) BOOL isHeadViewSelect;
@property (nonatomic, assign) FileSortType sortType;
@property (nonatomic, strong) FileVerticalIndicatorView *indicatorView;
@property (nonatomic, assign) BOOL isIndicatorViewMoving;
@property (nonatomic, assign) CGPoint indicatorViewMoveLastPoint;
@property (nonatomic, assign) CGFloat indicatorViewOriginY;
@property (nonatomic, assign) BOOL canShowIndicatorView;


@property (nonatomic, strong) UIBarButtonItem *backBarItem;
@property (nonatomic, strong) UIBarButtonItem *cancelBarItem;
@property (nonatomic, strong) UIBarButtonItem *sortBarItem;
@property (nonatomic, strong) UIBarButtonItem *allSelectBarItem;
@property (nonatomic, strong) UIBarButtonItem *allUnSelectBarItem;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FileBaseViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DF_COLOR_BGMAIN;
    self.canSelect = NO;
    self.isHeadViewSelect = NO;
    self.canShowIndicatorView = YES;
    
    self.minimumRowSpace = 2;
    self.minimumColoumSpace = 2;
    self.sortType = FileSortTypeMedium;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottomMargin.offset(0);
    }];
    
    [self.view addSubview:self.indicatorView];
        
    self.navigationItem.rightBarButtonItem = self.sortBarItem;
    [self initData];
}

#pragma mark - setter
-(void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.title = navTitle;
}

-(void)setSortType:(FileSortType)sortType {
    _sortType = sortType;
    __weak typeof(self) weakSelf = self;

    if (sortType==FileSortTypeList) {
        [self.collectionView setCollectionViewLayout:self.listLayout];
        [self.collectionView reloadData];
    }else{
        [self.collectionView setCollectionViewLayout:sortType==FileSortTypeList?self.listLayout:self.layout animated:YES completion:^(BOOL finished) {
            [weakSelf.collectionView reloadData];
        }];
        [self.collectionView reloadData];
    }
}

-(void)updateTitle {
    NSInteger selectCount = 0;
    for (FileBaseModel *model in self.dataArray) {
        selectCount += model.selectCount;
    }
    NSString *title = [NSString stringWithFormat:@"已选择%ld项",selectCount];
    self.title = selectCount>0?title:@"选择文件";
}

#pragma mark - initiation
-(void)initData {
    self.title = self.navTitle;
    [self.dataArray removeAllObjects];
    NSMutableArray *fileArrayOne = [NSMutableArray new];
    NSMutableArray *fileArrayTwo = [NSMutableArray new];
    for (int i=0; i<7; i++) {
        FileModel *model = [FileModel new];
        model.isSelect = NO;
        [fileArrayOne addObject:model];
    }
    for (int i=0; i<58; i++) {
        FileModel *model = [FileModel new];
        model.isSelect = NO;
        [fileArrayTwo addObject:model];
    }
    FileBaseModel *dataOne = [FileBaseModel new];
    dataOne.isAllSelect = NO;
    dataOne.dataArray = fileArrayOne;
    dataOne.selectCount = 0;
    FileBaseModel *dataTwo = [FileBaseModel new];
    dataTwo.isAllSelect = NO;
    dataTwo.dataArray = fileArrayTwo;
    dataTwo.selectCount = 0;
    
    [self.dataArray addObject:dataOne];
    [self.dataArray addObject:dataTwo];
}

#pragma mark - lazy load
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

-(FileVerticalIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[FileVerticalIndicatorView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-kIndicatorViewWidth+kIndicatorViewHeight/2, 0, kIndicatorViewWidth, kIndicatorViewHeight)];
        _indicatorView.delegate = self;
        _indicatorView.alpha = 0;
        self.indicatorViewOriginY = _indicatorView.frame.origin.y;
    }
    return _indicatorView;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = DF_COLOR_BGMAIN;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.allowsMultipleSelection = YES;
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"FileBaseReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FileBaseReusableView"];
        [_collectionView registerNib:[UINib nibWithNibName:@"FileBaseFlowCell" bundle:nil] forCellWithReuseIdentifier:@"FileBaseFlowCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"FileBaseListCell" bundle:nil] forCellWithReuseIdentifier:@"FileBaseListCell"];
        
        //KVO
        [_collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.itemSize = kMediumItemSize;
        _layout.minimumLineSpacing = self.minimumColoumSpace;
        _layout.minimumInteritemSpacing = self.minimumRowSpace;
        _layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);
    }
    return _layout;
}

-(UICollectionViewFlowLayout *)listLayout {
    if (!_listLayout) {
        _listLayout = [[UICollectionViewFlowLayout alloc] init];
        _listLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _listLayout.itemSize = kListItemSize;
        _listLayout.minimumLineSpacing = self.minimumColoumSpace;
        _listLayout.minimumInteritemSpacing = self.minimumRowSpace;
        _listLayout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _listLayout.headerReferenceSize = CGSizeZero;
    }
    return _listLayout;
}

-(UIBarButtonItem *)backBarItem {
    if (!_backBarItem) {
        _backBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    }
    return _backBarItem;
}

-(UIBarButtonItem *)cancelBarItem {
    if (!_cancelBarItem) {
        _cancelBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    }
    return _cancelBarItem;
}

-(UIBarButtonItem *)sortBarItem {
    if (!_sortBarItem) {
        _sortBarItem = [[UIBarButtonItem alloc] initWithTitle:@"排序" style:UIBarButtonItemStylePlain target:self action:@selector(sortAction)];
    }
    return _sortBarItem;
}

-(UIBarButtonItem *)allSelectBarItem {
    if (!_allSelectBarItem) {
        _allSelectBarItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(allSelectAction)];
    }
    return _allSelectBarItem;
}

-(UIBarButtonItem *)allUnSelectBarItem {
    if (!_allUnSelectBarItem) {
        _allUnSelectBarItem = [[UIBarButtonItem alloc] initWithTitle:@"全不选" style:UIBarButtonItemStylePlain target:self action:@selector(allUnSelectAction)];
    }
    return _allUnSelectBarItem;
}

#pragma mark - kvo
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat contentSizeHeight = self.collectionView.contentSize.height;
        
        //如果高度小于2屏的collectionView则不显示indicatorView
        if (contentSizeHeight <= 2*CGRectGetHeight(self.collectionView.frame)) {
            self.indicatorView.alpha = 0;
            self.canShowIndicatorView = NO;
        }else {
            self.canShowIndicatorView = YES;
        }
    }
}

#pragma mark - action
-(void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cancelAction {
    self.canSelect = NO;
    //重置数据
    [self initData];
//    [self updateTitle];
    [self.collectionView reloadData];
    self.navigationItem.leftBarButtonItem = self.backBarItem;
    self.navigationItem.rightBarButtonItem = self.sortBarItem;
}

-(void)sortAction {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"选择排序方式" preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"列表模式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakSelf.sortType==FileSortTypeList) {
            return;
        }
        weakSelf.sortType = FileSortTypeList;
    }];
    
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"小图模式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakSelf.sortType==FileSortTypeSmall) {
            return;
        }
        weakSelf.layout.itemSize = kSmallItemSize;
        weakSelf.layout.headerReferenceSize = kHeaderReferenceSize;
        weakSelf.sortType = FileSortTypeSmall;
    }];
    
    UIAlertAction *actionC = [UIAlertAction actionWithTitle:@"中图模式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakSelf.sortType==FileSortTypeMedium) {
            return;
        }
        weakSelf.layout.itemSize = kMediumItemSize;
        weakSelf.layout.headerReferenceSize = kHeaderReferenceSize;
        weakSelf.sortType = FileSortTypeMedium;
    }];
    
    UIAlertAction *actionD = [UIAlertAction actionWithTitle:@"大图模式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakSelf.sortType==FileSortTypeBig) {
            return;
        }
        weakSelf.layout.itemSize = kBigItemSize;
        weakSelf.layout.headerReferenceSize = kHeaderReferenceSize;
        weakSelf.sortType = FileSortTypeBig;
    }];
    
    UIAlertAction *actionE = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionA setValue:UIColor.darkGrayColor forKey:@"titleTextColor"];
    [actionB setValue:UIColor.darkGrayColor forKey:@"titleTextColor"];
    [actionC setValue:UIColor.darkGrayColor forKey:@"titleTextColor"];
    [actionD setValue:UIColor.darkGrayColor forKey:@"titleTextColor"];
    
    [alertVC addAction:actionA];
    [alertVC addAction:actionB];
    [alertVC addAction:actionC];
    [alertVC addAction:actionD];
    [alertVC addAction:actionE];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)allSelectAction {
    self.navigationItem.rightBarButtonItem = self.allUnSelectBarItem;
    
    [self selectAllData:YES];
}

-(void)allUnSelectAction {
    self.navigationItem.rightBarButtonItem = self.allSelectBarItem;
    
    [self selectAllData:NO];
}

-(void)selectAllData:(BOOL)select {
    int index = 0;
    for (FileBaseModel *baseModel in self.dataArray) {
        baseModel.isAllSelect = select;
        baseModel.selectCount = select?baseModel.dataArray.count:0;
        for (FileModel *model in baseModel.dataArray) {
            model.isSelect = select;
        }
        index++;
    }
    [self.collectionView reloadData];
    [self updateTitle];
}

#pragma mark - UICollectionViewDelegate、UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    FileBaseModel *model = self.dataArray[section];
    return model.dataArray.count;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FileBaseReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FileBaseReusableView" forIndexPath:indexPath];
                
        reusableView.backgroundColor = DF_COLOR_BGMAIN;
        reusableView.selectImageV.hidden = !self.canSelect;
        reusableView.dateLabelLeftLayout.constant = self.canSelect?44:12;
        reusableView.currentIndexPath = indexPath;
        reusableView.delegate = self;
        reusableView.selectBtn.enabled = self.canSelect;
        
        if (self.canSelect) {
            FileBaseModel *model = self.dataArray[indexPath.section];
            reusableView.selectBtn.selected = model.isAllSelect;
            reusableView.selected = model.isAllSelect;
        }
    }
    return reusableView;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.sortType == FileSortTypeList) {
        FileBaseListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FileBaseListCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        cell.delegate = self;
        FileBaseModel *model = self.dataArray[indexPath.section];
        FileModel *fileModel = model.dataArray[indexPath.row];
        cell.selectBtn.selected = fileModel.isSelect;
        
        return cell;
    }
    FileBaseFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FileBaseFlowCell" forIndexPath:indexPath];
    cell.selectImageV.hidden = !self.canSelect;
    cell.layer.cornerRadius = 4;
    cell.backgroundColor = UIColor.purpleColor;
    
    FileBaseModel *model = self.dataArray[indexPath.section];
    FileModel *fileModel = model.dataArray[indexPath.row];
    cell.cellSelected = fileModel.isSelect;
    
    if (self.sortType==FileSortTypeBig||self.sortType==FileSortTypeMedium) {
        LCLongPressGestureRecognizer *longPressGes = [[LCLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPressGes.indexPath = indexPath;
        [cell.contentView addGestureRecognizer:longPressGes];
    }else {
    }
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sortType==FileSortTypeList) {
        return;
    } else if (self.sortType==FileSortTypeSmall) {
        self.sortType = FileSortTypeMedium;
        self.layout.itemSize = kMediumItemSize;
        self.layout.headerReferenceSize = kHeaderReferenceSize;
        [self.collectionView reloadData];
    } else {
        FileBaseFlowCell *cell = (FileBaseFlowCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell.cellSelected) {
            //全选状态改变后，每个cell的选择状态会取反
            [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
            return;
        }
        
        cell.cellSelected = YES;
        FileBaseModel *model = self.dataArray[indexPath.section];
        FileModel *fileModel = model.dataArray[indexPath.row];
        fileModel.isSelect = YES;
        model.selectCount++;
        if (model.selectCount==model.dataArray.count) {
            model.isAllSelect = YES;
            [self collectionView:collectionView viewForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
            if (self.isHeadViewSelect) {
                [self collectionView:collectionView viewForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
                self.isHeadViewSelect = NO;
            }
        }
        
        [self updateTitle];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sortType==FileSortTypeList) {
        return;
    }else {
        FileBaseFlowCell *cell = (FileBaseFlowCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (!cell.cellSelected) {
            //全选状态改变后，每个cell的选择状态会取反
            [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
            return;
        }
        cell.cellSelected = NO;
        FileBaseModel *model = self.dataArray[indexPath.section];
        model.selectCount--;
        model.isAllSelect = NO;
        FileModel *fileModel = model.dataArray[indexPath.row];
        fileModel.isSelect = NO;
        
        [self collectionView:collectionView viewForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (self.isHeadViewSelect) {
            [self collectionView:collectionView viewForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
            self.isHeadViewSelect = NO;
        }
        
        [self updateTitle];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isIndicatorViewMoving) {
        return;
    }
    if (self.canShowIndicatorView) {
        self.indicatorView.alpha = 1;
        CGFloat insetBottom = self.collectionView.contentInset.bottom;
        if (@available(iOS 11.0, *)) {
            insetBottom = self.collectionView.adjustedContentInset.bottom;
        }
        CGFloat movingHeight = CGRectGetHeight(self.view.frame) - insetBottom - CGRectGetHeight(self.indicatorView.frame) - self.collectionView.contentInset.top; //calendarView可移动的总高度
        CGFloat contentHeight = self.collectionView.contentSize.height - CGRectGetHeight(self.collectionView.frame) + insetBottom; //scrollView可移动的总高度
        
        CGFloat movingScale = (self.collectionView.contentOffset.y + self.collectionView.contentInset.top) / contentHeight; //scrollView移动比例
        CGFloat newOriginY = movingHeight * movingScale + self.collectionView.contentInset.top; //通过比例计算calendarView的Y值
        
        CGFloat maxY = movingHeight + self.collectionView.contentInset.top;
        if (newOriginY < self.collectionView.contentInset.top) {
            newOriginY = self.collectionView.contentInset.top;
        }else if (newOriginY >= maxY) {
            newOriginY = maxY;
        }
        self.indicatorView.frame = CGRectMake(CGRectGetMinX(self.indicatorView.frame), newOriginY, CGRectGetWidth(self.indicatorView.frame), CGRectGetHeight(self.indicatorView.frame));
        self.indicatorViewOriginY = self.indicatorView.frame.origin.y;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.35 animations:^{
            self.indicatorView.alpha = 0;
        }];
    });
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.35 animations:^{
                self.indicatorView.alpha = 0;
            }];
        });
    }
}

#pragma mark - longPressAction
-(void)longPressAction:(LCLongPressGestureRecognizer *)sender {
    if (self.canSelect || self.sortType==FileSortTypeSmall) {
        return;
    }

    //设置当前长按的cell为选中状态，且选择数量+1
    NSIndexPath *indexPath = sender.indexPath;
    FileBaseModel *model = self.dataArray[indexPath.section];
    FileModel *fileModel = model.dataArray[indexPath.row];
    fileModel.isSelect = YES;
    model.selectCount += 1;
    [self.dataArray replaceObjectAtIndex:indexPath.section withObject:model];

    self.canSelect = YES;
    [self.collectionView reloadData];
    self.navigationItem.leftBarButtonItem = self.cancelBarItem;
    self.navigationItem.rightBarButtonItem = self.allSelectBarItem;

    [self updateTitle];
}

#pragma mark - FileBaseReusableViewDelegate
-(void)headViewSelect:(BOOL)select andIndexPath:(NSIndexPath *)indexPath {
    self.isHeadViewSelect = YES;
    FileBaseModel *baseModel = self.dataArray[indexPath.section];
    baseModel.isAllSelect = select;
    baseModel.selectCount = select?baseModel.dataArray.count:0;
    for (FileModel *model in baseModel.dataArray) {
        model.isSelect = select;
    }

    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
//    [self.collectionView reloadSections:indexSet];
    [UIView animateWithDuration:0 animations:^{
        [self.collectionView performBatchUpdates:^{
            [self.collectionView reloadSections:indexSet];
        } completion:nil];
    }];
    
    [self updateTitle];
}

#pragma mark - FileBaseListCellDelegate
-(void)listCellSelectAction:(BOOL)select andIndexPath:(NSIndexPath *)indexPath {
    FileBaseModel *model = self.dataArray[indexPath.section];
    FileModel *fileModel = model.dataArray[indexPath.row];
    fileModel.isSelect = select;
    model.selectCount = select?model.selectCount+1:model.selectCount-1;
    
    NSInteger allSelectCount = 0;
    NSInteger allCount = 0;
    for (FileBaseModel *model in self.dataArray) {
        allCount += model.dataArray.count;
        allSelectCount += model.selectCount;
    }
    self.navigationItem.leftBarButtonItem = allSelectCount>0?self.cancelBarItem:self.backBarItem;
    self.navigationItem.rightBarButtonItem = allSelectCount==allCount?self.allUnSelectBarItem:self.allSelectBarItem;
    [self updateTitle];
    
//    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:indexPath.section];
//    [self.collectionView reloadSections:set];
}

#pragma mark - FileVerticalIndicatorViewDelegate
-(void)indicatorViewMovedToPoint:(CGPoint)point andState:(UIGestureRecognizerState)state {
//    CGFloat offSetY = self.collectionView.contentSize.height*point.y/self.collectionView.frame.size.height;
//    self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x, offSetY);
    if (state == UIGestureRecognizerStateBegan) {
        self.isIndicatorViewMoving = YES;
        self.indicatorViewMoveLastPoint = point;
    }else if (state == UIGestureRecognizerStateEnded) {
        self.isIndicatorViewMoving = NO;
        
    }
    
    if (state == UIGestureRecognizerStateChanged) {
        CGFloat insetBottom = self.collectionView.contentInset.bottom;
        if (@available(iOS 11.0, *)) {
            insetBottom = self.collectionView.adjustedContentInset.bottom;
        }
        CGFloat maxY = CGRectGetHeight(self.view.frame)-insetBottom-CGRectGetHeight(self.indicatorView.frame);
        
        //移动indicatorView
        CGFloat moveDistance = point.y-self.indicatorViewMoveLastPoint.y;
        CGFloat newOriginY = self.indicatorViewOriginY+moveDistance;
        if (newOriginY < self.collectionView.contentInset.top) {
            newOriginY = self.collectionView.contentInset.top;
        }else if (newOriginY >= maxY) {
            newOriginY = maxY;
        }
        CGRect newFrame = self.indicatorView.frame;
        newFrame.origin.y = newOriginY;
        self.indicatorView.frame = newFrame;
        self.indicatorViewOriginY = newOriginY;
        self.indicatorViewMoveLastPoint = point;
        
        //移动collectionView
        CGFloat movingHeight = CGRectGetHeight(self.view.frame)-insetBottom-CGRectGetHeight(self.indicatorView.frame)-self.collectionView.contentInset.top;
        CGFloat contentHeight = self.collectionView.contentSize.height-CGRectGetHeight(self.collectionView.frame)+insetBottom;
        CGFloat movingScale = (newOriginY-self.collectionView.contentInset.top)/movingHeight;
        CGFloat contentOffsetY = movingScale*contentHeight-self.collectionView.contentInset.top;
        if (movingScale >= 1.0) {
            contentOffsetY = movingScale*contentHeight;
        }
        self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x, contentOffsetY);
    }
    
}
@end
