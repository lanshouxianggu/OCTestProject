//
//  ShareMomentViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/4.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ShareMomentViewController.h"
#import "ShareMomentHeadCell.h"
#import "ShareMomentNormalCell.h"

@interface ShareMomentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ShareMomentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DF_COLOR_0x(0xf8f8f8);
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
    self.dataArray = @[@[],@[@"",@""],@[@"",@"",@""]];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:ShareMomentHeadCell.class forCellReuseIdentifier:@"ShareMomentHeadCell"];
        [_tableView registerClass:ShareMomentNormalCell.class forCellReuseIdentifier:@"ShareMomentNormalCell"];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    if (section==0) {
        return 1;
    }
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 150;
    }
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [UIView new];
    headView.backgroundColor = UIColor.clearColor;
    
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        ShareMomentHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareMomentHeadCell"];
        if (!cell) {
            cell = [[ShareMomentHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShareMomentHeadCell"];
        }
        return cell;
    }else {
        ShareMomentNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareMomentNormalCell"];
        
        NSArray *tempArr = self.dataArray[indexPath.section];
        if (!cell) {
            cell = [[ShareMomentNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShareMomentNormalCell"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (indexPath.row==0) {
                [cell.mainView addRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight withSize:CGSizeMake(8, 8)];
            }
            if (indexPath.row==tempArr.count-1) {
                [cell.mainView addRoundedCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight withSize:CGSizeMake(8, 8)];
            }
        });
        return cell;
    }
    return nil;
}



@end
