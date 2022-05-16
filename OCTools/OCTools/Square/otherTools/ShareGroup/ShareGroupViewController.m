//
//  ShareGroupViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ShareGroupViewController.h"
#import "ShareGroupTableViewCell.h"
#import "ShareGroupModel.h"
#import "CreateShareGroupViewController.h"
#import "ShareGroupDetailInfoViewController.h"
#import "MCShareGroupSearchViewController.h"

@interface ShareGroupViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *topSearchView;
@end

@implementation ShareGroupViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"共享群组";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIBarButtonItem *addGroupItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroupAction)];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(messageAction)];
    
    self.navigationItem.rightBarButtonItems = @[addGroupItem,messageItem];
    
    [self.view addSubview:self.topSearchView];
    [self.topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsZero);
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.topSearchView.mas_bottom);
    }];
    
    self.dataArray = @[@{@"headImageUrl":@"",@"groupName":@"在线",@"groupDesc":@"123456共享了1个文件",@"updateDate":@"07月28日"},
                       @{@"headImageUrl":@"",@"groupName":@"122",@"groupDesc":@"您可以共享文件了",@"updateDate":@"07月23日"}];
}

#pragma mark - action
-(void)addGroupAction {
    CreateShareGroupViewController *vc = [[CreateShareGroupViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)messageAction {
    
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.rowHeight = 70;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:ShareGroupTableViewCell.class forCellReuseIdentifier:@"ShareGroupTableViewCell"];
    }
    return _tableView;
}

-(UIView *)topSearchView {
    if (!_topSearchView) {
        _topSearchView = [UIView new];
        _topSearchView.backgroundColor = UIColor.whiteColor;
        
        UIView *mainV = [UIView new];
        mainV.backgroundColor = DF_COLOR_BGMAIN;
        mainV.layer.cornerRadius = 20;
        
        [_topSearchView addSubview:mainV];
        [mainV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(10);
            make.center.offset(0);
            make.height.mas_equalTo(40);
        }];
        
        {
            UIImageView *searchImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
            [mainV addSubview:searchImageV];
            [searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.offset(0);
                make.left.offset(10);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
            
            UILabel *lab = [UILabel new];
            lab.text = @"搜索共享群、群成员、群文件";
            lab.textColor = UIColor.darkGrayColor;
            lab.font = [UIFont systemFontOfSize:15];
            
            [mainV addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.offset(0);
                make.left.equalTo(searchImageV.mas_right).offset(15);
            }];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
            
            [mainV addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsZero);
            }];
        };
    }
    return _topSearchView;
}

-(void)searchBtnAction {
    MCShareGroupSearchViewController *vc = [[MCShareGroupSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShareGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareGroupTableViewCell"];
    if (!cell) {
        cell = [[ShareGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShareGroupTableViewCell"];
    }
    NSDictionary *dic = self.dataArray[indexPath.row];
    ShareGroupModel *model = [ShareGroupModel new];
    model.headImageUrl = [dic valueForKey:@"headImageUrl"];
    model.groupName = [dic valueForKey:@"groupName"];
    model.groupDesc = [dic valueForKey:@"groupDesc"];
    model.updateDate = [dic valueForKey:@"updateDate"];
    
    [cell updateDataWithMode:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataArray[indexPath.row];
    ShareGroupDetailInfoViewController *vc = [ShareGroupDetailInfoViewController new];
    vc.subjectTitle = [dic valueForKey:@"groupName"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
