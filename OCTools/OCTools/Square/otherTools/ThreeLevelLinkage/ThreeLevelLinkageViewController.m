//
//  ThreeLevelLinkageViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/12/10.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ThreeLevelLinkageViewController.h"
#import "ThreeLevelLinkageSelectView.h"

const CGFloat kTopViewHeight = 40.f;

@interface ThreeLevelLinkageViewController () <ThreeLevelLinkageSelectViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) ThreeLevelLinkageSelectView *selectView;
@property (nonatomic, strong) UILabel *topTitleLabel;
@property (nonatomic, strong) UIImageView *topArrowImageView;
@property (nonatomic, strong) UIButton *topTouchBtn;
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;
@property (nonatomic, assign) CGPoint lastPoint;
@end

@implementation ThreeLevelLinkageViewController

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"三级联动";
    self.view.backgroundColor = UIColor.cyanColor;
    
    [self setupUI];
}

-(void)setupUI {
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.topView];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:UIApplication.sharedApplication.keyWindow];
    CGRect rect = self.selectView.frame;
    if (self.lastPoint.y!=0) {
        rect.size.height += point.y-self.lastPoint.y;
        if (rect.size.height>SCREEN_HEIGHT/2) {
            rect.size.height=SCREEN_HEIGHT/2;
            
            self.topTouchBtn.selected = YES;
            self.topTitleLabel.textColor = UIColor.redColor;
            self.topArrowImageView.image = [UIImage imageNamed:@"upArrow"];
        }
        if (rect.size.height<=0) {
            rect.size.height=0;
            
            self.topTouchBtn.selected = NO;
            self.topTitleLabel.textColor = UIColor.darkTextColor;
            self.topArrowImageView.image = [UIImage imageNamed:@"downArrow"];
        }
        self.selectView.frame = rect;
    }
    self.lastPoint = point;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.lastPoint = CGPointZero;
}

-(UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTopViewHeight)];
        _topView.backgroundColor = UIColor.whiteColor;
        
        [_topView addSubview:self.topTitleLabel];
        [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.offset(0);
        }];
        
        [_topView addSubview:self.topArrowImageView];
        [self.topArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.left.equalTo(self.topTitleLabel.mas_right).offset(5);
        }];
        
        UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.topTouchBtn = touchBtn;
        [touchBtn addTarget:self action:@selector(topViewTouchAction) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:touchBtn];
        [touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return _topView;
}

-(UILabel *)topTitleLabel {
    if (!_topTitleLabel) {
        _topTitleLabel = [UILabel new];
        _topTitleLabel.text = @"选择地区";
        _topTitleLabel.font = [UIFont systemFontOfSize:14];
        _topTitleLabel.textColor = UIColor.darkTextColor;
    }
    return _topTitleLabel;
}

-(UIImageView *)topArrowImageView {
    if (!_topArrowImageView) {
        _topArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downArrow"]];
    }
    return _topArrowImageView;
}

-(ThreeLevelLinkageSelectView *)selectView {
    if (!_selectView) {
        _selectView = [[ThreeLevelLinkageSelectView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, SCREEN_WIDTH, /*SCREEN_HEIGHT/2*/0)];
        _selectView.delegate = self;
    }
    return _selectView;
}

-(void)topViewTouchAction {
    self.topTouchBtn.selected = !self.topTouchBtn.selected;
    if (self.topTouchBtn.selected) {
        self.topTitleLabel.textColor = UIColor.redColor;
        self.topArrowImageView.image = [UIImage imageNamed:@"upArrow"];
        
        CGRect frame = self.selectView.frame;
        frame.size.height = SCREEN_HEIGHT/2;
        self.selectView.frame = frame;
    }else{
        self.topTitleLabel.textColor = UIColor.darkTextColor;
        self.topArrowImageView.image = [UIImage imageNamed:@"downArrow"];
        CGRect frame = self.selectView.frame;
        frame.size.height = 0;
        self.selectView.frame = frame;
    }
}

#pragma mark - ThreeLevelLinkageSelectViewDelegate
-(void)resetAction {
    self.selectView.hidden = YES;
    self.topTouchBtn.selected = NO;
    self.topTitleLabel.textColor = UIColor.darkTextColor;
    self.topArrowImageView.image = [UIImage imageNamed:@"downArrow"];
    self.topTitleLabel.text = @"选择地区";
}

-(void)completeActionWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area {
    self.selectView.hidden = YES;
    self.topTouchBtn.selected = NO;
    self.topTitleLabel.textColor = UIColor.darkTextColor;
    self.topArrowImageView.image = [UIImage imageNamed:@"downArrow"];
    self.topTitleLabel.text = [NSString stringWithFormat:@"%@-%@-%@",province,city,area];
}
@end
