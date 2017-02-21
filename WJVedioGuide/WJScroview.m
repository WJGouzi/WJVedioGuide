//
//  WJScroview.m
//  WJVedioGuide
//
//  Created by 王钧 on 16/7/29.
//  Copyright © 2016年 王钧. All rights reserved.
//

#import "WJScroview.h"
#import "WJLabelScrollView.h"

#define wjMainScreenW [UIScreen mainScreen].bounds.size.width
#define WJMainScreenH [UIScreen mainScreen].bounds.size.height

@interface WJScroview ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) WJLabelScrollView *adScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation WJScroview

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imageView];
        
        [self addSubview:self.registerBtn];
        [self addSubview:self.loginBtn];
        
        [self addSubview:self.adScrollView];
        self.adScrollView.titles = @[@"全程记录你的健身数据", @"规范你的训练过程", @"陪伴你迈出跑步的第一步", @"分享汗水后你的性感"];
        self.pageControl.numberOfPages = self.adScrollView.titles.count;
    }
    
    return self;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        UIImage *image = [UIImage imageNamed:@"keep"];
        _imageView = [[UIImageView alloc] initWithImage:image];
        
        CGFloat X = (wjMainScreenW - image.size.width) * 0.5;
        CGFloat Y = WJMainScreenH * 0.25;
        _imageView.frame = CGRectMake(X, Y, image.size.width, image.size.height);
        
    }
    return _imageView;
}

- (UIButton *)registerBtn {
    
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = 20;
        CGFloat X = margin;
        CGFloat H = 50;
        CGFloat W = (wjMainScreenW - 3 * margin) * 0.5;
        CGFloat Y = WJMainScreenH - H - 15;
        _registerBtn.frame = CGRectMake(X, Y, W, H);
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.backgroundColor = [UIColor blackColor];
        _registerBtn.alpha = 0.4;
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius = 3;
        
    }
    return _registerBtn;
}

- (UIButton *)loginBtn {
    
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        CGFloat margin = 20;
        CGFloat H = 50;
        CGFloat W = (wjMainScreenW - 3 * margin) * 0.5;
        CGFloat X = wjMainScreenW - W - margin * 0.5;
        CGFloat Y = WJMainScreenH - H - 15;
        _loginBtn.frame = CGRectMake(X, Y, W, H);
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor whiteColor];
        _loginBtn.alpha = 0.4;
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 3.0;
        
    }
    return _loginBtn;
}

- (WJLabelScrollView *)adScrollView {
    
    if (!_adScrollView) {
        _adScrollView = [[WJLabelScrollView alloc] init];
        _adScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 105);
        _adScrollView.pageControl = self.pageControl;
    }
    return _adScrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        CGFloat W = self.adScrollView.titles.count * 5;
        _pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.adScrollView.frame) + 10, W, 10);
        _pageControl.currentPage = 0;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}
@end
