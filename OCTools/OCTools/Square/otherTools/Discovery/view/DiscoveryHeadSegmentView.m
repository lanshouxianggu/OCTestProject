//
//  DiscoveryHeadSegmentView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/18.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "DiscoveryHeadSegmentView.h"

@interface DiscoveryHeadSegmentView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *itemsArray;
@property (nonatomic, assign) CGFloat itemsTotalWidth;
@property (nonatomic, strong) NSMutableArray *btnsArray;
@property (nonatomic, strong) NSMutableArray *itemsViewArray;
@property (nonatomic, strong) NSMutableArray *itemsWidthArray;
@property (nonatomic, strong) NSMutableArray *offsetXArray;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIFont *selectFont;
@property (nonatomic, strong) UIView *bottomMoveLine;
@property (nonatomic, assign) CGFloat bottomLineHeight;
@property (nonatomic, assign) NSInteger lastSelectTag;
@end

@implementation DiscoveryHeadSegmentView


-(instancetype)initWithFrame:(CGRect)frame andItemTitles:(nonnull NSArray<NSString *> *)titlesArray{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        self.itemsArray = titlesArray;
        self.layer.shadowColor = UIColor.blackColor.CGColor;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowRadius = 8;
        self.layer.shadowOpacity = 0.5;
        self.lastSelectTag = 0;
        
        self.bottomLineHeight = 2;
        [self getItemsTotalWidth];
        [self setupUI];
    }
    return self;
}

-(void)getItemsTotalWidth {
    for (NSString *title in self.itemsArray) {
        CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium]} context:nil];
        self.itemsTotalWidth += (rect.size.width+20);
    }
}

-(void)updataUI:(NSArray *)dataArray {
    self.itemsArray = dataArray;
    [self setupUI];
}

-(void)setupUI {
    if (_scrollView) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
    }
    [self addSubview:self.scrollView];
    
    UIColor *normalColor = UIColor.darkGrayColor;
    UIColor *selectColor = UIColor.blueColor;
    CGFloat offsetX = 0;
    int i = 0;
    for (NSString *itemTitle in self.itemsArray) {
        
        CGRect rect = [itemTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.selectFont} context:nil];
        CGFloat itemWidth = rect.size.width+20;
        if (self.itemsTotalWidth<CGRectGetWidth(self.scrollView.frame)) {
            CGFloat redundanceWidth = CGRectGetWidth(self.scrollView.frame)-self.itemsTotalWidth;
            itemWidth += redundanceWidth/self.itemsArray.count;
        }else {
            self.scrollView.contentSize = CGSizeMake(self.itemsTotalWidth, self.frame.size.height);
        }
        [self.itemsWidthArray addObject:[NSNumber numberWithFloat:itemWidth]];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(offsetX, 0, itemWidth, self.frame.size.height)];
        view.backgroundColor = UIColor.whiteColor;
        [self.scrollView addSubview:view];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:itemTitle forState:UIControlStateNormal];
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        [btn setTitleColor:selectColor forState:UIControlStateSelected];
        btn.titleLabel.font = i==0? self.selectFont : self.normalFont;
        btn.tag = i;
        btn.selected = i==0;
        [btn addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnsArray addObject:btn];
        
        [view addSubview:btn];
        btn.frame = view.bounds;
        [self.itemsViewArray addObject:view];
        [self.offsetXArray addObject:@(offsetX)];
        offsetX += itemWidth;
        i++;
    }
    
    [self.scrollView addSubview:self.bottomMoveLine];
    UIButton *firstBtn = self.btnsArray.firstObject;
    CGFloat lineWidth = firstBtn.frame.size.width*2/3;
    CGFloat lineX = firstBtn.center.x-lineWidth/2;
    self.bottomMoveLine.frame = CGRectMake(lineX, self.frame.size.height-self.bottomLineHeight, lineWidth, self.bottomLineHeight);
}

#pragma mark - lazy
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(12, 0, self.frame.size.width-24, self.frame.size.height)];
        _scrollView.backgroundColor = UIColor.whiteColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.alwaysBounceHorizontal = YES;
    }
    return _scrollView;
}

-(UIView *)bottomMoveLine {
    if (!_bottomMoveLine) {
        _bottomMoveLine = [UIView new];
        _bottomMoveLine.backgroundColor = UIColor.blueColor;
    }
    return _bottomMoveLine;
}

-(NSMutableArray *)btnsArray {
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}

-(NSMutableArray *)itemsViewArray {
    if (!_itemsViewArray) {
        _itemsViewArray = [NSMutableArray array];
    }
    return _itemsViewArray;
}

-(NSMutableArray *)offsetXArray {
    if (!_offsetXArray) {
        _offsetXArray = [NSMutableArray array];
    }
    return _offsetXArray;
}

-(NSMutableArray *)itemsWidthArray {
    if (!_itemsWidthArray) {
        _itemsWidthArray = [NSMutableArray array];
    }
    return _itemsWidthArray;
}

-(UIFont *)normalFont {
    if (!_normalFont) {
        _normalFont = [UIFont systemFontOfSize:14];
    }
    return _normalFont;
}

-(UIFont *)selectFont {
    if (!_selectFont) {
        _selectFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    }
    return _selectFont;
}

#pragma mark - action
-(void)itemAction:(UIButton *)sender {
    if (sender.tag == self.lastSelectTag) {
        return;
    }
    [self needMoveScrollWithIndex:sender.tag];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.delegate didSelectItemAtIndex:sender.tag];
    }
//    int i = 0;
//    for (UIButton *btn in self.btnsArray) {
//        if (btn.tag == sender.tag) {
//            btn.titleLabel.font = self.selectFont;
//
//
//            CGFloat offsetX = [self.offsetXArray[i] floatValue];
//            CGFloat lineWidth = sender.frame.size.width*2/3;
//            CGFloat lineX = offsetX+lineWidth/4;
//            CGRect newFrame = self.bottomMoveLine.frame;
//            newFrame.size.width = lineWidth;
//            newFrame.origin.x = lineX;
//            [UIView animateWithDuration:0.35 animations:^{
//                self.bottomMoveLine.frame = newFrame;
//                btn.selected = YES;
//            }];
//
//            [self needMoveScrollWithIndex:sender.tag];
//        }else{
//            btn.titleLabel.font = self.normalFont;
//            btn.selected = NO;
//        }
//        i++;
//    }
//    self.lastSelectTag = sender.tag;
}

-(void)needMoveScrollWithIndex:(NSInteger)index {
    int i = 0;
    for (UIButton *btn in self.btnsArray) {
        if (btn.tag == index) {
            btn.titleLabel.font = self.selectFont;
            
            
            CGFloat offsetX = [self.offsetXArray[i] floatValue];
            CGFloat lineWidth = btn.frame.size.width*2/3;
            CGFloat lineX = offsetX+lineWidth/4;
            CGRect newFrame = self.bottomMoveLine.frame;
            newFrame.size.width = lineWidth;
            newFrame.origin.x = lineX;
            [UIView animateWithDuration:0.35 animations:^{
                self.bottomMoveLine.frame = newFrame;
                btn.selected = YES;
            }];
            
        }else{
            btn.titleLabel.font = self.normalFont;
            btn.selected = NO;
        }
        i++;
    }
    self.lastSelectTag = index;
    
    CGRect rectForSelectedIndex = CGRectZero;
    CGFloat selectedSegmentOffset = 0;
    NSInteger j = 0;
    CGFloat offsetter = 0;
    CGFloat itemWidth = [[self.itemsWidthArray objectAtIndex:index] floatValue];
    for (NSNumber *width in self.itemsWidthArray) {
        if (index==j) {
            break;
        }
        offsetter += [width floatValue];
        j++;
    }
    rectForSelectedIndex = CGRectMake(offsetter, 0, itemWidth, self.frame.size.height);
    selectedSegmentOffset = CGRectGetWidth(self.scrollView.frame)/2 - itemWidth/2;
    
    CGRect rectToScrollTo = rectForSelectedIndex;
    rectToScrollTo.origin.x -= selectedSegmentOffset;
    rectToScrollTo.size.width += selectedSegmentOffset*2;
    [self.scrollView scrollRectToVisible:rectToScrollTo animated:YES];
    
}

@end
