//
//  OTLOfflineOneToOneSmartMajorBeforeClassVC.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLOfflineOneToOneSmartMajorBeforeClassVC.h"
#import "OTLOfflineOneToOneSmartMajorBeforeClassLeftView.h"
#import "OTLOfflineOneToOneSmartMajorBeforeClassRightView.h"

#define kLeftViewWidth SCREEN_WIDTH*0.14
#define kRightViewWidth SCREEN_WIDTH-kLeftViewWidth

@interface OTLOfflineOneToOneSmartMajorBeforeClassVC ()
@property (nonatomic, strong) OTLOfflineOneToOneSmartMajorBeforeClassLeftView *leftView;
@property (nonatomic, strong) OTLOfflineOneToOneSmartMajorBeforeClassRightView *rightView;
@end

@implementation OTLOfflineOneToOneSmartMajorBeforeClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"线下一对一主课";
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    [self setupUI];
}

-(void)setupUI {
    [self.view addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.mas_equalTo(kLeftViewWidth);
    }];
    
    [self.view addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.left.equalTo(self.leftView.mas_right);
        make.width.mas_equalTo(kRightViewWidth);
    }];
}

#pragma mark - lazy
-(OTLOfflineOneToOneSmartMajorBeforeClassLeftView *)leftView {
    if (!_leftView) {
        _leftView = [[OTLOfflineOneToOneSmartMajorBeforeClassLeftView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, SCREEN_HEIGHT-64)];
        _leftView.backgroundColor = UIColor.whiteColor;
        WS(weakSelf)
        [_leftView setSelectBtnBlock:^(NSInteger index) {
            [weakSelf.rightView scrollToIndex:index];
        }];
    }
    return _leftView;
}

-(OTLOfflineOneToOneSmartMajorBeforeClassRightView *)rightView {
    if (!_rightView) {
        _rightView = [[OTLOfflineOneToOneSmartMajorBeforeClassRightView alloc] initWithFrame:CGRectMake(kLeftViewWidth, 0, kRightViewWidth, SCREEN_HEIGHT-64)];
        _rightView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        WS(weakSelf)
       [_rightView setScrollToIndexBlock:^(int index) {
           [weakSelf.leftView selectIndex:index];
       }];
    }
    return _rightView;
}

@end
