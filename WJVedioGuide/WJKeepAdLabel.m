//
//  WJKeepAdLabel.m
//  WJVedioGuide
//
//  Created by 王钧 on 16/7/30.
//  Copyright © 2016年 王钧. All rights reserved.
//

#import "WJKeepAdLabel.h"

@implementation WJKeepAdLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont fontWithName:@"Helvetica" size:23.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

@end
