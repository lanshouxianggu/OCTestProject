//
//  OTLAfterClassSheetVideoCell.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLAfterClassSheetVideoCell.h"
#import "OTLAfterClassSheetVideoCollectionCell.h"

static const CGFloat sCollectionViewHeight = 187.f;

@interface OTLAfterClassSheetVideoCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation OTLAfterClassSheetVideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 9;
        self.videosArr = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.contentView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.offset(-15);
        make.height.mas_equalTo(15);
    }];
}

-(void)reloadData{
    if (self.videosArr.count) {
        self.collectionView.hidden = NO;
        self.tipsLabel.hidden = YES;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(sCollectionViewHeight);
        }];
        [self.collectionView reloadData];
    }else {
        self.collectionView.hidden = YES;
        self.tipsLabel.hidden = NO;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
        }];
    }
}

#pragma mark - 相册上传
-(void)assertUpload {
    if (self.videoAddBlock) {
        self.videoAddBlock();
    }
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videosArr.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OTLAfterClassSheetVideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OTLAfterClassSheetVideoCollectionCell" forIndexPath:indexPath];
    WS(weakSelf)
    [cell setDeleteBlock:^{
        if (weakSelf.videoDeleteBlock) {
            weakSelf.videoDeleteBlock(indexPath.item);
        }
    }];
    return cell;
}

#pragma mark - lazy
-(UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shipinghuigu"]];
        
        [_topView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
            make.width.height.mas_equalTo(28);
        }];
        
        UILabel *lab = [UILabel new];
        lab.text = @"课堂视频";
        lab.textColor = UIColorFromRGB(0x3b3b3b);
        lab.font = [UIFont systemFontOfSize:16];
        
        [_topView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(imageV.mas_right).offset(8);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"相册上传" forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x76C0EF) forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        btn.layer.cornerRadius = 12;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = UIColorFromRGB(0x76C0EF).CGColor;
        btn.layer.borderWidth = 1;
        
        [btn addTarget:self action:@selector(assertUpload) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.size.mas_equalTo(CGSizeMake(72, 24));
            make.right.offset(-15);
        }];
    }
    return _topView;
}

-(UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        _tipsLabel.text = @"视频记录老师示范/知识重点/学生问题";
        _tipsLabel.textColor = UIColorFromRGB(0x999999);
        _tipsLabel.font = [UIFont systemFontOfSize:12];
    }
    return _tipsLabel;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.hidden = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:OTLAfterClassSheetVideoCollectionCell.class forCellWithReuseIdentifier:@"OTLAfterClassSheetVideoCollectionCell"];
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(240, sCollectionViewHeight);
        _layout.minimumLineSpacing = 15;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

@end
