//
//  BidLiveHomeViewController.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveHomeViewController.h"
#import "BidLiveHomeHeadView.h"
#import "BidLiveHomeFirstCell.h"
#import "BidLiveHomeFloatView.h"

@interface BidLiveHomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BidLiveHomeHeadView *topSearchView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BidLiveHomeFloatView *floatView;
@end

@implementation BidLiveHomeViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    if (@available(iOS 15.0,*)) {
        self.tableView.sectionHeaderTopPadding = 0;
    }
    [self.view addSubview:self.topSearchView];
    
    [self.view addSubview:self.floatView];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 550;
    }
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    }
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [UIView new];
    headView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    
    UILabel *lab = [UILabel new];
    lab.text = @[@"",@"直播专场",@"联拍讲堂",@"猜你喜欢"][section];
    lab.textColor = UIColor.cyanColor;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    [headView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        BidLiveHomeFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BidLiveHomeFirstCell" forIndexPath:indexPath];
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<CGRectGetHeight(self.topSearchView.frame)) {
        CGFloat alpha = offsetY/CGRectGetHeight(self.topSearchView.frame);
        NSLog(@"alpha = %f",alpha);
        self.topSearchView.backgroundColor = UIColorFromRGBA(0xf2f2f2, alpha);
    }else {
        self.topSearchView.backgroundColor = UIColorFromRGBA(0xf2f2f2,1);
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.15 animations:^{
        self.floatView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.15 animations:^{
        self.floatView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (decelerate) {
//        [UIView animateWithDuration:0.15 animations:^{
//            self.floatView.transform = CGAffineTransformMakeScale(1, 1);
//        }];
//    }
//}

#pragma mark - lazy
-(UITableView *)tableView {
    if (!_tableView) {
        CGFloat origionY = 0;
        if (UIApplication.sharedApplication.statusBarFrame.size.height>20) {
            origionY = -UIApplication.sharedApplication.statusBarFrame.size.height;
        }
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, origionY, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"BidLiveHomeFirstCell" bundle:nil] forCellReuseIdentifier:@"BidLiveHomeFirstCell"];
    }
    return _tableView;
}

-(BidLiveHomeHeadView *)topSearchView {
    if (!_topSearchView) {
        _topSearchView = [[BidLiveHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _topSearchView;
}

-(BidLiveHomeFloatView *)floatView {
    if (!_floatView) {
        _floatView = [[BidLiveHomeFloatView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-40, SCREEN_HEIGHT-100, 60, 60)];
    }
    return _floatView;
}
@end
