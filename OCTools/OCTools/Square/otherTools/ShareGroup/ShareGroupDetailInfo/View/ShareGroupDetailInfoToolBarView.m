//
//  ShareGroupDetailInfoToolBarView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/5.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ShareGroupDetailInfoToolBarView.h"
#import "ShareGroupDetailInfoItemCell.h"

#define kCollectionViewHeight 50

@interface ShareGroupDetailInfoToolBarView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ShareGroupDetailInfoToolBarView

-(instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.collectionView];
}

-(void)setItemsArray:(NSArray *)itemsArray {
    _itemsArray = itemsArray;
    [self.collectionView reloadData];
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/4, kCollectionViewHeight);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kCollectionViewHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"ShareGroupDetailInfoItemCell" bundle:nil] forCellWithReuseIdentifier:@"ShareGroupDetailInfoItemCell"];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShareGroupDetailInfoItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShareGroupDetailInfoItemCell" forIndexPath:indexPath];
    NSDictionary *dataDic = self.itemsArray[indexPath.item];
    cell.titleLabel.text = dataDic[@"title"];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dataDic = self.itemsArray[indexPath.item];
    NSString *operateStr = dataDic[@"title"];
    ShareGroupFileOperateType operateType = ShareGroupFileOperateTypeDownload;
    if ([operateStr isEqualToString:@"下载"]) {
        operateType = ShareGroupFileOperateTypeDownload;
    }else if ([operateStr isEqualToString:@"转存云盘"]) {
        operateType = ShareGroupFileOperateTypeSave;
    }else if ([operateStr isEqualToString:@"移动"]) {
        operateType = ShareGroupFileOperateTypeMove;
    }else if ([operateStr isEqualToString:@"删除"]) {
        operateType = ShareGroupFileOperateTypeDelete;
    }else if ([operateStr isEqualToString:@"更多"]) {
        operateType = ShareGroupFileOperateTypeMore;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectIndexWithOperateType:)]) {
        [self.delegate didSelectIndexWithOperateType:operateType];
    }
}

@end
