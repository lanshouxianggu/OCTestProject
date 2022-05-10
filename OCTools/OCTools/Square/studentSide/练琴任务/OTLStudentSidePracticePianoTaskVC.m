//
//  OTLStudentSidePracticePianoTaskVC.m
//  OCTools
//
//  Created by stray s on 2022/5/10.
//

#import "OTLStudentSidePracticePianoTaskVC.h"
#import "OTLStudentSidePracticePianoTaskCell.h"

@interface OTLStudentSidePracticePianoTaskVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OTLStudentSidePracticePianoTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"练琴任务";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 445;
    }
    return 245;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OTLStudentSidePracticePianoTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLStudentSidePracticePianoTaskCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[OTLStudentSidePracticePianoTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLStudentSidePracticePianoTaskCell"];
    }
    if (indexPath.row==0) {
        cell.taskListArray = @[@"",@"",@""];
    }
    if (indexPath.row==1) {
        cell.taskListArray = @[@""];
    }
    return cell;
}

#pragma mark - lazy
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:OTLStudentSidePracticePianoTaskCell.class forCellReuseIdentifier:@"OTLStudentSidePracticePianoTaskCell"];
    }
    return _tableView;
}
@end
