//
//  GACalendarView.m
//  MNCalendarViewExample
//
//  Created by Anthony Perozzo on 5/01/15.
//  Copyright (c) 2015 min. All rights reserved.
//

#import "GACalendarView.h"
#import "MNCalendarHeaderView.h"

@interface GACalendarView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,assign,readwrite) NSUInteger daysInWeek;

- (NSDate *)firstVisibleDateOfMonth:(NSDate *)date;
- (NSDate *)lastVisibleDateOfMonth:(NSDate *)date;

@end

@implementation GACalendarView

- (instancetype)initWithFrame:(CGRect)frame calendar:(NSCalendar *)calendar {
    if (self = [super initWithFrame:frame calendar:calendar]) {
        self.daysInWeek = 7;
    }
    return self;
}

- (NSDate *)firstVisibleDateOfMonth:(NSDate *)date {
    date = self.fromDate;
    
    NSDateComponents *components =
    [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                     fromDate:date];
    
    NSInteger offsetDays = 0 - components.weekday + self.calendar.firstWeekday;
    if (offsetDays > 0)
        offsetDays -= self.daysInWeek;
    
    return [self.calendar dateByAddingComponents:[NSDateComponents mn_dateComponentsWithConstant:offsetDays unit:NSCalendarUnitDay]
                                          toDate:date
                                         options:0];
}

- (NSDate *)lastVisibleDateOfMonth:(NSDate *)date {
    date = self.toDate;
    
    NSDateComponents *components =
    [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                     fromDate:date];
    
    NSInteger offsetDays = (self.calendar.firstWeekday - components.weekday - 1 + self.daysInWeek) % self.daysInWeek;
    return [self.calendar dateByAddingComponents:[NSDateComponents mn_dateComponentsWithConstant:offsetDays
                                                                                            unit:NSCalendarUnitDay]
                                          toDate:date
                                         options:0];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    MNCalendarHeaderView *headerView =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                       withReuseIdentifier:MNCalendarHeaderViewIdentifier
                                              forIndexPath:indexPath];
    headerView.frame = CGRectNull;

    return headerView;
}

@end
