//
//  OTLPracticePianoTaskSecondPartView.m
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import "OTLPracticePianoTaskSecondPartView.h"
#import "OTLPracticePianoTaskSecondPartCell.h"

@interface OTLPracticePianoTaskSecondPartView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSArray <UIImage *> *normalImagesArray;
@property (nonatomic, strong) NSArray <UIImage *> *selectImagesArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *subTitlesArray;
@property (nonatomic, assign) BOOL isFirstTimeIn;
@end

@implementation OTLPracticePianoTaskSecondPartView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.normalImagesArray = @[
            [UIImage imageNamed:@"icon_jichu_gray"],
            [UIImage imageNamed:@"icon_tisheng_gray"],
            [UIImage imageNamed:@"icon_ceping_gray"]];
        self.selectImagesArray = @[
            [UIImage imageNamed:@"icon_jichu"],
            [UIImage imageNamed:@"icon_tisheng"],
            [UIImage imageNamed:@"icon_ceping"]];
        self.titlesArray = @[@"基础",@"提升",@"测评"];
        self.subTitlesArray = @[@"错音纠正",@"节奏规范",@"成果检测"];
        self.isFirstTimeIn = YES;
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
    OTLPracticePianoTaskSecondPartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OTLPracticePianoTaskSecondPartCell" forIndexPath:indexPath];
    
    cell.partImageView.image = self.normalImagesArray[indexPath.item];
    cell.titleLabel.text = self.titlesArray[indexPath.item];
    cell.subTitleLabel.text = self.subTitlesArray[indexPath.item];
    cell.selectImageView.hidden = YES;

    
    if (indexPath.item==0) {
        [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        cell.partImageView.image = self.selectImagesArray[indexPath.item];
        cell.mainView.backgroundColor = UIColorFromRGB(0xFFF8EB);
        cell.selectImageView.hidden = NO;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isFirstTimeIn && indexPath.item!=0) {
        [self collectionView:collectionView didDeselectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    }
    OTLPracticePianoTaskSecondPartCell *cell = (OTLPracticePianoTaskSecondPartCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.partImageView.image = self.selectImagesArray[indexPath.item];
    cell.mainView.backgroundColor = UIColorFromRGB(0xFFF8EB);
    cell.selectImageView.hidden = NO;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    OTLPracticePianoTaskSecondPartCell *cell = (OTLPracticePianoTaskSecondPartCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.partImageView.image = self.normalImagesArray[indexPath.item];
    cell.mainView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    cell.selectImageView.hidden = YES;
}

#pragma mark - lazy
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"OTLPracticePianoTaskSecondPartCell" bundle:nil] forCellWithReuseIdentifier:@"OTLPracticePianoTaskSecondPartCell"];
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
