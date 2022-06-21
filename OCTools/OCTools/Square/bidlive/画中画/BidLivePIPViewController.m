//
//  BidLivePIPViewController.m
//  OCTools
//
//  Created by bidlive on 2022/6/21.
//

#import "BidLivePIPViewController.h"
#import <AVKit/AVKit.h>

@interface BidLivePIPViewController () <AVPictureInPictureControllerDelegate>
@property (nonatomic, strong) AVPictureInPictureController *pipVC;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playItem;
@property (nonatomic, strong) AVQueuePlayer *queuePlayer;
@property (nonatomic, strong) AVPlayerItem *loadingItem;
@property (nonatomic, strong) AVPlayerItem *testItem;

@property (nonatomic, strong) UIButton *pipBtn;
@end

@implementation BidLivePIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"测试画中画";
    self.view.backgroundColor = UIColor.whiteColor;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self startPip];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openOrClose) name:UIApplicationWillEnterForegroundNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.queuePlayer pause];
    [self.playerLayer removeFromSuperlayer];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)startPip {
    NSString *videoUrl = @"webrtc://5664.liveplay.myqcloud.com/live/5664_harchar1";
//    videoUrl = @"https://fileos.fdzq.com/go_fd_co/fd-1587373158-9t0y5n.mp4";
    videoUrl = @"https://qiniu.hongwan.com.cn/hongwan/v/990g76sj2wvedbs53vji.mp4";
//    videoUrl = @"https://qiniu.hongwan.com.cn/hongwan/v/1982wi5b4690f4rqbd9kk.mp4";
//    videoUrl = @"https://cdn2.bzjupinhang.com:65/20220222/3jE8F54h/475kb/hls/index.m3u8";
    
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionOrientationBack error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
//    self.playItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:videoUrl]];
//    self.player = [[AVPlayer alloc] initWithPlayerItem:self.playItem];
////    self.player = [AVPlayer playerWithURL:[NSURL URLWithString:videoUrl]];
//    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    [self.player play];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.queuePlayer];
    self.playerLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3);
    self.playerLayer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    [self.queuePlayer play];
    
    
    UIView *playView = [UIView new];
    playView.backgroundColor = UIColor.blackColor;
    [self.view addSubview:playView];
    [playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT/3);
    }];
    
    [playView.layer addSublayer:self.playerLayer];
    //1.判断是否支持画中画功能
    if ([AVPictureInPictureController isPictureInPictureSupported]) {
        self.pipVC = [[AVPictureInPictureController alloc] initWithPlayerLayer:self.playerLayer];
        self.pipVC.delegate = self;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"开启画中画" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.pipBtn = btn;
    [btn addTarget:self action:@selector(openOrClose) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"切换视频" forState:UIControlStateNormal];
    [btn1 setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(changeVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(btn.mas_bottom).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}

-(void)changeVideoAction:(UIButton *)btn {
    btn.enabled = NO;
    [self openPictureInPicture:@"https://cdn2.bzjupinhang.com:65/20220222/3jE8F54h/475kb/hls/index.m3u8"];
}

-(void)openPictureInPicture:(NSString *)url {
    if (!url || url.length == 0 ) return;
//    if (![url containsString:@"m3u8"]) return;
    // - 播放视频
    NSArray *keys = @[@"tracks"];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:url] options:nil];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^(){
        for (NSString *thisKey in keys) {
            NSError *error = nil;
            AVKeyValueStatus keyStatus = [asset statusOfValueForKey:thisKey error:&error];
            if (keyStatus != AVKeyValueStatusLoaded) {
                return ;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:asset];
            [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
            [self.queuePlayer replaceCurrentItemWithPlayerItem:item];
//            [self.queuePlayer replaceCurrentItemWithPlayerItem:self.playItem];
        });
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![keyPath isEqualToString:@"status"]) return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.queuePlayer.status == AVPlayerStatusReadyToPlay) {
            [self.queuePlayer play];
            
//            [self openOrClose];
        } else {
        }
    });
    if (object == self.loadingItem) {
        NSLog(@"beginItem %ld", (long)self.queuePlayer.status);
    }
//    else {
//        // - 如果当前开始使用 _queuePlayer 播放m3u8, 停止播放视频.
//        [[QIEPlayer shareInstance] stopPlay];
//        NSLog(@"// console [error] ... xxxxx");
//    }
}

- (void)openOrClose {
    if (self.pipVC.isPictureInPictureActive) {
        [self.pipVC stopPictureInPicture];
        [self.pipBtn setTitle:@"开启画中画" forState:UIControlStateNormal];
    } else {
        [self.pipVC startPictureInPicture];
        [self.pipBtn setTitle:@"关闭画中画" forState:UIControlStateNormal];
    }
}

-(AVPlayerItem *)loadingItem{
    if(!_loadingItem){
        _loadingItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"https://qiniu.hongwan.com.cn/hongwan/v/1982wi5b4690f4rqbd9kk.mp4"]];
        [_loadingItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _loadingItem;
}

-(AVPlayerItem *)testItem {
    if (!_testItem) {
        _testItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"https://qiniu.hongwan.com.cn/hongwan/v/1982wi5b4690f4rqbd9kk.mp4"]];
    }
    return _testItem;
}

- (AVQueuePlayer *)queuePlayer{
    if (!_queuePlayer) {
        _queuePlayer = [AVQueuePlayer queuePlayerWithItems:@[self.loadingItem,self.testItem]];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_mediaPlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_queuePlayer.currentItem];
        _queuePlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    }
    return _queuePlayer;
}

//各种代理
// 即将开启画中画
- (void)pictureInPictureControllerWillStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"");
}
// 已经开启画中画
- (void)pictureInPictureControllerDidStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"");
}
// 开启画中画失败
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController failedToStartPictureInPictureWithError:(NSError *)error {
    NSLog(@"%@", error);
}
// 即将关闭画中画
- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"");
}
// 已经关闭画中画
- (void)pictureInPictureControllerDidStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"");
}
// 关闭画中画且恢复播放界面
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler {
    NSLog(@"");
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
