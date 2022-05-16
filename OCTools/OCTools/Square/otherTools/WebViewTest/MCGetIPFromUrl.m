//
//  MCGetIPFromUrl.m
//  ChatClub
//
//  Created by 刘创 on 2021/7/27.
//  Copyright © 2021 ArcherMind. All rights reserved.
//

#import "MCGetIPFromUrl.h"
#import <WebKit/WKWebView.h>

@interface MCGetIPFromUrl() <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) BOOL hasRedirect;
@end

@implementation MCGetIPFromUrl

+(instancetype)shareInstance {
    static MCGetIPFromUrl *defaultInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultInstance = [[MCGetIPFromUrl alloc] init];
    });
    
    return defaultInstance;
}

-(void)getIpFromUrl {
    self.hasRedirect = NO;
    NSString *urlS = @"https://tool.lu/ip/";
//    urlS = @"https://www.ip138.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlS]];
    [self.webView loadRequest:request];
}

-(WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_webView];
    }
    return _webView;
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    if (self.getIpBlock) {
        self.getIpBlock(NO, error.description, @"");
    }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //获取整个网页的HTML代码
    NSString *doc = @"document.body.outerHTML";
    [webView evaluateJavaScript:doc completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
        if (error) {
            NSLog(@"JSError:%@", error);
            if (self.getIpBlock) {
                self.getIpBlock(NO, error.description, @"");
            }
        }else {
            NSRange range = [htmlStr rangeOfString:@"你的外网IP地址是："];
            if (range.length) {
                htmlStr = [htmlStr substringFromIndex:range.location+range.length];
            }
            NSRange endRange = [htmlStr rangeOfString:@"</p>"];
            if (endRange.length) {
                htmlStr = [htmlStr substringToIndex:endRange.location];
            }
            if (self.getIpBlock) {
                self.getIpBlock(YES, @"", htmlStr);
            }
        }
        
//        if (!self.hasRedirect) {
//            NSString *redirectUrlStr = @"";
//            NSRange beginRange = [htmlStr rangeOfString:@"<iframe src="];
//            NSRange endRange = [htmlStr rangeOfString:@"/iframe>"];
//            if (beginRange.length && endRange.length) {
//                redirectUrlStr = [htmlStr substringFromIndex:beginRange.location+beginRange.length+1];
//                redirectUrlStr = [redirectUrlStr substringToIndex:endRange.location];
//                NSRange firstSpaceRange = [redirectUrlStr rangeOfString:@" "];
//                if (firstSpaceRange.length) {
//                    redirectUrlStr = [redirectUrlStr substringToIndex:firstSpaceRange.location-1];
//                }
//                redirectUrlStr = [NSString stringWithFormat:@"http:%@",redirectUrlStr];
//
//                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:redirectUrlStr]];
//                [webView loadRequest:request];
//                self.hasRedirect = YES;
//            }
//        }else {
//            NSString *doc02 =@"document.title";
//            [webView evaluateJavaScript:doc02
//              completionHandler:^(id _Nullable title,NSError * _Nullable error) {
//                if (error) {
//                    if (self.getIpBlock) {
//                        self.getIpBlock(NO, error.description, @"");
//                    }
//                }
//                NSLog(@"url--:%@",title);
//                NSRange range = [title rangeOfString:@"您的IP地址是："];
//                if (range.length) {
//                    title = [title substringFromIndex:range.location+range.length];
//                }
//                if (self.getIpBlock) {
//                    self.getIpBlock(YES, @"", title);
//                }
//            }] ;
//        }
    }];

}

-(void)clean {
    [_webView removeFromSuperview];
    _webView = nil;
}

@end
