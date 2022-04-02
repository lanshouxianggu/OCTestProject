//
//  MainNavigationController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/6/4.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation MainNavigationController

//设置navigation背景
+ (void)initialize {
    
    if (self == [MainNavigationController class]) {
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
        [bar setBackgroundImage:[UIImage imageWithColor:OTLAppMainColor] forBarMetrics:UIBarMetricsDefault];
        [bar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        //        bar.barStyle = UIBarStyleBlack;
        
        //        [[UINavigationBar appearance] setBarTintColor:DF_COLOR_WC(255)];
        [[UINavigationBar appearance] setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
           NSForegroundColorAttributeName:DF_COLOR_WC(0)}];//系统方法
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationBar.translucent = NO;
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.hidden = YES;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.childViewControllers count] > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationController.navigationBar.backIndicatorImage = NULL;
        viewController.navigationItem.leftBarButtonItem = [self createBackButtonItem];
    }else {
        viewController.hidesBottomBarWhenPushed = NO;
        viewController.navigationItem.leftBarButtonItem = NULL;
    }
    
    if ([self.viewControllers containsObject:viewController]) {
        [self popToViewController:viewController animated:YES];
        return;
    }
    [super pushViewController:viewController animated:animated];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count>1;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count>1;
}

#pragma mark - 返回Item
- (UIBarButtonItem *)createBackButtonItem {
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    btnBack.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
    btnBack.frame = CGRectMake(0, 0, 20.0f, 20.0f);
    [btnBack setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [btnBack addTarget:self action:@selector(backBtnClicked:)forControlEvents:UIControlEventTouchUpInside];
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnBack];
}
#pragma mark - 按钮返回
- (void)backBtnClicked:(UIButton *)button {
    [super popViewControllerAnimated:YES];
}

@end
