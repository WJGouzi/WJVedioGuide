//
//  PageViewController.m
//  WJVedioGuide
//
//  Created by 王钧 on 16/7/29.
//  Copyright © 2016年 王钧. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    
    }
    return self;
}


@end
