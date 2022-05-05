//
//  AppDelegate.m
//  OCTools
//
//  Created by stray s on 2022/3/31.
//

#import "AppDelegate.h"
#import "LCLoginViewController.h"
#import "LCMainTabBarController.h"
#import "OTLDDLogFormatter.h"
#import "OTLDDLogFileLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucess) name:@"NOTIF_LOGIN_SUCCESS" object:nil];
    
    self.interfaceOrientation = UIInterfaceOrientationMaskPortrait;
    if (@available(iOS 13.0, *)) {
      
    } else {
      
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = [[LCLoginViewController alloc]init];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        
    }
    
    //初始化日志框架
    OTLDDLogFormatter *formatter = [[OTLDDLogFormatter alloc] init];
    OTLDDLogFileLogger *fileLogger = [[OTLDDLogFileLogger alloc] initWithFileName:@"我的模块"];
    
    [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
    [[DDOSLogger sharedInstance] setLogFormatter:formatter];
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
//    [DDLog addLogger:[DDOSLogger sharedInstance]];
    [DDLog addLogger:fileLogger];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:DDLogFlagInfo];
//
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor yellowColor] backgroundColor:nil forFlag:DDLogFlagError];
//
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor orangeColor] backgroundColor:nil forFlag:DDLogFlagWarning];
//
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    
    return YES;
}


-(void)loginSucess {
    if (@available(iOS 13.0, *)) {
      
    }else {
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = [[LCMainTabBarController alloc]init];
        [self.window makeKeyAndVisible];
    }
}

//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    return self.interfaceOrientation;
//}
//
//// 不允许设备自动旋转
//- (BOOL)shouldAutorotate {
//    return NO;
//}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
