//
//  BidLiveHomeFirstCell.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveHomeFirstCell.h"
#import "BidLiveTopBannerView.h"

@interface BidLiveHomeFirstCell ()
@property (nonatomic, strong) BidLiveTopBannerView *bannerView;
@property (nonatomic, strong) NSArray *imageArray;
@property (weak, nonatomic) IBOutlet UIView *topBannerView;

@property (weak, nonatomic) IBOutlet UIView *scrollTitleView;
@end

@implementation BidLiveHomeFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.imageArray = @[UIColor.cyanColor,UIColor.blueColor,UIColor.yellowColor,UIColor.redColor];
    
    [self.topBannerView addSubview:self.bannerView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)domesticAuctionAction:(id)sender {
    [TipProgress showText:@"国内拍卖"];
}

- (IBAction)sendAuctionAction:(id)sender {
    [TipProgress showText:@"送拍"];
}


- (IBAction)lectureRoomAction:(id)sender {
    [TipProgress showText:@"讲堂"];
}

- (IBAction)globalAuctionAction:(id)sender {
    [TipProgress showText:@"全球拍卖"];
}

- (IBAction)appraisalAction:(id)sender {
    [TipProgress showText:@"鉴定"];
}

- (IBAction)informationAction:(id)sender {
    [TipProgress showText:@"资讯"];
}


#pragma mark - lazy
-(BidLiveTopBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[BidLiveTopBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.topBannerView.frame)) imgArray:self.imageArray];
    }
    return _bannerView;
}
@end
