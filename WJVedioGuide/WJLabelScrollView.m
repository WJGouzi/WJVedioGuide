//
//  WJLabelScrollView.m
//  WJVedioGuide
//
//  Created by 王钧 on 16/7/29.
//  Copyright © 2016年 王钧. All rights reserved.
//

#import "WJLabelScrollView.h"
#import "WJKeepAdLabel.h"

@interface WJLabelScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WJLabelScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        self.scrollsToTop = NO;
    }
    return self;
}



#pragma mark - 
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    self.pageControl.numberOfPages = _titles.count;
    
    //
    [self setBanner];
}

- (void)setBanner {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    WJKeepAdLabel *firstLabel = [[WJKeepAdLabel alloc] init];
    WJKeepAdLabel *lastLabel = [[WJKeepAdLabel alloc] init];
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = 30;
    CGFloat Y = self.bounds.size.height - H;
    
    for (int i = 0; i < self.titles.count; ++i) {
        if (i == 0) {
            firstLabel.text = self.titles[i];
        }
        if (i == self.titles.count - 1) {
            lastLabel.text = self.titles[i];
        }
        WJKeepAdLabel *keepLabel = [[WJKeepAdLabel alloc] initWithFrame:CGRectMake(i * W + W, Y, W, H)];
        
        keepLabel.text = self.titles[i];
        
        
        [self addSubview:keepLabel];
    }
    
    lastLabel.frame = CGRectMake(0, Y, W, H);
    [self addSubview:lastLabel];
    
    firstLabel.frame = CGRectMake((self.titles.count + 1) * W, Y, W, H);
    [self addSubview:firstLabel];
    
    self.contentSize = CGSizeMake((self.titles.count + 2) * W, 0);
    self.showsHorizontalScrollIndicator = NO;
    
    self.pagingEnabled = YES;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    [self setContentOffset:CGPointMake(W, 0) animated:YES];
    
    // 添加定时器
    [self addTimer];
}

#pragma mark - 定时器中的方法
- (void)nextLabel {
    NSInteger page = 0;
    if (self.pageControl.currentPage == self.titles.count - 1) {
        
        page = 0;
        
    }
    else {
        
        page = self.pageControl.currentPage + 1;
    }
    [self setContentOffset:CGPointMake((page + 1) * self.bounds.size.width, 0) animated:YES];
}

#pragma mark - 定时器
- (void)addTimer {
    
    //
    self.timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
    
    // 添加到主循环中
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 移除timer
- (void)removeTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {

    [self removeTimer];
}

#pragma mark - delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat scrollW = self.bounds.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    page--;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self removeTimer];
}

- (void)scrollViewDidStop:(UIScrollView *)scrollView {
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width;
    int page = (self.contentOffset.x + 0.5 * scrollW) / scrollW;
    if (page == 0){
        [self setContentOffset:CGPointMake(scrollW * self.titles.count, 0)];
    } else if (page == (self.titles.count + 1)) {
        [self setContentOffset:CGPointMake(scrollW , 0)];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewDidStop:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidStop:scrollView];
}



@end
