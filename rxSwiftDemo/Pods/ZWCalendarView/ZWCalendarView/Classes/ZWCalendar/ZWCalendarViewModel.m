//
//  ZWCalendarViewModel.m
//  ZWCalendar
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 zzw. All rights reserved.
//

#import "ZWCalendarViewModel.h"
#import "ZWCalendarManage.h"
@implementation ZWCalendarItemsModel

@end

@implementation ZWCalendarModel

@end
@interface ZWCalendarViewModel ()
@property (nonatomic, strong) ZWCalendarManage * calendarManage;
@property (nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation ZWCalendarViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.calendarManage =[ZWCalendarManage manage];
    }
    return self;
}
- (NSMutableArray*)dataSource{
    
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        
        NSDate * theDate = [NSDate date];
        BOOL isPastDay = YES;
        

        for (NSInteger j = 0; j < 3; j++) {
            
            [self.calendarManage checkThisMonthRecordFromToday:theDate];
            ZWCalendarModel * model = [[ZWCalendarModel alloc] init];
            model.year = self.calendarManage.year;
            model.month = self.calendarManage.month;
            
            NSMutableArray * items = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i<self.calendarManage.calendarDate.count; i++) {
                ZWCalendarItemsModel * item = [[ZWCalendarItemsModel alloc] init];
                item.day = self.calendarManage.calendarDate[i];
                item.festivalDay = self.calendarManage.chineseCalendarDate[i];
                if (i%7 == 0 || i%7 == 6) {
                    item.isWeekDay = YES;
                }
                if ([self.calendarManage.chineseCalendarDate[i]  isEqualToString:@"今天"]) {
                    item.isSelected = YES;
                    isPastDay = NO;
                }
                item.isPastDay = isPastDay;
                if ([NSString stringWithFormat:@"%@",self.calendarManage.calendarDate[i]].length ==0) {
                    item.isPastDay = YES;
                }
                [items addObject:item];
            }
            
            model.dateArr = items;
            [_dataSource addObject:model];
            
            
     
            NSLog(@"%ld",(self.calendarManage.days-self.calendarManage.todayInMonth));
            NSDate * date = [theDate dateByAddingTimeInterval:60*60*24* (self.calendarManage.days-self.calendarManage.todayInMonth+1)];
            theDate = date;
        }
      
    

        
    }
    return _dataSource;
}

@end
