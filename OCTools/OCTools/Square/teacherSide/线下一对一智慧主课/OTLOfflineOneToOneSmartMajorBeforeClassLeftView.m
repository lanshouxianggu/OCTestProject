//
//  OTLOfflineOneToOneSmartMajorBeforeClassLeftView.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLOfflineOneToOneSmartMajorBeforeClassLeftView.h"

@interface OTLOfflineOneToOneSmartMajorBeforeClassLeftView ()
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *normalImagesArray;
@property (nonatomic, strong) NSArray *selectImagesArray;
@property (nonatomic, strong) NSMutableArray <UIButton *>*btnsArray;
@property (nonatomic, strong) UIImageView *selectImageView;
@end

@implementation OTLOfflineOneToOneSmartMajorBeforeClassLeftView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titlesArray = @[@"回课",@"新课",@"课后单"];
        self.normalImagesArray = @[
            [UIImage imageNamed:@"icon_star_gray"],
            [UIImage imageNamed:@"icon_star_gray"],
            [UIImage imageNamed:@"icon_star_gray"]];
        self.selectImagesArray = @[
            [UIImage imageNamed:@"icon_star_slight"],
            [UIImage imageNamed:@"icon_star_slight"],
            [UIImage imageNamed:@"icon_star_slight"]];
        self.btnsArray = [NSMutableArray array];
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = UIColor.whiteColor;
//    scrollView.alwaysBounceVertical = YES;
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.height.equalTo(self);
    }];
    
    UIView *mainView = [UIView new];
    [scrollView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(scrollView);
        make.height.mas_greaterThanOrEqualTo(scrollView);
    }];
    
    [mainView addSubview:self.selectImageView];
    self.selectImageView.frame = CGRectMake(0, -5, CGRectGetWidth(self.frame), 60);
    
    [self.btnsArray removeAllObjects];
    for (int i=0; i<self.titlesArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        NSString *title = self.titlesArray[i];
        UIImage *normalImage = self.normalImagesArray[i];
        UIImage *selectImage = self.selectImagesArray[i];
        [btn setImage:normalImage forState:UIControlStateNormal];
        [btn setImage:selectImage forState:UIControlStateSelected];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 17, 0, 0)];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn setTitleColor:UIColorFromRGB(0x3b3b3b) forState:UIControlStateNormal];
        [btn setTitleColor:OTLAppMainColor forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
//        [btn setBackgroundImage:[UIImage imageNamed:@"selectSeriesIcon"] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(btnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [mainView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.mas_equalTo(48);
            make.top.offset(i*48);
            if (i==self.titlesArray.count-1) {
                make.bottom.mas_lessThanOrEqualTo(-10);
            }
        }];
        if (i==0) {
            btn.selected = YES;
        }
        [self.btnsArray addObject:btn];
    }
}

-(void)selectIndex:(int)index {
    WS(weakSelf)
    [self.btnsArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = obj.tag==index;
        if (obj.tag==index) {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.selectImageView.center = obj.center;
            }];
        }
    }];
}

-(void)btnSelectAction:(UIButton *)btn {
    if (self.selectBtnBlock) {
        self.selectBtnBlock(btn.tag);
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.selectImageView.center = btn.center;
    }];
    
    [self.btnsArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = obj.tag==btn.tag;
    }];
}

#pragma mark - lazy
-(UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectSeriesIcon"]];
    }
    return _selectImageView;
}

@end
