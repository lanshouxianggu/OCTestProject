//
//  OTLPianoTaskChooseCommonView.m
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import "OTLPianoTaskChooseCommonView.h"

@interface OTLPianoTaskChooseCommonView () <UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *mainTopView;
@property (nonatomic, strong) UIView *mainBottomView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) TaskChooseType type;

@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, strong) NSArray <NSString *> *durationsArray;
@property (nonatomic, strong) NSArray <NSString *> *daysArray;
@property (nonatomic, strong) NSArray <NSString *> *speedArray;

@property (nonatomic, copy) NSString *selectStr;
@end

@implementation OTLPianoTaskChooseCommonView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.daysArray = @[@"1天",@"2天",@"3天",@"4天",@"5天",@"6天",@"7天"];
        self.durationsArray = @[
            @"15分钟",
            @"30分钟",
            @"45分钟",
            @"60分钟",
            @"75分钟",
            @"90分钟",
            @"105分钟",
            @"120分钟"];
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i=20; i<121; i++) {
            [tempArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        self.speedArray = tempArr;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.mainView];
    UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:touchBtn];
    [touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.offset(-245);
    }];
    [touchBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 取消
-(void)cancelAction {
    [self dismiss];
}

#pragma mark - 确定
-(void)confirmAction {
    if (self.selectBlock) {
        self.selectBlock(self.type,self.selectStr);
    }
    [self dismiss];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismiss];
//}

#pragma mark - show
-(void)showWithType:(TaskChooseType)type selectStr:(NSString *)selectStr {
    self.selectStr = selectStr;
    self.type = type;
    __block NSInteger index = 0;
    switch (type) {
        case TaskChooseTypePracticeDay:
        {
            self.titleLabel.text = @"请选择天数";
            [self.daysArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:selectStr]) {
                    index = idx;
                    *stop=YES;
                }
            }];
        }
            break;
        case TaskChooseTypePracticeDuration:
        {
            self.titleLabel.text = @"请选择时长";
            [self.durationsArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:selectStr]) {
                    index=idx;
                    *stop=YES;
                }
            }];
        }
            break;
        case TaskChooseTypeSpeed:
        {
            self.titleLabel.text = @"请选择速度";
            [self.speedArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:selectStr]) {
                    index=idx;
                    *stop=YES;
                }
            }];
        }
            break;
        default:
            break;
    }
    
    self.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
    [UIView animateWithDuration:0.15 animations:^{
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.4);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.transform = CGAffineTransformMakeTranslation(0, -236);
    }];
    [self.pickView reloadAllComponents];
    [self.pickView selectRow:index inComponent:0 animated:NO];
}

#pragma mark - dismiss
-(void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.transform = CGAffineTransformIdentity;
        self.backgroundColor = UIColorFromRGBA(0x000000, 0);
    }completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.type==TaskChooseTypePracticeDay) {
        return self.daysArray.count;
    }else if (self.type==TaskChooseTypePracticeDuration) {
        return self.durationsArray.count;
    }else if (self.type==TaskChooseTypeSpeed) {
        return self.speedArray.count;
    }
    return 0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.type==TaskChooseTypePracticeDay) {
        return self.daysArray[row];
    }else if (self.type==TaskChooseTypePracticeDuration) {
        return self.durationsArray[row];
    }else if (self.type==TaskChooseTypeSpeed) {
        return self.speedArray[row];
    }
    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.type) {
        case TaskChooseTypePracticeDay:
            self.selectStr = self.daysArray[row];
            break;
        case TaskChooseTypePracticeDuration:
            self.selectStr = self.durationsArray[row];
            break;
        case TaskChooseTypeSpeed:
            self.selectStr = self.speedArray[row];
            break;
        default:
            break;
    }
}

#pragma mark - lazy
-(UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 245)];;
        _mainView.backgroundColor = UIColor.whiteColor;
        _mainView.layer.cornerRadius = 9;
        _mainView.layer.masksToBounds = YES;
        
        [_mainView addSubview:self.mainTopView];
        [self.mainTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset(0);
            make.height.mas_equalTo(56);
        }];
        
        [_mainView addSubview:self.mainBottomView];
        [self.mainBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.top.equalTo(self.mainTopView.mas_bottom);
        }];
        
        [self.mainBottomView addSubview:self.pickView];
        [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return _mainView;
}

-(UIView *)mainTopView {
    if (!_mainTopView) {
        _mainTopView = [UIView new];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_mainTopView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.offset(0);
            make.width.mas_equalTo(62);
        }];
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:OTLAppMainColor forState:UIControlStateNormal];
        [confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_mainTopView addSubview:confirmBtn];
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.offset(0);
            make.width.mas_equalTo(62);
        }];
        
        [_mainTopView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [_mainTopView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _mainTopView;
}

-(UIView *)mainBottomView {
    if (!_mainBottomView) {
        _mainBottomView = [UIView new];
    }
    return _mainBottomView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColorFromRGB(0x3b3b3b);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

-(UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.showsSelectionIndicator = YES;
    }
    return _pickView;
}
@end
