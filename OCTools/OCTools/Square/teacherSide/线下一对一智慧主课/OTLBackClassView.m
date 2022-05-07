//
//  OTLBackClassView.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLBackClassView.h"

@interface OTLBackClassView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UICollectionView *topCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *topLayout;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UICollectionView *bottomCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *bottomLayout;

@property (nonatomic, assign) CGSize topItemSize;
@property (nonatomic, assign) CGSize bottomItemSize;
@property (nonatomic, assign) CGFloat topViewHeight;
@property (nonatomic, assign) CGFloat bottomViewHeight;
@end

@implementation OTLBackClassView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.topViewHeight = (self.frame.size.height-30)*0.46;
        self.bottomViewHeight = self.frame.size.height-self.topViewHeight-26-15;
        CGFloat topItemHeight = self.topViewHeight-30;
        CGFloat topItemWidth = topItemHeight*5/8;
        self.topItemSize = CGSizeMake(topItemWidth, topItemHeight);
        
        CGFloat bottomItemHeight = self.bottomViewHeight-56-15-30;
        CGFloat bottomItemWidth = bottomItemHeight*3/4;
        self.bottomItemSize = CGSizeMake(bottomItemWidth, bottomItemHeight);
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(15, 15, 26, 15));
    }];
    
    [self.mainView addSubview:self.topCollectionView];
        
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xE5E5E5);
    
    [self.mainView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.topCollectionView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [self.mainView addSubview:self.bottomView];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.topCollectionView]) {
        return 3;
    }
    return 2;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.topCollectionView]) {
        OTLBackClassTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OTLBackClassTopCollectionViewCell" forIndexPath:indexPath];
        
        
        return cell;
    }else if ([collectionView isEqual:self.bottomCollectionView]) {
        OTLBackClassBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OTLBackClassBottomCollectionViewCell" forIndexPath:indexPath];
        
        
        return cell;
    }
    return [UICollectionViewCell new];
}

#pragma mark - lazy
-(UIView *)mainView {
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = UIColor.whiteColor;
        _mainView.layer.cornerRadius = 9;
        _mainView.layer.masksToBounds = YES;
    }
    return _mainView;
}

-(UICollectionView *)topCollectionView {
    if (!_topCollectionView) {
        _topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-30, self.topViewHeight) collectionViewLayout:self.topLayout];
        _topCollectionView.alwaysBounceHorizontal = YES;
        _topCollectionView.delegate = self;
        _topCollectionView.dataSource = self;
        _topCollectionView.backgroundColor = UIColor.whiteColor;
        [_topCollectionView registerClass:OTLBackClassTopCollectionViewCell.class forCellWithReuseIdentifier:@"OTLBackClassTopCollectionViewCell"];
    }
    return _topCollectionView;
}

-(UICollectionViewFlowLayout *)topLayout {
    if (!_topLayout) {
        _topLayout = [[UICollectionViewFlowLayout alloc] init];
        _topLayout.itemSize = self.topItemSize;
        _topLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _topLayout.minimumLineSpacing = 20;
        _topLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    return _topLayout;
}

-(UICollectionView *)bottomCollectionView {
    if (!_bottomCollectionView) {
        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 56, self.frame.size.width-30-30, self.bottomViewHeight-56-15) collectionViewLayout:self.bottomLayout];
        _bottomCollectionView.alwaysBounceHorizontal = YES;
        _bottomCollectionView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _bottomCollectionView.layer.cornerRadius = 9;
        _bottomCollectionView.delegate = self;
        _bottomCollectionView.dataSource = self;
        
        [_bottomCollectionView registerClass:OTLBackClassBottomCollectionViewCell.class forCellWithReuseIdentifier:@"OTLBackClassBottomCollectionViewCell"];
    }
    return _bottomCollectionView;
}

-(UICollectionViewFlowLayout *)bottomLayout {
    if (!_bottomLayout) {
        _bottomLayout = [[UICollectionViewFlowLayout alloc] init];
        _bottomLayout.itemSize = self.bottomItemSize;
        _bottomLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _bottomLayout.minimumLineSpacing = 20;
        _bottomLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    return _bottomLayout;
}

-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topViewHeight, self.frame.size.width-30, self.bottomViewHeight)];
        
        UIView *topView = [UIView new];
        [_bottomView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
            make.height.mas_equalTo(56);
        }];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yinyuebiaoxian"]];
        [topView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.offset(0);
            make.width.height.mas_equalTo(28);
        }];
        
        UILabel *lab = [UILabel new];
        lab.text = @"重难点标记";
        lab.textColor = UIColorFromRGB(0x3b3b3b);
        lab.font = [UIFont systemFontOfSize:16];
        
        [topView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).offset(8);
            make.centerY.offset(0);
        }];
        
        [_bottomView addSubview:self.bottomCollectionView];
    }
    return _bottomView;
}
@end



@implementation OTLBackClassTopCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.offset(-45);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.imageView.mas_bottom).offset(8);
        make.left.right.offset(0);
    }];
}

#pragma mark - lazy
-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = UIColor.cyanColor;
        _imageView.layer.borderColor = OTLAppMainColor.CGColor;
        _imageView.layer.borderWidth = 1;
    }
    return _imageView;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"聆听音响世界";
        _nameLabel.textColor = UIColorFromRGB(0x999999);
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _nameLabel;
}
@end

@implementation OTLBackClassBottomCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
}

#pragma mark - lazy
-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = UIColor.cyanColor;
        _imageView.layer.borderColor = OTLAppMainColor.CGColor;
        _imageView.layer.borderWidth = 1;
        _imageView.layer.cornerRadius = 6;
    }
    return _imageView;
}

@end
