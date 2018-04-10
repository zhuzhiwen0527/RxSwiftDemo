//
//  ZWCalendarManage.h
//  ZWCalendar
//
//  Created by apple on 2018/3/20.
//  Copyright © 2018年 zzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWCalendarManage : NSObject
+ (ZWCalendarManage *)manage;

- (void)checkThisMonthRecordFromToday:(NSDate *)today;

@property (strong, nonatomic, readonly) NSArray * calendarDate;// 公历
@property (strong, nonatomic, readonly) NSArray * chineseCalendarDate;// 农历日期&节日&节气
@property (strong, nonatomic, readonly) NSArray * chineseCalendarDay;// 农历纯日期(不包含节日和节气)
@property (strong, nonatomic, readonly) NSArray * chineseCalendarMonth;// 农历月份

@property (assign, nonatomic, readonly) NSUInteger days;// 本月天数
@property (assign, nonatomic, readonly) NSInteger todayInMonth;// 今天在本月是第几天
@property (assign, nonatomic, readonly) NSUInteger dayInWeek;// 本月第一天是周几, 1为周日，以此类推
@property (assign, nonatomic, readonly) NSUInteger year;// 当前年
@property (assign, nonatomic, readonly) NSUInteger month;// 当前月
@property (assign, nonatomic, readonly) NSUInteger theMonth;// 本月
@property (assign, nonatomic, readonly) NSString * chineseYear;// 农历年
@property (assign, nonatomic, readonly) NSUInteger todayPosition;// 今天在所属月份中所处位置
@end
