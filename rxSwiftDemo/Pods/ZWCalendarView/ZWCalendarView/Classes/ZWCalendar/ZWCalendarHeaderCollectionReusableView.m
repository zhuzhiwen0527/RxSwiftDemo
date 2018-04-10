//
//  ZWCalendarHeaderCollectionReusableView.m
//  ZWCalendar
//
//  Created by apple on 2018/3/20.
//  Copyright © 2018年 zzw. All rights reserved.
//

#import "ZWCalendarHeaderCollectionReusableView.h"

@implementation ZWCalendarHeaderCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.datelab.frame =self.bounds;
}
- (void)createUI{
    
    self.datelab  =[[UILabel alloc] initWithFrame:self.bounds];
    self.datelab.backgroundColor = [UIColor grayColor];
    self.datelab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.datelab];
}
@end
