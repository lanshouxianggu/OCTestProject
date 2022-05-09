//
//  OTLAfterClassSheetView.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLAfterClassSheetView.h"
#import "OTLAfterClassSheetPerformanceCell.h"
#import "OTLAfterClassSheetVideoCell.h"
#import "OTLAfterClassSheetCommentCell.h"
#import "OTLAfterClassSheetPianoTaskCell.h"
#import "OTLAfterClassSheetEndClassCell.h"

@interface OTLAfterClassSheetView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OTLAfterClassSheetView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.section) {
//        case 0:return 60;break;
//        case 1:return 92;break;
//        case 2:return 145;break;
//        case 3:return 218;break;
//        case 4:return 40;break;
//        default:
//            break;
//    }
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (@available(iOS 15.0, *)) {
        return 0;
    }
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma mark - 综合表现cell
    if (indexPath.section==0) {
        OTLAfterClassSheetPerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLAfterClassSheetPerformanceCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[OTLAfterClassSheetPerformanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLAfterClassSheetPerformanceCell"];
        }
        [cell updateStars:3];
        return cell;
    }
#pragma mark - 课堂视频cell
    if (indexPath.section==1) {
        OTLAfterClassSheetVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLAfterClassSheetVideoCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[OTLAfterClassSheetVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLAfterClassSheetVideoCell"];
        }
        __block OTLAfterClassSheetVideoCell *tmpCell = cell;
        WS(weakSelf)
        [cell setVideoAddBlock:^{
            [tmpCell.videosArr addObject:@""];
            [weakSelf.tableView reloadData];
            [tmpCell reloadData];
        }];
        [cell setVideoDeleteBlock:^(NSInteger index) {
            [tmpCell.videosArr removeObjectAtIndex:index];
            [weakSelf.tableView reloadData];
            [tmpCell reloadData];
        }];
        return cell;
    }
#pragma mark - 练琴任务cell
    if (indexPath.section==2) {
        OTLAfterClassSheetPianoTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLAfterClassSheetPianoTaskCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[OTLAfterClassSheetPianoTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLAfterClassSheetPianoTaskCell"];
        }
        WS(weakSelf)
        __block OTLAfterClassSheetPianoTaskCell *tmpCell = cell;
        [cell setTasksUpdateBlock:^{
            [tmpCell reloadData];
            [weakSelf.tableView reloadData];
        }];
        return cell;
    }
#pragma mark - 老师点评cell
    if (indexPath.section==3) {
        OTLAfterClassSheetCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLAfterClassSheetCommentCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[OTLAfterClassSheetCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLAfterClassSheetCommentCell"];
        }
        return cell;
    }
#pragma mark - 结束课堂cell
    if (indexPath.section==4) {
        OTLAfterClassSheetEndClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTLAfterClassSheetEndClassCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[OTLAfterClassSheetEndClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OTLAfterClassSheetEndClassCell"];
        }
        [cell setEndClassBlock:^{
                    
        }];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.contentView.layer.cornerRadius = 9;
    cell.contentView.layer.masksToBounds = YES;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - lazy
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width-30, self.frame.size.height)];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.estimatedRowHeight = 60;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:OTLAfterClassSheetPerformanceCell.class forCellReuseIdentifier:@"OTLAfterClassSheetPerformanceCell"];
        [_tableView registerClass:OTLAfterClassSheetVideoCell.class forCellReuseIdentifier:@"OTLAfterClassSheetVideoCell"];
        [_tableView registerClass:OTLAfterClassSheetCommentCell.class forCellReuseIdentifier:@"OTLAfterClassSheetCommentCell"];
        [_tableView registerClass:OTLAfterClassSheetPianoTaskCell.class forCellReuseIdentifier:@"OTLAfterClassSheetPianoTaskCell"];
        [_tableView registerClass:OTLAfterClassSheetEndClassCell.class forCellReuseIdentifier:@"OTLAfterClassSheetEndClassCell"];
    }
    return _tableView;
}
@end
