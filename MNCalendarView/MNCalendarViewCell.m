//
//  MNCalendarViewCell.m
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNCalendarViewCell.h"

#define CIRCLE_BACKGROUND_COLOUR 	[UIColor colorWithRed:(158/255.0) green:(176/255.0) blue:(179/255.0) alpha:1.0]
#define CIRCLE_BORDER_COLOUR		[UIColor colorWithRed:(158/255.0) green:(176/255.0) blue:(179/255.0) alpha:1.0]
#define CIRCLE_TEXT_COLOUR			UIColor.whiteColor

void MNContextDrawLine(CGContextRef c, CGPoint start, CGPoint end, CGColorRef color, CGFloat lineWidth) {
  CGContextSetAllowsAntialiasing(c, false);
  CGContextSetStrokeColorWithColor(c, color);
  CGContextSetLineWidth(c, lineWidth);
  CGContextMoveToPoint(c, start.x, start.y - (lineWidth/2.f));
  CGContextAddLineToPoint(c, end.x, end.y - (lineWidth/2.f));
  CGContextStrokePath(c);
  CGContextSetAllowsAntialiasing(c, true);
}

NSString *const MNCalendarViewCellIdentifier = @"MNCalendarViewCellIdentifier";

@interface MNCalendarViewCell()

@property(nonatomic,strong,readwrite) UILabel *titleLabel;

@end

@implementation MNCalendarViewCell

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.whiteColor;
    self.contentView.backgroundColor = UIColor.clearColor;

    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.titleLabel.textColor = [UIColor darkTextColor];
    self.titleLabel.highlightedTextColor = CIRCLE_TEXT_COLOUR;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.userInteractionEnabled = NO;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.numberOfLines = 0;

    [self.contentView addSubview:self.titleLabel];

    /*
     *  MNCalendarView Customise the look for selected days
     *  Set any layer, colour, etc you want here.
     */
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.layer.backgroundColor = UIColor.clearColor.CGColor;
    backgroundView.backgroundColor = UIColor.clearColor;

    CALayer *circle         = [CALayer layer];
    circle.backgroundColor  = CIRCLE_BACKGROUND_COLOUR.CGColor;
    circle.borderColor      = CIRCLE_BORDER_COLOUR.CGColor;
    circle.borderWidth      = (1.0 * UIScreen.mainScreen.scale);
    circle.frame            = CGRectInset(self.bounds, 10, 10);
    circle.cornerRadius     = (circle.frame.size.width / 2);
    circle.masksToBounds    = YES;


    [backgroundView.layer insertSublayer:circle atIndex:0];


    self.selectedBackgroundView = backgroundView; //[[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    //self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.23f green:0.61f blue:1.f alpha:1.f];

    //self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.contentView.frame = self.bounds;
  self.selectedBackgroundView.frame = self.bounds;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGColorRef separatorColor = self.separatorColor.CGColor;

    CGFloat pixel = 1.0 / [UIScreen mainScreen].scale;

    MNContextDrawLine(context,
                      CGPointMake(0.0, (self.bounds.size.height - 1.0)),
                      CGPointMake(self.bounds.size.width, (self.bounds.size.height - 1.0)),
                      separatorColor,
                      pixel);

//  CGContextRef context = UIGraphicsGetCurrentContext();
//
//  CGColorRef separatorColor = self.separatorColor.CGColor;
//
//  CGFloat pixel = 1.f / [UIScreen mainScreen].scale;
//  MNContextDrawLine(context,
//                    CGPointMake(0.f, self.bounds.size.height),
//                    CGPointMake(self.bounds.size.width, self.bounds.size.height),
//                    separatorColor,
//                    pixel);
}

@end
