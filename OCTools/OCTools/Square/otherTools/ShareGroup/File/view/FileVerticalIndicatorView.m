//
//  FileVerticalIndicatorView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/10.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "FileVerticalIndicatorView.h"

@interface FileVerticalIndicatorView () <UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGPoint origionCenter;
@end

@implementation FileVerticalIndicatorView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 15;
        self.layer.shadowColor = UIColor.blackColor.CGColor;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeZero;
        self.origionCenter = self.center;
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesAction:)];
        panGes.delegate = self;
        [self addGestureRecognizer:panGes];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"album_calendar_right"]];
        [self addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(14, 16));
            make.centerY.offset(0);
            make.right.offset(-20);
        }];
    }
    return self;
}

-(void)panGesAction:(UIPanGestureRecognizer *)ges {

    CGPoint point = [ges translationInView:self];
//    if (self.center.y < self.origionCenter.y) {
//        self.center = self.origionCenter;
//        return;
//    }
//    CGFloat maxY = SCREEN_HEIGHT-kStatusBarAndNavigationBarHeight-kTabbarSafeBottomMargin-self.frame.size.height/2;
//    if (self.center.y > maxY) {
//        self.center = CGPointMake(self.center.x, maxY);
//        return;
//    }
//    self.center = CGPointMake(self.center.x, self.center.y+point.y);
//    NSLog(@"indicatorViewCenterY:%f  %f  %f",SCREEN_HEIGHT-kStatusBarAndNavigationBarHeight-kTabbarSafeBottomMargin,self.center.y,self.center.y/(SCREEN_HEIGHT-kStatusBarAndNavigationBarHeight));
//    [ges setTranslation:CGPointZero inView:self];
    
    if (self.center.y >= self.origionCenter.y) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(indicatorViewMovedToPoint:andState:)]) {
            [self.delegate indicatorViewMovedToPoint:point andState:ges.state];
        }
    }
}



@end
