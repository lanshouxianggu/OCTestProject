//
//  BidLievViewController.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLievViewController.h"
#import "LCSquareTableViewCell.h"
#import "BidLiveHomeViewController.h"

@interface BidLievViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation BidLievViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"联拍在线";
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.dataArray = @[@"首页",@"分类",@"拍卖结果",@"我的"];
    
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
            BidLiveHomeViewController *vc = [BidLiveHomeViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            UIViewController *vc = [UIViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            UIViewController *vc = [UIViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            UIViewController *vc = [UIViewController new];
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
