//
//  CreateShareGroupViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "CreateShareGroupViewController.h"
#import "CreateShareGroupNavView.h"

@interface CreateShareGroupViewController () <CreateShareGroupNavViewDelegate>
@property (nonatomic, strong) CreateShareGroupNavView *navView;
@end

@implementation CreateShareGroupViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新建共享群";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
}

-(void)setupUI {
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.topMargin.offset(0);
        make.height.mas_equalTo(kStatusBarAndNavigationBarHeight);
    }];
}

-(CreateShareGroupNavView *)navView {
    if (!_navView) {
        _navView = [[CreateShareGroupNavView alloc] init];
        _navView.delegate = self;
    }
    return _navView;
}

#pragma mark - CreateShareGroupNavViewDelegate
-(void)navViewCancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)navViewSaveAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
