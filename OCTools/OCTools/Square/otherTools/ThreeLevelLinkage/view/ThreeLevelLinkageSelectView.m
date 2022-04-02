//
//  ThreeLevelLinkageSelectView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/12/14.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "ThreeLevelLinkageSelectView.h"
#import "SelectFirstView.h"

const CGFloat kBottomViewHeight = 44.f;

@interface ThreeLevelLinkageSelectView()<UITableViewDelegate,UITableViewDataSource,SelectFirstViewDelegate>
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UITableView *cityTableView;
@property (nonatomic, strong) UITableView *areaTableView;
@property (nonatomic, strong) SelectFirstView *selectFirstView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *completeBtn;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *areaArray;
@property (nonatomic, strong) NSMutableArray *currentCitysArray;


@property (nonatomic, strong) NSString *currentProvince;
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) NSString *currentArea;
@property (nonatomic, strong) NSIndexPath *lastSelectCityIndexPath;
@property (nonatomic, strong) NSIndexPath *lastSelectAreaIndexPath;

@end

@implementation ThreeLevelLinkageSelectView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self getPlistData];
        [self setupUI];
    }
    return self;
}

-(void)getPlistData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *cityArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    if (cityArray) {
        for (NSDictionary *dic in cityArray) {
            NSString *province = [dic valueForKey:@"state"]?:@"";
            [self.provinceArray addObject:province];
        }
        self.selectFirstView.selectTitleArray = self.provinceArray;
        self.dataArray = [NSArray arrayWithArray:cityArray];
    }
}

-(void)setupUI {
    [self addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.offset(-kBottomViewHeight);
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(kBottomViewHeight);
    }];
}

-(NSMutableArray *)currentCitysArray {
    if (!_currentCitysArray) {
        _currentCitysArray = [NSMutableArray array];
    }
    return _currentCitysArray;
}

-(NSMutableArray *)provinceArray {
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

-(NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

-(NSMutableArray *)areaArray {
    if (!_areaArray) {
        _areaArray = [NSMutableArray array];
    }
    return _areaArray;
}

-(UIView *)mainView {
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = UIColor.whiteColor;
        
        [_mainView addSubview:self.selectFirstView];
        [self.selectFirstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH/3-20);
        }];
        
        [_mainView addSubview:self.cityTableView];
        [self.cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectFirstView.mas_right).offset(0);
            make.top.bottom.offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH-(SCREEN_WIDTH/3-20));
        }];
        
        [_mainView addSubview:self.areaTableView];
        [self.areaTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cityTableView.mas_right).offset(0);
            make.top.bottom.offset(0);
            make.width.equalTo(self.cityTableView);
        }];
    }
    return _mainView;
}

-(UITableView *)cityTableView {
    if (!_cityTableView) {
        _cityTableView = [UITableView new];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        _cityTableView.tableFooterView = [UIView new];
        _cityTableView.rowHeight = 35;
        _cityTableView.showsVerticalScrollIndicator = NO;
        
        [_cityTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _cityTableView;
}

-(UITableView *)areaTableView {
    if (!_areaTableView) {
        _areaTableView = [UITableView new];
        _areaTableView.delegate = self;
        _areaTableView.dataSource = self;
        _areaTableView.tableFooterView = [UIView new];
        _areaTableView.rowHeight = 35;
        _areaTableView.showsVerticalScrollIndicator = NO;
        
        [_areaTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _areaTableView;
}

-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.shadowColor = UIColor.blackColor.CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(0, -5);
        _bottomView.layer.shadowRadius = 8.f;
        _bottomView.layer.shadowOpacity = 0.3;
        
        UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [resetBtn setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
        resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:resetBtn];
        [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
        }];
        
        UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [completeBtn setBackgroundColor:UIColor.redColor];
        [completeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        completeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [completeBtn addTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:completeBtn];
        [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
        }];
    }
    return _bottomView;
}

-(SelectFirstView *)selectFirstView {
    if (!_selectFirstView) {
        _selectFirstView = [SelectFirstView new];
        _selectFirstView.delegate = self;
    }
    return _selectFirstView;
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.cityTableView]) {
        return self.cityArray.count;
    }
    return self.areaArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = UIColor.darkGrayColor;
    if ([tableView isEqual:self.cityTableView]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.cityArray[indexPath.row];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = self.areaArray[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = UIColor.redColor;
    if ([tableView isEqual:self.cityTableView]) {
        [self selectCityCellWithTitle:cell.textLabel.text];
        [self tableView:self.areaTableView didDeselectRowAtIndexPath:self.lastSelectAreaIndexPath];
        self.lastSelectCityIndexPath = indexPath;
    }
    if ([tableView isEqual:self.areaTableView]) {
        self.currentArea = cell.textLabel.text;
        self.lastSelectAreaIndexPath = indexPath;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = UIColor.darkGrayColor;
}

-(void)selectCityCellWithTitle:(NSString *)title {
    [self.areaArray removeAllObjects];
    self.currentCity = title;
    for (NSDictionary *dic in self.currentCitysArray) {
        NSString *city = [dic valueForKey:@"city"]?:@"";
        if ([city isEqualToString:title]) {
            NSArray *areaArr = [dic valueForKey:@"areas"];
            if (areaArr) {
                for (NSString *area in areaArr) {
                    [self.areaArray addObject:area];
                }
            }
        }
    }
    [self remakeTableViews];
    [self.areaTableView reloadData];
}

-(void)remakeTableViews {
    [self.cityTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectFirstView.mas_right).offset(0);
        make.top.bottom.offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-(SCREEN_WIDTH/3-20))/2);
    }];
    
    [self.areaTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityTableView.mas_right).offset(0);
        make.top.bottom.offset(0);
        make.width.equalTo(self.cityTableView);
    }];
}

#pragma mark - SelectFirstViewDelegate
-(void)btnSelectWithTitle:(NSString *)title {
    [self.cityArray removeAllObjects];
    [self.currentCitysArray removeAllObjects];
    self.currentProvince = title;
    for (NSDictionary *dic in self.dataArray) {
        NSString *province = [dic valueForKey:@"state"];
        if ([province isEqualToString:title]) {
            NSArray *cities = [dic valueForKey:@"cities"];
            if (cities) {
                self.currentCitysArray = [NSMutableArray arrayWithArray:cities];
                for (NSDictionary *dic in cities) {
                    NSString *city = [dic valueForKey:@"city"]?:@"";
                    [self.cityArray addObject:city];
                }
            }
        }
    }
    [self.cityTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectFirstView.mas_right).offset(0);
        make.top.bottom.offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-(SCREEN_WIDTH/3-20)));
    }];
    [self.cityTableView reloadData];
}

#pragma mark - 重置
-(void)resetAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(resetAction)]) {
        [self.delegate resetAction];
    }
}

#pragma mark - 完成
-(void)completeAction {if (self.delegate && [self.delegate respondsToSelector:@selector(completeActionWithProvince:city:area:)]) {
    [self.delegate completeActionWithProvince:self.currentProvince city:self.currentCity area:self.currentArea];
}
    
}
@end
