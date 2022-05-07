//
//  LCLoginViewController.m
//  OCTools
//
//  Created by stray s on 2022/4/1.
//

#import "LCLoginViewController.h"

@interface LCLoginViewController ()

@end

@implementation LCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:30 weight:UIFontWeightBold]];
    [btn setBackgroundColor:UIColor.darkTextColor];
    btn.layer.cornerRadius = 75;
    btn.layer.shadowColor = UIColor.orangeColor.CGColor;
    btn.layer.shadowRadius = 20;
    btn.layer.shadowOffset = CGSizeMake(0, 0);
    btn.layer.shadowOpacity = 0.8;
    
    [btn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
}

-(void)loginAction {
    [SVProgressHUD showWithStatus:@"登录中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    });

    [SVProgressHUD dismissWithDelay:1 completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIF_LOGIN_SUCCESS" object:nil];
    }];
    
}

@end
