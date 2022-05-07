//
//  OTLAfterClassSheetEndClassCell.m
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import "OTLAfterClassSheetEndClassCell.h"

@implementation OTLAfterClassSheetEndClassCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"结束课堂" forState:UIControlStateNormal];
        [btn setBackgroundColor:OTLAppMainColor];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        btn.layer.cornerRadius = 20;
        btn.layer.masksToBounds = YES;
        
        [btn addTarget:self action:@selector(endClassAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.height.mas_equalTo(40);
            make.top.bottom.offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH*0.314);
        }];
    }
    return self;
}

#pragma mark - 结束课堂
-(void)endClassAction {
    if (self.endClassBlock) {
        self.endClassBlock();
    }
}

@end
