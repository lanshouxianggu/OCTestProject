//
//  LCMineViewController.m
//  OCTools
//
//  Created by stray s on 2022/4/1.
//

#import "LCMineViewController.h"

@interface LCMineViewController ()

@end

@implementation LCMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    self.view.backgroundColor = UIColor.blueColor;
    
    DDLogError(@"队长，别开枪，是我");
    DDLogWarn(@"哦，原来是狗屁贾队长");
    DDLogInfo(@"嗯，小的就是那狗屁贾队长");
    DDLogVerbose(@"说，是不是你小子一人把公厕吃的干干净净");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
