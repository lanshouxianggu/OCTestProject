//
//  MCCommonSearchHistoryView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCommonSearchHistoryView.h"
#import "MCCommonSearchTitleCell.h"
#import <objc/message.h>
#import "MCCommonSearchTitleModel.h"

@interface MCCommonSearchHistoryView ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
MCCommonSearchTitleCellDelegate
>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray * infoArr;
@end

@implementation MCCommonSearchHistoryView

-(instancetype)init {
    if (self = [super init]) {
        [self initData];
        [self setupUI];
    }
    return self;
}


-(void)initData {
    self.infoArr = [NSMutableArray arrayWithCapacity:0];
    NSArray *strArr = @[@"教程",@"成都的风景",@"手机里的图片",@"手机里的图片和视频",@"手机里的图片和视频",@"共享群",@"成都的风景",@"手机里的图片"];
    for (int i = 0; i < 8; i++) {
        MCCommonSearchTitleModel *model = [MCCommonSearchTitleModel new];
        NSString *str = strArr[i];
        model.searchTitle = str;
        if (str.length > 8) {
            str = [str substringToIndex:8];
            model.displayTitle = [str stringByAppendingString:@"..."];
        }else{
            model.displayTitle = str;
        }
        [self.infoArr addObject:model];
    }
}


-(void)setupUI {
    [self addSubview:self.clearHistoryView];
    [self.clearHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.clearHistoryView.mas_bottom);
    }];
}

#pragma mark - setter
-(void)setSearchKey:(NSString *)searchKey {
    _searchKey = searchKey;
    MCCommonSearchTitleModel *model = [MCCommonSearchTitleModel new];
    NSString *str = searchKey;
    model.searchTitle = str;
    if (str.length > 8) {
        str = [str substringToIndex:8];
        model.displayTitle = [str stringByAppendingString:@"..."];
    }else{
        model.displayTitle = str;
    }
    [self.infoArr addObject:model];
    [self.collectionView reloadData];
}

#pragma mrak - lazyload
-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 20;
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.sectionInset = UIEdgeInsetsMake(10, 20, 0, 20);
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:MCCommonSearchTitleCell.class forCellWithReuseIdentifier:@"MCCommonSearchTitleCell"];
        
        SEL sel = NSSelectorFromString(@"_setRowAlignmentsOptions:");
        if ([_collectionView.collectionViewLayout respondsToSelector:sel]) {
            ((void(*)(id,SEL,NSDictionary*))objc_msgSend)(_collectionView.collectionViewLayout,sel,
                                                          @{@"UIFlowLayoutCommonRowHorizontalAlignmentKey":@(NSTextAlignmentLeft),
                                                            @"UIFlowLayoutLastRowHorizontalAlignmentKey" : @(NSTextAlignmentLeft),
                                                            @"UIFlowLayoutRowVerticalAlignmentKey" : @(NSTextAlignmentCenter)});
        }
    }
    return _collectionView;
}

-(UIView *)clearHistoryView {
    if (!_clearHistoryView) {
        _clearHistoryView = [UIView new];
        _clearHistoryView.backgroundColor = UIColor.whiteColor;
        
        UILabel *lab = [UILabel new];
        lab.text = @"搜索历史";
        lab.textColor = UIColor.darkTextColor;
        lab.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        
        [_clearHistoryView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.offset(0);
        }];
        
        UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [touchBtn addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
        [_clearHistoryView addSubview:touchBtn];
        [touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"clean_icon"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_clearHistoryView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.right.offset(-15);
            make.size.mas_equalTo(CGSizeMake(32, 32));
        }];
        
    }
    return _clearHistoryView;
}

-(void)touchAction {
    [self.superview endEditing:YES];
}

-(void)cleanAction {
    [self.infoArr removeAllObjects];
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //高度计算 放在model进行
    MCCommonSearchTitleModel *model = self.infoArr[indexPath.item];
    return model.titleRect;
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDatasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _infoArr.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MCCommonSearchTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCCommonSearchTitleCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    MCCommonSearchTitleModel *model = self.infoArr[indexPath.item];
    cell.titleLabel.text = model.displayTitle;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MCCommonSearchTitleModel *model = self.infoArr[indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectSearchItemWithSearchKey:)]) {
        [self.delegate didSelectSearchItemWithSearchKey:model.searchTitle];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[self superview] endEditing:YES];
}

#pragma mark - MCCommonSearchTitleCellDelegate
-(void)didClickDeleteAtIndexPath:(NSIndexPath *)indexPath {
    MCCommonSearchTitleModel *deleteModel = self.infoArr[indexPath.item];
    [self.infoArr removeObject:deleteModel];
    [self.collectionView reloadData];
}
@end
