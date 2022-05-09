//
//  OTLAfterClassSheetPianoTaskCell.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLAfterClassSheetPianoTaskCell.h"
#import "OTLAfterClassSheetPianoTaskCollectionCell.h"

@interface OTLAfterClassSheetPianoTaskCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation OTLAfterClassSheetPianoTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 9;
        self.tasksArray = [NSMutableArray array];
        for (int i=0; i<5; i++) {
            [self.tasksArray addObject:@""];
        }
        [self setupUI];
        [self loadData];
    }
    return self;
}

-(void)setupUI {
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.contentView addSubview:self.practiceDurationView];
    [self.practiceDurationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(38);
    }];
    
    [self.contentView addSubview:self.practiceDaysView];
    [self.practiceDaysView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.practiceDurationView.mas_bottom);
        make.height.mas_equalTo(38);
    }];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.practiceDaysView.mas_bottom).offset(5);
        make.height.mas_equalTo(0);
        make.bottom.offset(-15);
    }];
}

-(void)loadData {
    [self.practiceDurationView updateRightValue:@"30分钟"];
    [self.practiceDaysView updateRightValue:@"3天"];
}

-(void)reloadData {
    [self.collectionView reloadData];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.tasksArray.count?162:0);
    }];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tasksArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OTLAfterClassSheetPianoTaskCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OTLAfterClassSheetPianoTaskCollectionCell" forIndexPath:indexPath];
    WS(weakSelf)
    [cell setDeleteBlock:^{
        if (weakSelf.tasksUpdateBlock) {
            [weakSelf.tasksArray removeObjectAtIndex:indexPath.item];
            weakSelf.tasksUpdateBlock();
        }
    }];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - lazy
-(UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lianqinjilu"]];
        
        [_topView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
            make.width.height.mas_equalTo(28);
        }];
        
        UILabel *lab = [UILabel new];
        lab.text = @"练琴任务";
        lab.textColor = UIColorFromRGB(0x3b3b3b);
        lab.font = [UIFont systemFontOfSize:16];
        
        [_topView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(imageV.mas_right).offset(8);
        }];
    }
    return _topView;
}

-(OTLAfterClassSheetPianoTaskNormalView *)practiceDurationView {
    if (!_practiceDurationView) {
        _practiceDurationView = [[OTLAfterClassSheetPianoTaskNormalView alloc] initWithLeftTitle:@"每日练琴时长"];
        WS(weakSelf)
        [_practiceDurationView setRightActionBlock:^(NSString * _Nonnull currentStr) {
            if (weakSelf.rightActionBlock) {
                weakSelf.rightActionBlock(TaskChooseTypePracticeDuration, currentStr);
            }
        }];
    }
    return _practiceDurationView;
}

-(OTLAfterClassSheetPianoTaskNormalView *)practiceDaysView {
    if (!_practiceDaysView) {
        _practiceDaysView = [[OTLAfterClassSheetPianoTaskNormalView alloc] initWithLeftTitle:@"未来一周练琴天数"];
        WS(weakSelf)
        [_practiceDaysView setRightActionBlock:^(NSString * _Nonnull currentStr) {
            if (weakSelf.rightActionBlock) {
                weakSelf.rightActionBlock(TaskChooseTypePracticeDay, currentStr);
            }
        }];
    }
    return _practiceDaysView;
}

-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(240, 162);
        _layout.minimumLineSpacing = 15;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"OTLAfterClassSheetPianoTaskCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"OTLAfterClassSheetPianoTaskCollectionCell"];
    }
    return _collectionView;
}

@end

@interface OTLAfterClassSheetPianoTaskNormalView ()
@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation OTLAfterClassSheetPianoTaskNormalView

-(instancetype)initWithLeftTitle:(NSString *)leftTitle {
    if (self = [super init]) {
        [self setupUI];
        self.leftLabel.text = leftTitle;
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(15);
    }];
    
    [self addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-15);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(72);
    }];
    
    [self.rightView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchBtn addTarget:self action:@selector(touchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView addSubview:touchBtn];
    [touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - 选择
-(void)touchBtnAction {
    if (self.rightActionBlock) {
        self.rightActionBlock(self.rightLabel.text);
    }
}

#pragma mark - 更新
-(void)updateRightValue:(NSString *)value {
    self.rightLabel.text = value;
}

#pragma mark - lazy
-(UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.textColor = UIColorFromRGB(0x999999);
        _leftLabel.font = [UIFont systemFontOfSize:12];
    }
    return _leftLabel;
}

-(UIView *)rightView {
    if (!_rightView) {
        _rightView = [UIView new];
        _rightView.layer.cornerRadius = 4;
        _rightView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        _rightView.layer.borderWidth = 1;
    }
    return _rightView;
}

-(UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.textColor = UIColorFromRGB(0x3b3b3b);
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightLabel;
}
@end
