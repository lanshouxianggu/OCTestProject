//
//  CommonServiceViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/5.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "CommonServiceViewController.h"
#import "CommonServiceCollectionViewCell.h"

static NSString * const kServiceNormalCell = @"kServiceNormalCell";
static NSString * const kServiceHeaderCell = @"kServiceHeaderCell";

@interface CommonServiceViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *commonArray;
@property (nonatomic, strong) NSArray *keyArray;
@property (nonatomic, strong) NSDictionary *collectionDic;

@end

@implementation CommonServiceViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"所有服务";
    self.view.backgroundColor = DF_COLOR_BGMAIN;
    
    [self.view addSubview:self.collectionView];
//    self.collectionView.frame = self.view.bounds;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    self.commonArray = @[
        @{@"title":@"西餐",@"image":@"组 447"},
        @{@"title":@"熟食/小吃",@"image":@"组 448"},
        @{@"title":@"火锅/焖锅",@"image":@"组 449"},
        @{@"title":@"果菜生鲜",@"image":@"组 67"},
        @{@"title":@"农特产品",@"image":@"组 499"},
        @{@"title":@"自助餐厅",@"image":@"组 190"},
        @{@"title":@"膳食养生",@"image":@"矢量智能对象"},
        @{@"title":@"日韩料理",@"image":@"组 192"},
        @{@"title":@"烧烤/烤鱼",@"image":@"组 451"}
    ];
    
    self.keyArray = @[@"美食",@"生活",@"酒店旅游",@"休闲娱乐",@"出行"];
    
    self.collectionDic =  @{@"美食":@[@{@"title":@"西餐",@"image":@"组 447"},
                                          @{@"title":@"熟食/小吃",@"image":@"组 448"},
                                          @{@"title":@"火锅/焖锅",@"image":@"组 449"},
                                          @{@"title":@"果菜生鲜",@"image":@"组 67"},
                                          @{@"title":@"农特产品",@"image":@"组 499"},
                                          @{@"title":@"自助餐厅",@"image":@"组 190"},
                                          @{@"title":@"膳食养生",@"image":@"矢量智能对象"},
                                          @{@"title":@"日韩料理",@"image":@"组 192"},
                                          @{@"title":@"烧烤/烤鱼",@"image":@"组 451"},
                                          @{@"title":@"香锅冒菜",@"image":@"组 450"},
                                          @{@"title":@"面馆快餐",@"image":@"组 454"},
                                          @{@"title":@"蛋糕烘焙",@"image":@"组 453"},
                                          @{@"title":@"咖啡茶饮",@"image":@"组 452"}],
                                       @"生活":@[@{@"title":@"手机服务",@"image":@"组 65"},
                                               @{@"title":@"美容美发",@"image":@"美容美发"},
                                               @{@"title":@"美甲美睫",@"image":@"组 175"},
                                               @{@"title":@"亲子乐园",@"image":@"童装专场"},
                                               @{@"title":@"摄影写真",@"image":@"组 509"},
                                               @{@"title":@"汽车服务",@"image":@"打车出行"},
                                               @{@"title":@"学习培训",@"image":@"学习培训"},
                                               @{@"title":@"生活服务",@"image":@"组 66"},
                                               @{@"title":@"家具/装修",@"image":@"组 7"},
                                               @{@"title":@"商超便利",@"image":@"数码电子"},
                                               @{@"title":@"数码电子",@"image":@"组 322"},
                                               @{@"title":@"服装服饰",@"image":@"多边形 1"},
                                               @{@"title":@"珠宝首饰",@"image":@"组 655"},
                                               @{@"title":@"超市/药店",@"image":@"医保查询"}],
                                       @"酒店旅游":@[@{@"title":@"酒店住宿",@"image":@"组 504"},
                                                 @{@"title":@"周边游",@"image":@"组 201"},
                                                 @{@"title":@"景区/门票",@"image":@"组 6"},
                                                 @{@"title":@"休闲度假",@"image":@"组 202"}],
                                       @"休闲娱乐":@[@{@"title":@"电影/演出",@"image":@"电影"},
                                                 @{@"title":@"休闲/玩乐",@"image":@"组 62"},
                                                 @{@"title":@"运动健身",@"image":@"组 14"},
                                                 @{@"title":@"酒吧",@"image":@"组 203"},
                                                 @{@"title":@"桌游",@"image":@"组 321"},
                                                 @{@"title":@"KTV",@"image":@"组 289"},
                                                 @{@"title":@"网吧网咖",@"image":@"组 290"}],
                                       @"出行":@[@{@"title":@"打车",@"image":@"组 502"},
                                               @{@"title":@"火车票",@"image":@"组 57"},
                                               @{@"title":@"乘公交",@"image":@"公交"}]};
}

-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.minimumLineSpacing = 5;
        _layout.minimumInteritemSpacing = 5;
        _layout.itemSize = CGSizeMake((SCREEN_WIDTH-24-20)/5, (SCREEN_WIDTH-24-10)/5);
        _layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);
        
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = DF_COLOR_BGMAIN;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:CommonServiceCollectionViewCell.class forCellWithReuseIdentifier:kServiceNormalCell];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kServiceHeaderCell];
    }
    return _collectionView;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.keyArray.count+1;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kServiceHeaderCell forIndexPath:indexPath];
        for (UIView *view in reuseableView.subviews) {
            [view removeFromSuperview];
        }
        UILabel *lab = [UILabel new];
        lab.textColor = UIColor.darkTextColor;
        lab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        if (indexPath.section==0) {
            lab.text = @"常用服务";
        }else {
            lab.text = self.keyArray[indexPath.section-1];
        }
        [reuseableView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(12);
            make.centerY.offset(5);
        }];
        return reuseableView;
    }
    return nil;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.commonArray.count;
    }
    NSString *keyTitle = self.keyArray[section-1];
    NSArray *dataArray = [self.collectionDic valueForKey:keyTitle];
    return dataArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommonServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kServiceNormalCell forIndexPath:indexPath];
    cell.backgroundColor = UIColor.whiteColor;
    cell.layer.cornerRadius = 10;
    
    if (indexPath.section==0) {
        NSDictionary *dataDic = self.commonArray[indexPath.item];
        [cell updateWithDic:dataDic];
    }else{
        NSString *keyTitle = self.keyArray[indexPath.section-1];
        NSArray *dataArray = [self.collectionDic valueForKey:keyTitle];
        NSDictionary *dataDic = dataArray[indexPath.item];
        [cell updateWithDic:dataDic];
    }
    
    return cell;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CATransform3D transform = CATransform3DIdentity;
//    static float rot = 0;
//    rot -= 10;
//    transform = CATransform3DRotate(transform, rot*M_PI/180, 0, 1, 0);
//    self.rotateView.layer.transform = transform;
}

@end
