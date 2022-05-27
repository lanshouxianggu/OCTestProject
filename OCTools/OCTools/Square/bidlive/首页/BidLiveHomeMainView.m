//
//  BidLiveHomeMainView.m
//  LiveFloatPlugin
//
//  Created by bidlive on 2022/5/26.
//

#import "BidLiveHomeMainView.h"
#import "BidLiveHomeHeadView.h"
#import "BidLiveHomeFirstCell.h"
#import "BidLiveHomeFirstTableViewCell.h"
#import "BidLiveHomeFloatView.h"
#import "Masonry.h"
#import "LCConfig.h"

@interface BidLiveHomeMainView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BidLiveHomeHeadView *topSearchView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BidLiveHomeFloatView *floatView;

@end

@implementation BidLiveHomeMainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0xf8f8f8);
        [self setupUI];
        
        UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        [self addGestureRecognizer:swipeGes];
    }
    return self;
}

-(void)swipeAction:(UISwipeGestureRecognizer *)ges {
    if (ges.direction==UISwipeGestureRecognizerDirectionRight) {
//        [UIView animateWithDuration:0.35 animations:^{
//            self.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
//        }completion:^(BOOL finished) {
//            [self removeFromSuperview];
//        }];
    }
}

-(void)setupUI {
    [self addSubview:self.tableView];
    //用@available方法在编译库打包的时候会报错Undefined symbols "__isPlatformVersionAtLeast"
//    if (@available(iOS 15.0, *)) {
//        self.tableView.sectionHeaderTopPadding = 0;
//    } else {
//        // Fallback on earlier versions
//    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 15.0) {
        self.tableView.sectionHeaderTopPadding = 0;
    }
    [self addSubview:self.topSearchView];
    
    [self addSubview:self.floatView];
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
//        BidLiveHomeFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BidLiveHomeFirstCell" forIndexPath:indexPath];
        BidLiveHomeFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BidLiveHomeFirstTableViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[BidLiveHomeFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BidLiveHomeFirstTableViewCell"];
        }
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
       [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
       // 停止类型3
       BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
       if (dragToDragStop) {
          [self scrollViewDidEndScroll];
       }
  }
}

#pragma mark - scrollView 停止滚动监测
- (void)scrollViewDidEndScroll {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.15 animations:^{
            self.floatView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    });
}


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
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:BidLiveHomeFirstTableViewCell.class forCellReuseIdentifier:@"BidLiveHomeFirstTableViewCell"];
        
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
