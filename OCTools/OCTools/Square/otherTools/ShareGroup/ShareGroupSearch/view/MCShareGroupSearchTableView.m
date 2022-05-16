//
//  MCShareGroupSearchTableView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCShareGroupSearchTableView.h"
#import "MCSearchGroupFileModel.h"
#import "MCSearchShareGroupModel.h"
#import "MCSearchShareGroupCell.h"

@interface MCShareGroupSearchTableView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MCShareGroupSearchTableView

-(instancetype)init {
    if (self = [super init]) {
        [self initData];
        [self setupUI];
    }
    return self;
}

-(void)initData {
    self.dataArray = [NSMutableArray new];
    
    NSMutableArray *shareGroupArr = [NSMutableArray new];
    NSMutableArray *groupFileArr = [NSMutableArray new];
    for (int i = 0; i < 2; i++) {
        MCSearchShareGroupModel *model = [MCSearchShareGroupModel new];
        model.shareGroupName = @[@"教程共享群教程名称",@"共享群名称"][i];
        model.memberCount = @[@(27),@(21)][i];
        model.nickName = @[@"用户昵称",@"人员名称"][i];
        model.memberName = @[@"教程昵称",@"教程人员名称"][i];
        [shareGroupArr addObject:model];
    }
    for (int i = 0; i < 3; i++) {
        MCSearchGroupFileModel *model = [MCSearchGroupFileModel new];
        model.fileName = @[@"我的教程文件夹",@"我的教程文件夹2",@"教程文件.docx"][i];
        model.groupName = @[@"共享群的名称",@"共享群的名称",@"共享群的名称"][i];
        [groupFileArr addObject:model];
    }
    [self.dataArray addObject:shareGroupArr];
    [self.dataArray addObject:groupFileArr];
}

-(void)setSearchKey:(NSString *)searchKey {
    _searchKey = searchKey;
    NSMutableArray *shareGroupArr = [self.dataArray firstObject];
    NSMutableArray *groupFileArr = [self.dataArray lastObject];
    if (shareGroupArr) {
        for (MCSearchShareGroupModel *model in shareGroupArr) {
            model.searchKey = searchKey;
//            if (![model.nickName containsString:searchKey] &&
//                ![model.shareGroupName containsString:searchKey] &&
//                ![model.memberName containsString:searchKey]) {
//                [shareGroupArr removeObject:model];
//            }
        }
    }
    if (groupFileArr) {
        for (MCSearchGroupFileModel *model in groupFileArr) {
            model.searchKey = searchKey;
//            if (![model.fileName containsString:searchKey] && ![model.groupName containsString:searchKey]) {
//                [groupFileArr removeObject:model];
//            }
        }
    }
    [self.tableView reloadData];
}

-(void)setupUI {
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.rowHeight = 80;
        
        [_tableView registerClass:MCSearchShareGroupCell.class forCellReuseIdentifier:@"MCSearchShareGroupCell"];
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tempArr = self.dataArray[section];
    return tempArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [UIView new];
    headView.backgroundColor = DF_COLOR_BGMAIN;
    
    UILabel *tipLab = [UILabel new];
    NSArray *tempArr = self.dataArray[section];
    NSString *tips = section==0?[NSString stringWithFormat:@"%ld个相关共享群",tempArr.count]:[NSString stringWithFormat:@"%ld个相关群文件",tempArr.count];
    tipLab.text = tips;
    tipLab.textColor = UIColor.darkTextColor;
    tipLab.font = [UIFont systemFontOfSize:13];
    
    [headView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(15);
    }];
    
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCSearchShareGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCSearchShareGroupCell"];
    
    if (!cell) {
        cell = [[MCSearchShareGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MCSearchShareGroupCell"];
    }
    
    NSArray *tempArr = self.dataArray[indexPath.section];
    if (indexPath.section==0) {
        MCSearchShareGroupModel *model = tempArr[indexPath.row];
        cell.groupModel = model;
    }else if (indexPath.section==1) {
        MCSearchGroupFileModel *model = tempArr[indexPath.row];
        cell.fileModel = model;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        [self.delegate didSelectRowAtIndexPath:indexPath];
    }
}

@end
