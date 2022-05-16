//
//  MCShareGroupSearchViewController.m
//  ChatClub
//
//  Created by ArcherMind on 2020/9/21.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCShareGroupSearchViewController.h"
#import "MCCommonSearchNavView.h"
#import "MCShareGroupSearchTableView.h"
#import "MCCommonSearchHistoryView.h"
#import "ShareGroupDetailInfoViewController.h"
#import "FileBaseViewController.h"

@interface MCShareGroupSearchViewController () <MCCommonSearchNavViewDelegate,MCCommonSearchHistoryViewDelegate,MCShareGroupSearchTableViewDelegate>
@property (nonatomic, strong) MCCommonSearchNavView *topSearchView;
@property (nonatomic, strong) MCShareGroupSearchTableView *searchTableView;
@property (nonatomic, strong) MCCommonSearchHistoryView *searchHistoryView;
@end

@implementation MCShareGroupSearchViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DF_COLOR_BGMAIN;
        
    [self.view addSubview:self.topSearchView];
    [self.topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(kStatusBarAndNavigationBarHeight);
    }];
    
    
    [self.view addSubview:self.searchHistoryView];
    [self.searchHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.topSearchView.mas_bottom);
    }];
    
    [self.view addSubview:self.searchTableView];
    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.topSearchView.mas_bottom);
    }];
}

-(MCCommonSearchNavView *)topSearchView {
    if (!_topSearchView) {
        _topSearchView = [[MCCommonSearchNavView alloc] init];
        _topSearchView.delegate = self;
    }
    return _topSearchView;
}

-(MCShareGroupSearchTableView *)searchTableView {
    if (!_searchTableView) {
        _searchTableView = [MCShareGroupSearchTableView new];
        _searchTableView.hidden = YES;
        _searchTableView.delegate = self;
    }
    return _searchTableView;
}

-(MCCommonSearchHistoryView *)searchHistoryView {
    if (!_searchHistoryView) {
        _searchHistoryView = [MCCommonSearchHistoryView new];
        _searchHistoryView.delegate = self;
    }
    return _searchHistoryView;
}

#pragma mark - MCCommonSearchNavViewDelegate
-(void)didClickCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didSearch:(NSString *)searchKey {
//    [self.view endEditing:YES];
    self.searchHistoryView.searchKey = searchKey;
    self.searchTableView.searchKey = searchKey;
    self.searchHistoryView.hidden = YES;
    self.searchTableView.hidden = NO;
}

-(void)searchContentDidClear {
    self.searchHistoryView.hidden = NO;
    self.searchTableView.hidden = YES;
}

#pragma mark - MCCommonSearchHistoryViewDelegate
-(void)didSelectSearchItemWithSearchKey:(NSString *)searchKey {
    self.topSearchView.textField.text = searchKey;
}

#pragma mark - MCShareGroupSearchTableViewDelegate
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        ShareGroupDetailInfoViewController *vc = [ShareGroupDetailInfoViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==1) {
        FileBaseViewController *vc = [[FileBaseViewController alloc] init];
//        vc.navTitle = @"";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
