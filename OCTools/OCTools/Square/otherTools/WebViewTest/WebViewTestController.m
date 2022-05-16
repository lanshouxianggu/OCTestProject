//
//  WebViewTestController.m
//  ChatClub
//
//  Created by 刘创 on 2021/7/21.
//  Copyright © 2021 ArcherMind. All rights reserved.
//

#import "WebViewTestController.h"
#import "LMJHorizontalScrollText.h"
#import <WebKit/WKWebView.h>
#import "MCGetIPFromUrl.h"

@interface WebViewTestController () <WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) LMJHorizontalScrollText * scrollText;
@property (nonatomic, strong) UILabel *normalTitleView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) BOOL hasRedirect;
@end

@implementation WebViewTestController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"很长文字标题的网页测试很长文字标题的网页测试很长文字标题的网页测试很长文字标题的网页测试很长文字标题的网页测试很长文字标题的网页测试";
    self.view.backgroundColor = UIColor.whiteColor;
    [self.navigationItem setTitleView:self.scrollText];
    CGFloat titleViewWidth = self.navigationItem.titleView.frame.size.width;
    
    CGSize strSize = [self.title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
    if (strSize.width < titleViewWidth) {
        if (_scrollText) {
            [_scrollText removeFromSuperview];
            _scrollText = nil;
        }
        [self.navigationItem setTitleView:self.normalTitleView];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"获取IP" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemAction)];
    
    NSString *urlS = @"https://tool.lu/ip/";
//    urlS = @"https://www.ip138.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlS]];
    [self.webView loadRequest:request];
}

-(void)rightItemAction {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [[MCGetIPFromUrl shareInstance] getIpFromUrl];
    [MCGetIPFromUrl shareInstance].getIpBlock = ^(BOOL success, NSString * _Nonnull error, NSString * _Nonnull ipStr) {
        NSString *descTitle = @"";
        if (success) {
            descTitle = [NSString stringWithFormat:@"IP：%@",ipStr];
        }else {
            descTitle = error;
        }
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:descTitle preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        [[MCGetIPFromUrl shareInstance] clean];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    };
}

-(NSString *)executeCommand:(NSString *)cmd {
    NSString *output = [NSString string];
    FILE *pipe = popen([cmd cStringUsingEncoding: NSASCIIStringEncoding], "r+");
    if (!pipe) return @"";
    
    char buf[1024];
    while(fgets(buf, 1024, pipe)) {
        output = [output stringByAppendingFormat: @"%s", buf];

    }
    pclose(pipe);
    return output;
}

-(WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:_webView];
    }
    return _webView;
}

-(UILabel *)normalTitleView {
    if (!_normalTitleView) {
        _normalTitleView = [UILabel new];
        _normalTitleView.text = self.title;
        _normalTitleView.textColor = UIColor.blackColor;
        _normalTitleView.font = [UIFont systemFontOfSize:18];
    }
    return _normalTitleView;
}

-(LMJHorizontalScrollText *)scrollText {
    if (!_scrollText) {
        _scrollText = [[LMJHorizontalScrollText alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _scrollText.text = self.title;
        _scrollText.textAlignment = NSTextAlignmentCenter;
        _scrollText.textColor = UIColor.blackColor;
        _scrollText.textFont = [UIFont systemFontOfSize:18];
        _scrollText.speed = 0.03;
        _scrollText.moveMode = LMJTextScrollWandering;
    }
    return _scrollText;
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
}

@end
