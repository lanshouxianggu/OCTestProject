//
//  GroupFileViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/4.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "GroupFileViewController.h"

@interface GroupFileViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation GroupFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.selectCount = 0;
    self.isAllSelect = NO;
    
    self.dataArray = @[@"",@"",@"",@"",@"",@""];
}

#pragma mark - setter
-(void)setIsAllSelect:(BOOL)isAllSelect {
    _isAllSelect = isAllSelect;
    [self.tableView reloadData];
}

#pragma mark - lazy load
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = DF_COLOR_0x(0xf8f8f8);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 60;
        
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = self.isAllSelect?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType==UITableViewScrollPositionNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectCount++;
    }else{
        cell.accessoryType = UITableViewScrollPositionNone;
        self.selectCount--;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCountChange:)]) {
        [self.delegate selectCountChange:self.selectCount];
    }
}

@end
