//
//  OTLStudentSidePracticePianoTaskVC.m
//  OCTools
//
//  Created by stray s on 2022/5/10.
//

#import "OTLStudentSidePracticePianoTaskVC.h"
#import "OTLStudentSidePracticePianoTaskCell.h"
#import "OTLStudentSidePracticePianoTaskModel.h"

@interface OTLStudentSidePracticePianoTaskVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <OTLStudentSidePracticePianoTaskModel *> *tasksListArray;
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
    
    self.tasksListArray = [NSMutableArray array];
    
    [self loadData];
}

-(void)loadData {
    for (int i=0; i<3; i++) {
        OTLStudentSidePracticePianoTaskModel *model = [OTLStudentSidePracticePianoTaskModel new];
        NSMutableArray *tempArr = [NSMutableArray array];
        if (i==0) {
            model.taskDateTime = @"5.10-5.16";
            model.totalNeedTime = 3.5;
            model.totalAlreadyTime = 0;
            for (int j=0; j<4; j++) {
                OTLStudentSidePracticePianoTaskListModel *listModel = [OTLStudentSidePracticePianoTaskListModel new];
                listModel.number = j+1;
                listModel.musicName = [NSString stringWithFormat:@"卡卡真神气-%d",j+1];
                if (j==0) {
                    listModel.speed = 0;
                    listModel.audioPath = @"";
                    listModel.taskPart = @"基础";
                }else if (j==1) {
                    listModel.speed = 60;
                    listModel.audioPath = @"";
                    listModel.taskPart = @"提升";
                }else if (j==2) {
                    listModel.speed = 0;
                    listModel.audioPath = @"123";
                    listModel.taskPart = @"测评";
                }else if (j==3) {
                    listModel.speed = 80;
                    listModel.audioPath = @"123";
                    listModel.taskPart = @"提升";
                }
                [tempArr addObject:listModel];
            }
            model.listModel = tempArr;
        }else if (i==1) {
            model.taskDateTime = @"5.17-5.24";
            model.totalNeedTime = 6.5;
            model.totalAlreadyTime = 3;
            for (int j=0; j<2; j++) {
                OTLStudentSidePracticePianoTaskListModel *listModel = [OTLStudentSidePracticePianoTaskListModel new];
                listModel.number = j+1;
                listModel.musicName = [NSString stringWithFormat:@"卡卡真神气-%d",j+1];
                if (j==0) {
                    listModel.speed = 0;
                    listModel.audioPath = @"";
                    listModel.taskPart = @"基础";
                    listModel.alreadyPracticeTime = 210;
                }else if (j==1) {
                    listModel.speed = 60;
                    listModel.audioPath = @"";
                    listModel.taskPart = @"提升";
                }
                [tempArr addObject:listModel];
            }
            model.listModel = tempArr;
        }else if (i==2) {
            model.taskDateTime = @"5.25-6.1";
            model.totalNeedTime = 6.5;
            model.totalAlreadyTime = 3;
            OTLStudentSidePracticePianoTaskListModel *listModel = [OTLStudentSidePracticePianoTaskListModel new];
            listModel.number = 1;
            listModel.musicName = [NSString stringWithFormat:@"卡卡真神气卡卡真神气卡卡真神气卡卡真神气-1"];
            listModel.speed = 60;
            listModel.audioPath = @"123";
            listModel.taskPart = @"提升";
            listModel.alreadyPracticeTime = 10;
            [tempArr addObject:listModel];
            model.listModel = tempArr;
        }
        [self.tasksListArray addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasksListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OTLStudentSidePracticePianoTaskModel *model = self.tasksListArray[indexPath.row];
    if (model.listModel.count%2!=0) {
        return (model.listModel.count/2+1)*(174+15)+15+56;
    }
    return model.listModel.count/2*(174+15)+15+56;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OTLStudentSidePracticePianoTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLStudentSidePracticePianoTaskCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[OTLStudentSidePracticePianoTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLStudentSidePracticePianoTaskCell"];
    }
    cell.model = self.tasksListArray[indexPath.row];
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
