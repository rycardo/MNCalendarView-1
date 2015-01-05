//
//  MNViewController.m
//  MNCalendarViewExample
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "GACalendarView.h"
#import "MNCalendarView/NSDate+MNAdditions.h"
#import "MNViewController.h"

@interface MNViewController () <MNCalendarViewDelegate>

@property(nonatomic,strong) NSCalendar     *calendar;
@property(nonatomic,strong) GACalendarView *calendarView;
@property(nonatomic,strong) NSDate         *currentDate;

@property(strong) NSDate *startForbiddenDate;
@property(strong) NSDate *endForbiddenDate;

@end

@implementation MNViewController

- (instancetype)initWithCalendar:(NSCalendar *)calendar title:(NSString *)title {
  if (self = [super init]) {
    self.calendar = calendar;
    self.title = title;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = UIColor.whiteColor;
  
  self.currentDate = [NSDate date];

  
  self.calendar = [NSCalendar currentCalendar];
  self.calendar.firstWeekday = 2;
  
  NSDateComponents *componentsFirst = [[NSDateComponents alloc] init];
  [componentsFirst setCalendar:self.calendar];
  [componentsFirst setYear:2015];
  [componentsFirst setMonth:1];
  [componentsFirst setDay:1];
  [componentsFirst setHour:0];
  [componentsFirst setMinute:0];
  [componentsFirst setSecond:0];
  
  NSDateComponents *componentsLast = [[NSDateComponents alloc] init];
  [componentsLast setCalendar:self.calendar];
  [componentsLast setYear:2015];
  [componentsLast setMonth:1];
  [componentsLast setDay:15];
  [componentsLast setHour:0];
  [componentsLast setMinute:0];
  [componentsLast setSecond:0];
  
  self.calendarView = [[GACalendarView alloc] initWithFrame:self.view.bounds calendar:self.calendar];
  self.calendarView.selectedDate = [NSDate date];
  self.calendarView.fromDate = [self.calendar dateFromComponents:componentsFirst];
  self.calendarView.toDate = [self.calendar dateFromComponents:componentsLast];
  self.calendarView.delegate = self;
  self.calendarView.separatorColor = [UIColor lightGrayColor];
  self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
  self.calendarView.backgroundColor = UIColor.whiteColor;
  self.calendarView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
  
  self.startForbiddenDate = self.calendarView.fromDate;
  self.endForbiddenDate = self.calendarView.toDate;
  
  [self.view addSubview:self.calendarView];
  
  [self.calendarView reloadData];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [self.calendarView.collectionView.collectionViewLayout invalidateLayout];
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [self.calendarView reloadData];
}

#pragma mark - MNCalendarViewDelegate

- (void)calendarView:(MNCalendarView *)calendarView didSelectDate:(NSDate *)date {
  NSLog(@"date selected: %@", date);
}

- (BOOL)calendarView:(MNCalendarView *)calendarView shouldSelectDate:(NSDate *)date {
  return ([date compare:self.startForbiddenDate] == NSOrderedDescending && [date compare:self.endForbiddenDate] == NSOrderedAscending);
}

- (BOOL)calendarView:(MNCalendarView *)calendarView shouldCustomCellWithDate:(NSDate *)date {
  return ([date compare:self.startForbiddenDate] == NSOrderedDescending && [date compare:self.endForbiddenDate] == NSOrderedAscending);
}

- (UIColor *)calendarView:(MNCalendarView *)calendarView customBackgroundWithDate:(NSDate *)date {
  NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];

  if (dateComponents.weekday == 1 || dateComponents.weekday == 7) {
    return [UIColor yellowColor];
  }
  
  return [UIColor whiteColor];

}
/*
- (NSString *)calendarView:(MNCalendarView *)calendarView customBottomTextWithDate:(NSDate *)date {
  return @"Today";
}

- (UIColor *)calendarView:(MNCalendarView *)calendarView customTextColorWithDate:(NSDate *)date {
  return [UIColor yellowColor];
}
 */
@end
