//
//  LCMainTabBar.m
//  OCTools
//
//  Created by stray s on 2022/3/31.
//

#import "LCMainTabBar.h"

@interface LCMainTabBar()
@property (nonatomic, strong) NSArray *titlesArr;
@property (nonatomic, strong) NSArray *normalImagesArr;
@property (nonatomic, strong) NSArray *selectImagesArr;
@end

@implementation LCMainTabBar

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titlesArr = @[@"首页",@"广场",@"发现",@"我的"];
        self.normalImagesArr = @[[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""]];
        self.selectImagesArr = @[[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""]];
    }
    return self;
}

-(void)setupUI {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:self.titlesArr[i] image:self.normalImagesArr[i] selectedImage:self.selectImagesArr[i]];
        [items addObject:barItem];
    }
    self.items = items;
}
@end
