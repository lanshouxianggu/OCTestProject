//
//  BidLiveHomeViewController.m
//  OCTools
//
//  Created by bidlive on 2022/5/25.
//

#import "BidLiveHomeViewController.h"
#import "BidLiveHomeMainView.h"

@interface BidLiveHomeViewController ()
@property (nonatomic, strong) BidLiveHomeMainView *mainView;
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
    
    [self.view addSubview:self.mainView];
}

-(BidLiveHomeMainView *)mainView {
    if (!_mainView) {
        _mainView = [[BidLiveHomeMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    }
    return _mainView;
}

@end
