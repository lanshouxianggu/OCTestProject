//
//  LCAIRoomViewController.m
//  OCTools
//
//  Created by stray s on 2022/4/2.
//

#import "LCAIRoomViewController.h"

@interface LCAIRoomViewController ()

@end

@implementation LCAIRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"AI练琴房";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setScreenOrientationTo:UIInterfaceOrientationLandscapeRight];
}


#pragma mark - 设置屏幕方向
- (void)setScreenOrientationTo:(UIInterfaceOrientation)orientation {
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    NSNumber *orientationTarget = [NSNumber numberWithInt:(int)orientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}


@end
