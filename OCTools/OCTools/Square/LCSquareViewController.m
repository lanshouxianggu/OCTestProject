//
//  LCSquareViewController.m
//  OCTools
//
//  Created by stray s on 2022/4/1.
//

#import "LCSquareViewController.h"
#import "LCSquareTableViewCell.h"
#import "OTLTeacherSideMainViewController.h"
#import "LCOtherToolsViewController.h"

@interface LCSquareViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *sectionArr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LCSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"广场";
    self.view.backgroundColor = UIColor.cyanColor;
    
    self.sectionArr = @[@"云上钢琴老师端",@"云上钢琴学生端",@"工具小玩意"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 150;
        
        [_tableView registerClass:LCSquareTableViewCell.class forCellReuseIdentifier:@"LCSquareTableViewCell"];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCSquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCSquareTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[LCSquareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LCSquareTableViewCell"];
    }
    cell.label.text = self.sectionArr[indexPath.section];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            OTLTeacherSideMainViewController *vc = [OTLTeacherSideMainViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
            [TipProgress showText:@"学生端"];
            break;
        case 2:
        {
            LCOtherToolsViewController *vc = [LCOtherToolsViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
