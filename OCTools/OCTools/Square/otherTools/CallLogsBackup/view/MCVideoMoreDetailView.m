//
//  MCVideoMoreDetailView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/11/10.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCVideoMoreDetailView.h"

static const CGFloat cellHeihgt = 80.f;

@interface MCVideoMoreDetailView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MCVideoMoreDetailView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        [self setupUI];
        [self initData];
    }
    return self;
}

-(void)initData {
    NSArray *tempArray = @[@{@"imageName":@"",@"title":@"删除"},
                           @{@"imageName":@"",@"title":@"下载"},
                           @{@"imageName":@"",@"title":@"清晰度"},
                           @{@"imageName":@"",@"title":@"倍速播放"},
                           @{@"imageName":@"",@"title":@"详细信息"},];
    
    for (NSDictionary *dic in tempArray) {
        [self.dataArray addObject:dic];
    }

    NSInteger rowNum = self.dataArray.count%5==0?(self.dataArray.count/5):(self.dataArray.count/5+1);
    if (rowNum>1) {
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(0);
            make.height.mas_equalTo(rowNum * cellHeihgt);
        }];
    }
    [self.collectionView reloadData];
}

-(void)setupUI {
    UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchBtn addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:touchBtn];
    touchBtn.frame = self.bounds;
    
    UIView *mainView = [UIView new];
    mainView.backgroundColor = DF_COLOR_BGMAIN;
    mainView.layer.cornerRadius = 16;

    [self addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(16);
        make.height.mas_greaterThanOrEqualTo(200);
    }];
    
    ({
//        UILabel *titleLab = [UILabel new];
//        titleLab.text = @"选择恢复记录";
//        titleLab.textColor = DF_COLOR_0x(0x000A18);
//        titleLab.font = [UIFont systemFontOfSize:16];
//        self.titleLabel = titleLab;
        
//        [mainView addSubview:titleLab];
//        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.offset(0);
//            make.top.offset(24);
//        }];
        
        [mainView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(0);
            make.height.mas_equalTo(cellHeihgt);
        }];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:DF_COLOR_0x_alpha(0x000A18, 0.5) forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        cancelBtn.backgroundColor = UIColor.whiteColor;
        cancelBtn.layer.cornerRadius = 8;
        cancelBtn.layer.masksToBounds = YES;
        [cancelBtn addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];

        [mainView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16);
            make.right.offset(-16);
            make.height.mas_equalTo(44);
            make.top.equalTo(self.collectionView.mas_bottom).offset(16);
            make.bottomMargin.offset(-16);
        }];
        
        
    });
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/5, cellHeihgt);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = DF_COLOR_BGMAIN;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:MCVideoMoreDetailViewCell.class forCellWithReuseIdentifier:@"MCVideoMoreDetailViewCell"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MCVideoMoreDetailViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCVideoMoreDetailViewCell" forIndexPath:indexPath];
    cell.dataDic = self.dataArray[indexPath.item];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.item) {
        case 0:
            if (self.delegate && [self.delegate respondsToSelector:@selector(videoMoreDetailViewDeleteAction)]) {
                [self.delegate videoMoreDetailViewDeleteAction];
            }
            break;
        case 1:
            if (self.delegate && [self.delegate respondsToSelector:@selector(videoMoreDetailViewDownloadAction)]) {
                [self.delegate videoMoreDetailViewDownloadAction];
            }
            break;
        case 2:
            if (self.delegate && [self.delegate respondsToSelector:@selector(videoMoreDetailViewArticulationAction)]) {
                [self.delegate videoMoreDetailViewArticulationAction];
            }
            break;
        case 3:
            if (self.delegate && [self.delegate respondsToSelector:@selector(videoMoreDetailViewSpeedPlayAction)]) {
                [self.delegate videoMoreDetailViewSpeedPlayAction];
            }
            break;
        case 4:
            if (self.delegate && [self.delegate respondsToSelector:@selector(videoMoreDetailViewDetailInfoAction)]) {
                [self.delegate videoMoreDetailViewDetailInfoAction];
            }
            break;
        default:
            break;
    }
}

#pragma mark - 空白处点击事件
-(void)touchAction {
    self.backgroundColor = UIColor.clearColor;
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        
    }];
}

@end

@interface MCVideoMoreDetailViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MCVideoMoreDetailViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    self.imageView.image = [UIImage imageNamed:dataDic[@"imageName"]];
    self.titleLabel.text = dataDic[@"title"];
}

-(void)setupUI {
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.offset(0);
        make.centerY.offset(-10);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-8);
    }];
}

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = UIColor.darkGrayColor;
    }
    return _imageView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColor.darkTextColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}
@end
