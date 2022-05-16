//
//  LCMainTabBarController.m
//  OCTools
//
//  Created by stray s on 2022/4/1.
//

#import "LCMainTabBarController.h"
#import "LCMineViewController.h"
#import "LCEntertainmentViewController.h"
#import "LCDiscoveryViewController.h"
#import "LCSquareViewController.h"
#import "DiscoveryViewController.h"
#import "MainNavigationController.h"

@interface LCMainTabBarController () <UITabBarControllerDelegate>
@property (nonatomic, strong) NSArray *vcsArray;
@property (nonatomic, strong) NSArray *normalImagesArray;
@property (nonatomic, strong) NSArray *selectImagesArray;
@property (nonatomic, strong) NSArray *titlesArray;
@end

@implementation LCMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tabBar.tintColor = OTLAppMainColor;
    
    NSMutableArray *navsArray = [NSMutableArray array];
    for (int i=0; i < self.titlesArray.count; i++) {
        MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:self.vcsArray[i]];
        nav.title = self.titlesArray[i];
        nav.tabBarItem.image = self.normalImagesArray[i];
        nav.tabBarItem.selectedImage = self.selectImagesArray[i];
        nav.tabBarItem.tag = i;
        [navsArray addObject:nav];
    }
    self.viewControllers = navsArray;
    self.delegate = self;
    
    //iOS 15 tabbar会变半透明
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        appearance.backgroundImage = [UIImage convertViewToImage:effectView];
        self.tabBar.scrollEdgeAppearance = appearance;
    }
}

-(NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = @[@"广场",@"发现",@"娱乐",@"我的"];
    }
    return _titlesArray;
}

-(NSArray *)normalImagesArray {
    if (!_normalImagesArray) {
        _normalImagesArray = @[
            [UIImage imageNamed:@"tabbar_ketang_an"],
            [UIImage imageNamed:@"tabbar_chengguo_an_laoshi"],
            [UIImage imageNamed:@"tabbar_chengguo_an_laoshi"],
            [UIImage imageNamed:@"tabbar_wode_an_laoshi"]
        ];
    }
    return _normalImagesArray;
}

-(NSArray *)selectImagesArray {
    if (!_selectImagesArray) {
        _selectImagesArray = @[
            [UIImage imageNamed:@"tabbar_ketang_liang"],
            [UIImage imageNamed:@"tabbar_chengguo_liang_laoshi"],
            [UIImage imageNamed:@"tabbar_chengguo_liang_laoshi"],
            [UIImage imageNamed:@"tabbar_wode_liang_laoshi"]
        ];
    }
    return _selectImagesArray;
}

-(NSArray *)vcsArray {
    if (!_vcsArray) {
        _vcsArray = @[
            [LCSquareViewController new],
            [DiscoveryViewController new],
            [LCEntertainmentViewController new],
            [LCMineViewController new]
        ];
    }
    return _vcsArray;
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
