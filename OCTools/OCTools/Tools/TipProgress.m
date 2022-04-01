//
//  TipProgress.m
//  ZhongdaBoyan
//
//  Created by JIMU on 15/4/9.
//  Copyright (c) 2015年 jimu. All rights reserved.
//

#import "TipProgress.h"
#import "AppDelegate.h"
@interface TipProgress ()
{
    UILabel *showlabel;
}
@end

@implementation TipProgress

singleton_implementation(TipProgress);
-(id)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        DF_APP;
        if (@available(iOS 13.0, *)) {
            [UIApplication.sharedApplication.keyWindow addSubview:self];
        }else {
            [app.window addSubview:self];
        }
//        self.tag = 5268;
        
        UIView *view = self;
        view.backgroundColor = RGBA(0, 0, 0, 0.6);
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 6;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(0);
        }];
        
        {
            UILabel *label = [[UILabel alloc]init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = DF_COLOR_WC(255);
            label.numberOfLines = 0;
            label.text = @"正在加载中...";
            label.font = [UIFont systemFontOfSize:17];
            [view addSubview:label];
            showlabel = label;
            [label sizeToFit];
            
            CGFloat offset = app.window.frame.size.width-40-38;
            if (@available(iOS 13.0, *)) {
                offset = UIApplication.sharedApplication.keyWindow.frame.size.width-40-38;
            }
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(18, 19, 18, 19));
                make.width.lessThanOrEqualTo(@(offset));
            }];
        }
    }
    self.alpha = 0;
    return self;
}

-(void)show:(NSTimeInterval)delay completion:(void (^ __nullable)(BOOL finished))completion
{
    [UIView animateWithDuration:delay animations:^{
        self.alpha = 1;
    } completion:^(BOOL result){
        [UIView animateWithDuration:delay delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0;
        } completion:completion];
    }];
}

-(void)setShowstring:(NSString *)showstring
{
    showlabel.text = showstring;
}
-(void)setType:(NSTipProgressType)type
{
    if (self.superview) {
        if (type == NSTipProgressTypeCenter) {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.offset(0);
            }];
        }
        if (type == NSTipProgressTypeTop) {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.top.offset(188);
            }];
        }
        if (type == NSTipProgressTypeBottom) {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.bottom.offset(-188);
            }];
        }
    }
}
+(void)showText:(NSString *)str type:(NSTipProgressType)type
{
    [TipProgress showText:str type:type delay:0.3 completion:nil];
}
+(void)showText:(NSString *)str type:(NSTipProgressType)type delay:(NSTimeInterval)delay completion:(void (^ __nullable)(BOOL finished))completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        DF_APP;
        if (@available(iOS 13.0, *)) {
            if (!IS_STRING(str) || UIApplication.sharedApplication.keyWindow==nil) {
                return;
            }
        }else {
            if (!IS_STRING(str) || app.window == nil) {
                return;
            }
        }
        TipProgress *tip = [TipProgress sharedTipProgress];
        [tip.superview bringSubviewToFront:tip];
        tip.showstring = str;
        tip.type = type;
        [tip show:delay completion:completion];
    });
}
+(void)showText:(NSString *)str
{
    return [TipProgress showText:str type:NSTipProgressTypeCenter];
}
+(void)showText:(NSString *)str delay:(NSTimeInterval)delay completion:(void (^ __nullable)(BOOL finished))completion
{
    [TipProgress showText:str type:NSTipProgressTypeCenter delay:delay completion:completion];
}
@end
