//
//  OTLTeacherSideMainViewController.m
//  ChatClub
//
//  Created by stray s on 2022/3/30.
//  Copyright © 2022 ArcherMind. All rights reserved.
//

#import "OTLTeacherSideMainViewController.h"
#import "OTLPracticePianoTaskViewController.h"
#import "LCSquareTableViewCell.h"
#import "OTLPracticeWeekReportViewController.h"
#import "LCAIRoomViewController.h"

@interface OTLTeacherSideMainViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation OTLTeacherSideMainViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"云上钢琴老师端";
    self.view.backgroundColor = UIColorFromRGB(0xd2d2d2);
    
    self.dataArray = @[@"AI练琴房",@"练琴任务",@"练琴周报",@"线下一对一主课课后反馈单"];
    
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
            LCAIRoomViewController *vc = [LCAIRoomViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            OTLPracticePianoTaskViewController *vc = [OTLPracticePianoTaskViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            OTLPracticeWeekReportViewController *vc = [OTLPracticeWeekReportViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;;
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
