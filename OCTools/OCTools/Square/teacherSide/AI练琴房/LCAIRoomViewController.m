//
//  LCAIRoomViewController.m
//  OCTools
//
//  Created by stray s on 2022/4/2.
//

#import "LCAIRoomViewController.h"
#import "AppDelegate.h"

@interface LCAIRoomViewController ()

@end

@implementation LCAIRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"AI练琴房";
    self.view.backgroundColor = UIColor.whiteColor;
    
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

@end
