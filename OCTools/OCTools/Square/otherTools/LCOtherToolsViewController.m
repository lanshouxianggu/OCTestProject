//
//  LCOtherToolsViewController.m
//  OCTools
//
//  Created by 刘创 on 2022/4/1.
//

#import "LCOtherToolsViewController.h"
#import "LCSquareTableViewCell.h"
#import "MCCallLogsBackupViewController.h"
#import "ThreeLevelLinkageViewController.h"
#import "CommonServiceViewController.h"
#import "WebViewTestController.h"
#import "ShareGroupViewController.h"

@interface LCOtherToolsViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LCOtherToolsViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工具小玩意儿";
    self.view.backgroundColor = UIColorFromRGB(0xd2d2d2);
    
    self.dataArray = @[@"通话备份",@"三级联动",@"常用服务",@"网页测试",@"共享群"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCSquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCSquareTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[LCSquareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LCSquareTableViewCell"];
    }
    [cell setCornerRadius:50];
    cell.label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    cell.label.text = self.dataArray[indexPath.section];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            MCCallLogsBackupViewController *vc = [MCCallLogsBackupViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            ThreeLevelLinkageViewController *vc = [ThreeLevelLinkageViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            CommonServiceViewController *vc = [CommonServiceViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            WebViewTestController *vc = [WebViewTestController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            ShareGroupViewController *vc = [ShareGroupViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - lazy
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 100;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:LCSquareTableViewCell.class forCellReuseIdentifier:@"LCSquareTableViewCell"];
    }
    return _tableView;
}



@end
