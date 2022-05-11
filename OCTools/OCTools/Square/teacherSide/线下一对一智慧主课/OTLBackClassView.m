//
//  OTLBackClassView.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLBackClassView.h"

@interface OTLBackClassView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *subMainView;
@property (nonatomic, strong) UICollectionView *topCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *topLayout;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UICollectionView *bottomCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *bottomLayout;

@property (nonatomic, assign) CGSize topItemSize;
@property (nonatomic, assign) CGSize bottomItemSize;
@property (nonatomic, assign) CGFloat topViewHeight;
@property (nonatomic, assign) CGFloat bottomViewHeight;

///暂无回课曲谱
@property (nonatomic, strong) UILabel *noQupuLabel;
///暂未上传书本批注
@property (nonatomic, strong) UILabel *noRemarkLabel;
///暂无回课内容
@property (nonatomic, strong) UILabel *noBackClassLabel;

///是否新课
@property (nonatomic, assign) BOOL isFreshClass;
@end

@implementation OTLBackClassView

-(instancetype)initWithFrame:(CGRect)frame isFreshClass:(BOOL)isFreshClass {
    if (self = [super initWithFrame:frame]) {
        self.isFreshClass = isFreshClass;
        self.topViewHeight = 220;
        self.bottomViewHeight = 257;
        self.topItemSize = CGSizeMake(120, self.topViewHeight-30);
        self.bottomItemSize = CGSizeMake(118, self.bottomViewHeight-56-15-30);
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(self.topViewHeight+self.bottomViewHeight);
    }];
    
    UIScrollView *scrollView = [UIScrollView new];
    UIView *subMainView = [UIView new];

    [self.mainView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.height.equalTo(self.mainView);
    }];
    [scrollView addSubview:subMainView];
    [subMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.equalTo(scrollView);
        make.height.mas_equalTo(self.topViewHeight+self.bottomViewHeight);
    }];
    self.subMainView = subMainView;
    
    [subMainView addSubview:self.noQupuLabel];
    [self.noQupuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [subMainView addSubview:self.topCollectionView];
        
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xE5E5E5);
    
    [subMainView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.topCollectionView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [subMainView addSubview:self.bottomView];
    
    [self addSubview:self.noBackClassLabel];
    [self.noBackClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(-20);
    }];
}

#pragma mark - setter
-(void)setQupuArray:(NSArray *)qupuArray {
    _qupuArray = qupuArray;
    CGRect qupuRect = self.topCollectionView.frame;
    CGRect remarkRect = self.bottomView.frame;
    if (qupuArray.count==0 && !self.isFreshClass) {
        self.topViewHeight = 60;
        self.topCollectionView.hidden = YES;
        self.noQupuLabel.hidden = NO;
    }else {
        self.topViewHeight = 220;
        self.noQupuLabel.hidden = YES;
        self.topCollectionView.hidden = NO;
    }
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.topViewHeight+self.bottomViewHeight);
    }];
    [self.subMainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.topViewHeight+self.bottomViewHeight);
    }];
    qupuRect.size.height = self.topViewHeight;
    remarkRect.origin.y = self.topViewHeight;
    
    self.topCollectionView.frame = qupuRect;
    self.bottomView.frame = remarkRect;
}

-(void)setRemarkArray:(NSArray *)remarkArray {
    _remarkArray = remarkArray;
    CGRect bottomRect = self.bottomView.frame;
    CGRect bottomCollectionViewRect = self.bottomCollectionView.frame;
    if (remarkArray.count) {
        self.bottomViewHeight = 257;
        self.noRemarkLabel.hidden = YES;
    }else {
        self.bottomViewHeight = self.isFreshClass?116:0;
        self.noRemarkLabel.hidden = self.isFreshClass?NO:YES;
    }
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.topViewHeight+self.bottomViewHeight);
    }];
    [self.subMainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.topViewHeight+self.bottomViewHeight);
    }];
    bottomRect.size.height = self.bottomViewHeight;
    bottomCollectionViewRect.size.height = self.bottomViewHeight>0?self.bottomViewHeight-56-15:0;
    self.bottomView.frame = bottomRect;
    self.bottomCollectionView.frame = bottomCollectionViewRect;
    
    if (!self.isFreshClass) {
        //回课，曲谱为空，标注为空的处理
        if (self.remarkArray.count==0 && self.qupuArray.count==0) {
            self.mainView.hidden = YES;
            self.noBackClassLabel.hidden = NO;
        }
    }
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.topCollectionView]) {
        if (self.isFreshClass) {
            return self.qupuArray.count+1;
        }else {
            return self.qupuArray.count;
        }
    }
    return self.remarkArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.topCollectionView]) {
        OTLBackClassTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OTLBackClassTopCollectionViewCell" forIndexPath:indexPath];
        cell.addMusicView.hidden = YES;
        cell.imageView.hidden = NO;
        if (self.isFreshClass && indexPath.item==0) {
            cell.nameLabel.text = @"";
            cell.addMusicView.hidden = NO;
            cell.imageView.hidden = YES;
        }
        
        return cell;
    }else if ([collectionView isEqual:self.bottomCollectionView]) {
        OTLBackClassBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OTLBackClassBottomCollectionViewCell" forIndexPath:indexPath];
        
        
        return cell;
    }
    return [UICollectionViewCell new];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.topCollectionView]) {
        if (indexPath.item==0) {
            //添加曲谱
        }
    }
}

#pragma mark - 添加曲谱
-(void)addMusicQupu {
    
}

#pragma mark - 书本批注
-(void)bookRemarkAction {
    
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

-(UILabel *)noQupuLabel {
    if (!_noQupuLabel) {
        _noQupuLabel = [UILabel new];
        _noQupuLabel.text = @"暂无回课曲谱";
        _noQupuLabel.hidden = YES;
        _noQupuLabel.textColor = UIColorFromRGB(0x999999);
        _noQupuLabel.font = [UIFont systemFontOfSize:14];
        _noQupuLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noQupuLabel;
}

-(UILabel *)noRemarkLabel {
    if (!_noRemarkLabel) {
        _noRemarkLabel = [UILabel new];
        _noRemarkLabel.text = @"暂未上传书本批注";
        _noRemarkLabel.hidden = YES;
        _noRemarkLabel.textColor = UIColorFromRGB(0x999999);
        _noRemarkLabel.font = [UIFont systemFontOfSize:14];
        _noRemarkLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noRemarkLabel;
}

-(UILabel *)noBackClassLabel {
    if (!_noBackClassLabel) {
        _noBackClassLabel = [UILabel new];
        _noBackClassLabel.text = @"暂无回课内容";
        _noBackClassLabel.hidden = YES;
        _noBackClassLabel.textColor = UIColorFromRGB(0x999999);
        _noBackClassLabel.font = [UIFont systemFontOfSize:14];
        _noBackClassLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noBackClassLabel;
}

-(UICollectionView *)bottomCollectionView {
    if (!_bottomCollectionView) {
        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 56, self.frame.size.width-30-30, self.bottomViewHeight-56-15) collectionViewLayout:self.bottomLayout];
        _bottomCollectionView.alwaysBounceHorizontal = YES;
        _bottomCollectionView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _bottomCollectionView.layer.cornerRadius = 9;
        _bottomCollectionView.delegate = self;
        _bottomCollectionView.dataSource = self;
        
        [_bottomCollectionView addSubview:self.noRemarkLabel];
        [self.noRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.height.mas_equalTo(60);
        }];
        
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
        
        if (self.isFreshClass) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"书本批注" forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0x76C0EF) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
            btn.layer.cornerRadius = 12;
            btn.layer.masksToBounds = YES;
            btn.layer.borderColor = UIColorFromRGB(0x76C0EF).CGColor;
            btn.layer.borderWidth = 1;
            
            [btn addTarget:self action:@selector(bookRemarkAction) forControlEvents:UIControlEventTouchUpInside];
            
            [topView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(72, 24));
                make.right.offset(-15);
            }];
        }
        
        [_bottomView addSubview:self.bottomCollectionView];
    }
    return _bottomView;
}
@end


#pragma mark - OTLBackClassTopCollectionViewCell
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
        make.top.equalTo(self.imageView.mas_bottom).offset(12);
        make.left.right.offset(0);
    }];
    
    [self.contentView addSubview:self.addMusicView];
    
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = UIColorFromRGB(0x999999).CGColor;
    border.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.addMusicView.bounds cornerRadius:4];
    border.path = path.CGPath;
    border.frame = self.addMusicView.frame;
    //线宽(厚度)
    border.lineWidth = 1.f;
    //虚线的间隔（线长和间隔）
    border.lineDashPattern = @[@(5),@(5)];
    
    [self.addMusicView.layer addSublayer:border];
}

#pragma mark - lazy
-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = UIColor.cyanColor;
        _imageView.layer.borderColor = OTLAppMainColor.CGColor;
        _imageView.layer.borderWidth = 1.5;
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

-(UIView *)addMusicView {
    if (!_addMusicView) {
        _addMusicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-45)];
        _addMusicView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _addMusicView.hidden = YES;
        _addMusicView.layer.cornerRadius = 4;
        
        UILabel *lab1 = [UILabel new];
        lab1.text = @"＋";
        lab1.textColor = UIColorFromRGB(0x999999);
        lab1.font = [UIFont systemFontOfSize:20];
        
        [_addMusicView addSubview:lab1];
        [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(-5);
        }];
        
        UILabel *lab2 = [UILabel new];
        lab2.text = @"添加曲谱";
        lab2.textColor = UIColorFromRGB(0x999999);
        lab2.font = [UIFont systemFontOfSize:12];
        
        [_addMusicView addSubview:lab2];
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(20);
        }];
    }
    return _addMusicView;
}
@end

#pragma mark - OTLBackClassBottomCollectionViewCell
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
        _imageView.layer.borderWidth = 1.5;
        _imageView.layer.cornerRadius = 6;
    }
    return _imageView;
}

@end
