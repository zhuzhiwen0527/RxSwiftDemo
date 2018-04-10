//
//  ZWCalendarViewModel.h
//  ZWCalendar
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 zzw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZWCalendarItemsModel : NSObject
@property (copy, nonatomic) NSString * day;// 农历日期
@property (copy, nonatomic) NSString * festivalDay;//节日
@property (assign, nonatomic) BOOL isPastDay;
@property (assign, nonatomic) BOOL isWeekDay;
@property (assign, nonatomic) BOOL isSelected;
@end

@interface ZWCalendarModel : NSObject
@property (assign, nonatomic) NSUInteger year;// 年
@property (assign, nonatomic) NSUInteger month;//月
@property (strong, nonatomic) NSArray * dateArr;

@end

@interface ZWCalendarViewModel : NSObject
@property (nonatomic,strong,readonly) NSArray * dataSource;
@end
