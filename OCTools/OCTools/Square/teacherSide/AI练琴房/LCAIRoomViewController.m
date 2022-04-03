//
//  LCAIRoomViewController.m
//  OCTools
//
//  Created by stray s on 2022/4/2.
//

#import "LCAIRoomViewController.h"
#import "AppDelegate.h"
#import "LCAIRoomLeftView.h"

@interface LCAIRoomViewController ()
@property (nonatomic, strong) LCAIRoomLeftView *leftView;
@property (nonatomic, strong) UIView *rightView;
@end

@implementation LCAIRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"AI练琴房";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
}

-(void)setupUI {
    [self.view addSubview:self.leftView];
    CGFloat width = [LCAIRoomLeftView leftCollectionViewWidth];
    CGFloat height = SCREEN_HEIGHT-58;
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    
    [self.view addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.right.bottom.offset(0);
//        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.left.equalTo(self.leftView.mas_right);
    }];
}

#pragma mark - 设置屏幕方向
- (void)setScreenOrientationTo:(UIInterfaceOrientationMask)orientation {
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    appDelegate.interfaceOrientation = orientation;
    [appDelegate application:UIApplication.sharedApplication supportedInterfaceOrientationsForWindow:appDelegate.window];
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    NSNumber *orientationTarget = [NSNumber numberWithInt:(int)orientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

#pragma mark - lazy
-(LCAIRoomLeftView *)leftView {
    if (!_leftView) {
        _leftView = [LCAIRoomLeftView new];
        _leftView.backgroundColor = UIColor.darkGrayColor;
    }
    return _leftView;
}

-(UIView *)rightView {
    if (!_rightView) {
        _rightView = [UIView new];
        _rightView.backgroundColor = UIColor.cyanColor;
    }
    return _rightView;
}

@end
