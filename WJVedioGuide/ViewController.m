//
//  ViewController.m
//  WJVedioGuide
//
//  Created by 王钧 on 16/7/28.
//  Copyright © 2016年 王钧. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "WJScroview.h"


@interface ViewController ()

// @property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;

//@property (nonatomic, strong) AVPlayer *moviePlayer;
@property (nonatomic, strong) WJScroview *guideInfoView;


@property (nonatomic, strong) AVAudioSession *avaudioSession;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /**
     *  设置其他音乐软件播放的音乐不被打断
     */
    self.avaudioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [self.avaudioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    
    
    [self creatPlayUI];
    
    
}


#pragma mark - 懒加载
- (AVPlayer *)moviePlayer {
    
    if (!_moviePlayer) {
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"keep.mp4" ofType:nil]]];
        
        _moviePlayer = [[AVPlayer alloc] initWithPlayerItem:item];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStatusChanged:) name:AVPlayerItemDidPlayToEndTimeNotification  object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusChanged) name:nil object:nil];
        
    }
    
    
//    if (!_moviePlayer) {
//        // GCD创建单例
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"keep.mp4" ofType:nil]]];
//            
//            _moviePlayer = [[AVPlayer alloc] initWithPlayerItem:item];
//            
//            
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStatusChanged:) name:AVPlayerItemDidPlayToEndTimeNotification  object:nil];
//           

//        });
//    }
    
    return _moviePlayer;
    
}


- (void)creatPlayUI {
    
    // 创建播放界面
    AVPlayerLayer *player = [AVPlayerLayer playerLayerWithPlayer:self.moviePlayer];
    
    // 设置layer的frame
    player.frame = [UIScreen mainScreen].bounds;
    
    //
    [self.view.layer addSublayer:player];
    
    [self.moviePlayer play];
    
    // layer层上的操作实现不了scrollView的滑动
//    [player addSublayer:self.guideInfoView.layer];
   
    //
    [self.view addSubview:self.guideInfoView];
    
}

- (WJScroview *)guideInfoView {
    if (!_guideInfoView) {
        _guideInfoView = [[WJScroview alloc] init];
        _guideInfoView.frame = [UIScreen mainScreen].bounds;
       
    }
    return _guideInfoView;
}


// 程序被推倒后台再次进入的时候,视频继续播放
#warning 这里真机有bug
- (void)statusChanged {
    
    if (AVPlayerItemStatusReadyToPlay) {
        [self.moviePlayer play];
    }
}

// 视频播放完成的时候，再次进行播放
- (void)playStatusChanged:(NSNotification *)notification{
    //注册的通知  可以自动把 AVPlayerItem 对象传过来，只要接收一下就OK

    AVPlayerItem * playItem = [notification object];
    //关键代码
    [playItem seekToTime:kCMTimeZero];
        
    [_moviePlayer play];
    
    
}

// 注销掉通知中心。
- (void)dealloc {
    
    if (AVPlayerItemDidPlayToEndTimeNotification) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }

    if (@"statusChanged") {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
    }

}

@end
