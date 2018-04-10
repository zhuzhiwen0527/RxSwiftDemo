//
//  ZWDateItemCollectionViewCell.m
//  ZWCalendar
//
//  Created by apple on 2018/3/20.
//  Copyright © 2018年 zzw. All rights reserved.
//

#import "ZWDateItemCollectionViewCell.h"
@interface ZWDateItemCollectionViewCell ()
@property(nonatomic,strong) UILabel * dateLab;
@property(nonatomic,strong) UILabel * festivalDayLab;
@end
@implementation ZWDateItemCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dateLab = [[UILabel alloc] init];
     
        self.dateLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.dateLab];
        self.festivalDayLab = [[UILabel alloc] init];
        self.festivalDayLab.font = [UIFont systemFontOfSize:10];
        self.festivalDayLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.festivalDayLab];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.festivalDayLab.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2);
    self.dateLab.frame = self.bounds;
}

- (void)setModel:(ZWCalendarItemsModel *)model{
    _model = model;
    self.dateLab.text = [NSString stringWithFormat:@"%@",model.day];
    self.festivalDayLab.text = [NSString stringWithFormat:@"%@",model.festivalDay];
    if (model.isWeekDay) {
        self.dateLab.textColor = [UIColor redColor];
    }else{
        self.dateLab.textColor = [UIColor blackColor];
    }
    if (model.isPastDay) {
        self.dateLab.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.dateLab.textColor = [UIColor grayColor];
    }else{
        self.dateLab.backgroundColor = [UIColor whiteColor];
    }
    if ([model.festivalDay isEqualToString:@"今天"]) {
        self.dateLab.textColor = [UIColor redColor];
    }
    if (model.isSelected) {
        self.dateLab.backgroundColor = [UIColor orangeColor];
    }
}
@end
