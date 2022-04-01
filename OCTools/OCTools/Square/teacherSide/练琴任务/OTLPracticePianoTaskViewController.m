//
//  OTLPracticePianoTaskViewController.m
//  ChatClub
//
//  Created by stray s on 2022/3/30.
//  Copyright © 2022 ArcherMind. All rights reserved.
//

#import "OTLPracticePianoTaskViewController.h"
#import "OTLPracticePianoTaskFirstCell.h"
#import "OTLPracticePianoTaskSecondCell.h"

@interface OTLPracticePianoTaskViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *topMusicNameView;
@property (nonatomic, strong) UITableView *tableView;

///是否选中速度要求
@property (nonatomic, assign) BOOL isSelectSpeed;
///是否选中分解练习
@property (nonatomic, assign) BOOL isSelectDecomposition;
///是否选中全曲练习
@property (nonatomic, assign) BOOL isSelectAllPractice;
///是否选中智能测评
@property (nonatomic, assign) BOOL isSelectIntelligent;
@end

@implementation OTLPracticePianoTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"练琴任务";
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    [self setupUI];
}

-(void)setupUI {
    [self.view addSubview:self.topMusicNameView];
    [self.topMusicNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.topMusicNameView.mas_bottom);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        CGFloat offset = 359;
        if (self.isSelectDecomposition) {
            offset += 95;
        }
        if (self.isSelectAllPractice) {
            offset += 95;
        }
        if (self.isSelectIntelligent) {
            offset += 95;
        }
        return offset;
    }
    return 160;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        OTLPracticePianoTaskFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLPracticePianoTaskFirstCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[OTLPracticePianoTaskFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLPracticePianoTaskFirstCell"];
        }
        WS(weakSelf)
        [cell setUpdateConstraintBlock:^(BOOL isSelectDecomposition, BOOL isSelectAllPractice, BOOL isSelectIntelligent) {
            weakSelf.isSelectDecomposition = isSelectDecomposition;
            weakSelf.isSelectAllPractice = isSelectAllPractice;
            weakSelf.isSelectIntelligent = isSelectIntelligent;
//            NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:0];
//            [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf.tableView reloadData];
        }];
        return cell;
    }else if (indexPath.section==1) {
        OTLPracticePianoTaskSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLPracticePianoTaskSecondCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[OTLPracticePianoTaskSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLPracticePianoTaskSecondCell"];
        }
        return cell;
    }
    
    return [UITableViewCell new];
}

-(UIView *)topMusicNameView {
    if (!_topMusicNameView) {
        _topMusicNameView = [UIView new];
        UIImageView *imageV = [UIImageView new];
        _topMusicNameView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        imageV.backgroundColor = OTLAppMainColor;
        
        [_topMusicNameView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.offset(0);
        }];
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.text = @"曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目名称曲目...";
        nameLabel.textColor = UIColorFromRGB(0x333333);
        [_topMusicNameView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).offset(8);
            make.right.offset(-15);
            make.centerY.offset(0);
        }];
    }
    return _topMusicNameView;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:OTLPracticePianoTaskFirstCell.class forCellReuseIdentifier:@"OTLPracticePianoTaskFirstCell"];
        [_tableView registerClass:OTLPracticePianoTaskSecondCell.class forCellReuseIdentifier:@"OTLPracticePianoTaskSecondCell"];
    }
    return _tableView;
}
@end
