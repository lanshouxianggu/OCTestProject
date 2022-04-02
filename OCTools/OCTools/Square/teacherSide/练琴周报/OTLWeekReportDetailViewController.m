//
//  OTLWeekReportDetailViewController.m
//  TeacherSide
//
//  Created by stray s on 2022/3/2.
//  Copyright © 2022 YueHe. All rights reserved.
//

#import "OTLWeekReportDetailViewController.h"
#import "OTLWeekReportDetailTableViewCell.h"

@interface OTLWeekReportDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation OTLWeekReportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    [self loadData];
    [self setupUI];
}

-(void)loadData {
    self.dataArray = @[
    @{@"name":@"张小花",@"tasks":@[@{@"date":@"12.12-12.18",@"hasDone":@(YES),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},@{@"date":@"12.15-12.20",@"hasDone":@(NO),@"days":@"5",@"totalDays":@"5",@"time":@"3",@"totalTime":@"6"}]},
                
    @{@"name":@"张大花",@"tasks":@[@{@"date":@"12.12-12.18",@"hasDone":@(YES),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"}]},
    
    @{@"name":@"张小花",@"tasks":@[@{@"date":@"12.12-12.18",@"hasDone":@(YES),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},@{@"date":@"12.15-12.20",@"hasDone":@(NO),@"days":@"5",@"totalDays":@"5",@"time":@"3",@"totalTime":@"6"},@{@"date":@"12.12-12.18",@"hasDone":@(NO),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},@{@"date":@"12.12-12.18",@"hasDone":@(YES),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},]},
    
    @{@"name":@"张大花",@"tasks":@[@{@"date":@"12.12-12.18",@"hasDone":@(YES),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},@{@"date":@"12.12-12.18",@"hasDone":@(NO),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},@{@"date":@"12.12-12.18",@"hasDone":@(YES),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},@{@"date":@"12.12-12.18",@"hasDone":@(YES),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},@{@"date":@"12.12-12.18",@"hasDone":@(NO),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},@{@"date":@"12.12-12.18",@"hasDone":@(YES),@"days":@"5",@"totalDays":@"5",@"time":@"10",@"totalTime":@"6"},]},
    ];
}

-(void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OTLWeekReportDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLWeekReportDetailTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[OTLWeekReportDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLWeekReportDetailTableViewCell"];
    }
    cell.hasPractice = self.hasPractice;
    NSDictionary *dict = self.dataArray[indexPath.row];
    [cell updateWithDataDic:dict]; 
    return cell;
}

#pragma mark - lazy
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 100;
        
        [_tableView registerClass:OTLWeekReportDetailTableViewCell.class forCellReuseIdentifier:@"OTLWeekReportDetailTableViewCell"];
    }
    return _tableView;
}

@end
