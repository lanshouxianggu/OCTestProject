//
//  OTLPracticePianoTaskSecondPartView.m
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import "OTLPracticePianoTaskSecondPartView.h"

@interface OTLPracticePianoTaskSecondPartView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation OTLPracticePianoTaskSecondPartView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI {
    UILabel *lab = [UILabel new];
    lab.text = @"环节要求";
    lab.textColor = UIColorFromRGB(0x3b3b3b);
    lab.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(15);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.bottom.right.offset(-15);
        make.height.mas_equalTo(72);
    }];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.cyanColor;
    
    return cell;
}

#pragma mark - lazy
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(240, 72);
        _layout.minimumLineSpacing = 15;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}
@end
