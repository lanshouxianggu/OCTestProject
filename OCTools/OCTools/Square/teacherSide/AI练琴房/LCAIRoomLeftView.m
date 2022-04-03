//
//  LCAIRoomLeftView.m
//  OCTools
//
//  Created by 刘创 on 2022/4/3.
//

#import "LCAIRoomLeftView.h"

@interface LCAIRoomLeftView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGSize itemSize;
@end

@implementation LCAIRoomLeftView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.randomColor;
    return cell;
}

+(CGFloat)collectionViewItemWidth {
    CGFloat itemX = 10;
    CGFloat width = (SCREEN_WIDTH*2/3 - itemX-2) / 4;
    if (isPad) {
        width = (SCREEN_WIDTH*2/3-160)/3;
    }else if (isIPhoneX) {
        width = (SCREEN_WIDTH/2+itemX*3) / 4;
    }
    return width;
}

+(CGFloat)leftCollectionViewWidth {
    CGFloat width = [LCAIRoomLeftView collectionViewItemWidth];
    CGFloat collectWidth = width*4+3;
    if (isPad) {
        collectWidth = width*3+2;
    }
    return collectWidth;
}

#pragma mark - lazy
-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat width = [LCAIRoomLeftView collectionViewItemWidth];
        self.itemSize = CGSizeMake(width, width);
        _layout.itemSize = CGSizeMake(width, width);
        _layout.minimumLineSpacing = 1;
        _layout.minimumInteritemSpacing = 0;
        _layout.sectionInset = UIEdgeInsetsZero;
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColor.blackColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}
@end
