//
//  RectView.m
//  Statistics
//
//  Created by zhenby on 12-5-5.
//  Copyright (c) 2012年 zhenby All rights reserved.
//

#import "RectView.h"
#import <UIKit/UIKit.h>

@interface RectCellView()

@property(retain, nonatomic) id selectorTarget;
@property(assign, nonatomic) SEL touchUpInsideActionSelector;

@end

@implementation RectCellView

@synthesize number = _number;
@synthesize numberFont = _numberFont;
@synthesize numberTextColor = _numberTextColor;
@synthesize caption = _caption;
@synthesize captionFont = _captionFont;
@synthesize captionTextColor = _captionTextColor;
@synthesize intervalOfNumberAndCaption = _intervalOfNumberAndCaption;

@synthesize selectorTarget;
@synthesize touchUpInsideActionSelector;


-(void)dealloc
{
    [_number release];
    _number = nil;
    
    [_numberFont release];
    _numberFont = nil;
    
    [_numberTextColor release];
    _numberTextColor = nil;
    
    [_caption release];
    _caption = nil;
    
    [_captionFont release];
    _captionFont = nil;
    
    [_captionTextColor release];
    _captionTextColor = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithNumber:(NSNumber *)number 
             caption:(NSString *)caption
{
    self = [super init];
    if (self) {
        _number = number;
        _numberFont = [UIFont systemFontOfSize:NUMBER_DEFAULT_FONT_SIZE];
        _numberTextColor = [UIColor blackColor];
        _caption = caption;
        _captionFont = [UIFont systemFontOfSize:CAPTION_DEFAULT_FONT_SIZE];
        _captionTextColor = [UIColor blackColor];
        _intervalOfNumberAndCaption = DEFAULT_INTERVAL_OF_NUMBER_AND_CAPTION;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    // Background Fill
	CGContextSetFillColorWithColor(c, [[UIColor whiteColor] CGColor]);
	CGContextFillRect(c, rect);
    
    // calculate number and caption text size
    NSString *numberString = [self.number stringValue];
    CGSize numberTextSize = [numberString sizeWithFont:self.numberFont 
                                     constrainedToSize:self.bounds.size];
    CGSize captionTextSize = [self.caption sizeWithFont:self.captionFont 
                                      constrainedToSize:self.bounds.size];
    
    // calculate number and caption text Vertical coord
    CGFloat numberTextVerticalCoord = round((self.bounds.size.height - numberTextSize.height - captionTextSize.height - self.intervalOfNumberAndCaption) / 2.0);
    CGFloat captionTextVerticalCoord = round(numberTextVerticalCoord + numberTextSize.height + self.intervalOfNumberAndCaption);
    
    // draw number string
    CGPoint numberBeginDrawPoint = CGPointMake(round((self.bounds.size.width - numberTextSize.width) / 2.0), 
                                               numberTextVerticalCoord);
    [self.numberTextColor set];
    [numberString drawAtPoint:numberBeginDrawPoint withFont:self.numberFont];
    
    // draw caption string
    CGPoint captionBeginDrawPoint = CGPointMake(round(self.bounds.size.width - captionTextSize.width) / 2.0, 
                                            captionTextVerticalCoord);
    [self.captionTextColor set];
    [self.caption drawAtPoint:captionBeginDrawPoint withFont:self.captionFont];
}

#pragma - mark public method
- (void)addTouchUpInsideActionWithTarget:(id) target 
                                selector:(SEL) selector
{
    self.selectorTarget = target;
    self.touchUpInsideActionSelector = selector;
}

#pragma - mark RectCellView touch handle
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (nil != self.selectorTarget)
    {
        [self.selectorTarget performSelector:self.touchUpInsideActionSelector];
    }
}

@end



@interface RectView()

- (CGRect)frameOfRectCellLocation:(RectCellLocation) rectCellLocation;
- (void)addSubRectCellViewInLoaction:(RectCellLocation) rectCellLocation;
- (void)drawDividerLineWithVericalStartPoint:(CGPoint) verticalStartPoint 
                             vericalEndPoint:(CGPoint) verticalEndPoint 
                        horizontalStartPoint:(CGPoint) horizontalStartPoint
                          horizontalEndPoint:(CGPoint) horizontalEndPoint;

@end

@implementation RectView

@synthesize rectLayoutType = _rectLayoutType;
@synthesize rectCellViews;

- (void)dealloc
{
    [rectCellViews release];
    rectCellViews = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame rectLayoutType:(RectLayoutType) rectLayoutType
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _rectLayoutType = rectLayoutType;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat width = round(rect.size.width);
    CGFloat height = round(rect.size.height);
    CGFloat halfWidth = round(width / 2.0);
    CGFloat halfHeight = round(height / 2.0);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    // Background Fill
	CGContextSetFillColorWithColor(c, [[UIColor whiteColor] CGColor]);
	CGContextFillRect(c, rect);
    
    CGPoint verticalStartPoint;
    CGPoint verticalEndPoint;
    
    CGPoint horizontalStartPoint;
    CGPoint horizontalEndPoint;
    
	    
    switch (self.rectLayoutType) {
        case TopHalfLayout:
        {
            [self addSubRectCellViewInLoaction:TopLocation];
            [self addSubRectCellViewInLoaction:BottomLeftLocation];
            [self addSubRectCellViewInLoaction:BottomRightLocation];
            
            verticalStartPoint = CGPointMake(halfWidth, halfHeight);
            verticalEndPoint = CGPointMake(halfWidth, height);
            
            horizontalStartPoint = CGPointMake(0.0f, halfHeight);
            horizontalEndPoint = CGPointMake(width, halfHeight);
            
            break;
        }
        case BottomHalfLayout:
        {
            [self addSubRectCellViewInLoaction:TopLeftLocation];
            [self addSubRectCellViewInLoaction:TopRightLocation];
            [self addSubRectCellViewInLoaction:BottomLocation];
            
            verticalStartPoint = CGPointMake(halfWidth, 0.0f);
            verticalEndPoint = CGPointMake(halfWidth, halfHeight);
            
            horizontalStartPoint = CGPointMake(0.0f, halfHeight);
            horizontalEndPoint = CGPointMake(width, halfHeight);
            
            break;
        }
        case TopBottomHalfLayout:
        {
            [self addSubRectCellViewInLoaction:TopLocation];
            [self addSubRectCellViewInLoaction:BottomLocation];
            
            horizontalStartPoint = CGPointMake(0.0f, halfHeight);
            horizontalEndPoint = CGPointMake(width, halfHeight);
            
            break;
        }

        case RightHalfLayout:
        {
            [self addSubRectCellViewInLoaction:RightLocation];
            [self addSubRectCellViewInLoaction:TopLeftLocation];
            [self addSubRectCellViewInLoaction:BottomLeftLocation];
            
            verticalStartPoint = CGPointMake(halfWidth, 0.0f);
            verticalEndPoint = CGPointMake(halfWidth, height);
            
            horizontalStartPoint = CGPointMake(0.0f, halfHeight);
            horizontalEndPoint = CGPointMake(halfWidth, halfHeight);
            
            break;
        }
        case LeftHalfLayout:
        {
            [self addSubRectCellViewInLoaction:LeftLocation];
            [self addSubRectCellViewInLoaction:TopRightLocation];
            [self addSubRectCellViewInLoaction:BottomRightLocation];
            
            verticalStartPoint = CGPointMake(halfWidth, 0.0f);
            verticalEndPoint = CGPointMake(halfWidth, height);
            
            horizontalStartPoint = CGPointMake(halfWidth, halfHeight);
            horizontalEndPoint = CGPointMake(width, halfHeight);
            
            break;
        }
        case LeftRightHalfLayout:
        {
            [self addSubRectCellViewInLoaction:LeftLocation];
            [self addSubRectCellViewInLoaction:RightLocation];
            
            verticalStartPoint = CGPointMake(halfWidth, 0.0f);
            verticalEndPoint = CGPointMake(halfWidth, height);
            
            break;
        }
        case QuarterLayout:
        {
            [self addSubRectCellViewInLoaction:TopLeftLocation];
            [self addSubRectCellViewInLoaction:TopRightLocation];
            [self addSubRectCellViewInLoaction:BottomLeftLocation];
            [self addSubRectCellViewInLoaction:BottomRightLocation];
            
            verticalStartPoint = CGPointMake(halfWidth, 0.0f);
            verticalEndPoint = CGPointMake(halfWidth, height);
            
            horizontalStartPoint = CGPointMake(0.0f, halfHeight);
            horizontalEndPoint = CGPointMake(width, halfHeight);
            
            break;
        }
    }
    
    
    [self drawDividerLineWithVericalStartPoint:verticalStartPoint vericalEndPoint:verticalEndPoint horizontalStartPoint:horizontalStartPoint horizontalEndPoint:horizontalEndPoint];

}

#pragma - mark handle

- (CGRect)frameOfRectCellLocation:(RectCellLocation) rectCellLocation
{
    CGRect rectCellFrame = CGRectMake(0, 0, 0, 0);
    
    CGFloat width = round(self.frame.size.width);
    CGFloat height = round(self.frame.size.height);
    CGFloat halfWidth = round(self.frame.size.width / 2.0);
    CGFloat halfHeight = round(self.frame.size.height / 2.0);
    
    switch (rectCellLocation) {
        case TopRightLocation:
            rectCellFrame = CGRectMake(halfWidth + DIVIDER_LINE_WIDTH, 0.0f, 
                                       halfWidth, halfHeight - DIVIDER_LINE_WIDTH);
            break;
        case TopLeftLocation:
            rectCellFrame = CGRectMake(0.0f, 0.0f, 
                                       halfWidth - DIVIDER_LINE_WIDTH, 
                                       halfHeight - DIVIDER_LINE_WIDTH);
            break;
        case BottomLeftLocation:
            rectCellFrame = CGRectMake(0.0f, halfHeight + DIVIDER_LINE_WIDTH, 
                                       halfWidth - DIVIDER_LINE_WIDTH, halfHeight);
            break;
        case BottomRightLocation:
            rectCellFrame = CGRectMake(halfWidth + DIVIDER_LINE_WIDTH, 
                                       halfHeight + DIVIDER_LINE_WIDTH, 
                                       halfWidth, halfHeight);
            break;
        case TopLocation:
            rectCellFrame = CGRectMake(0.0f, 0.0f, width, halfHeight - DIVIDER_LINE_WIDTH);
            break;
        case BottomLocation:
            rectCellFrame = CGRectMake(0.0f, halfHeight + DIVIDER_LINE_WIDTH, width, halfHeight);
            break;
        case RightLocation:
            rectCellFrame = CGRectMake(halfWidth + DIVIDER_LINE_WIDTH, 0, halfWidth , height);
            break;
        case LeftLocation:
            rectCellFrame = CGRectMake(0, 0, halfWidth - DIVIDER_LINE_WIDTH, height);
            break;
    }
    
    return rectCellFrame;
}

- (void)addSubRectCellViewInLoaction:(RectCellLocation) rectCellLocation
{
    RectCellView *rectCellView = [[self.rectCellViews objectForKey:
                                     [NSNumber numberWithInt:rectCellLocation]] retain];
    if (nil != rectCellView)
    {
        rectCellView.frame = [self frameOfRectCellLocation:rectCellLocation];
        //rectCellView.backgroundColor = [UIColor whiteColor];
        [self addSubview:rectCellView];
    }
}

- (void)drawDividerLineWithVericalStartPoint:(CGPoint) verticalStartPoint 
                             vericalEndPoint:(CGPoint) verticalEndPoint 
                        horizontalStartPoint:(CGPoint) horizontalStartPoint
                          horizontalEndPoint:(CGPoint) horizontalEndPoint
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    // Vertical Divider
    CGContextMoveToPoint(c, verticalStartPoint.x, verticalStartPoint.y);
    CGContextAddLineToPoint(c, verticalEndPoint.x, verticalEndPoint.y);
    
    // Horizontal Divider
    CGContextMoveToPoint(c, horizontalStartPoint.x, horizontalStartPoint.y);
    CGContextAddLineToPoint(c, horizontalEndPoint.x, horizontalEndPoint.y);
    CGContextSetLineWidth(c, DIVIDER_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(c, [[UIColor grayColor] CGColor]);
    CGFloat dashArray[] = {1, 1};
    CGContextSetLineDash (c, 0, dashArray, 2);
    CGContextDrawPath(c, kCGPathStroke); 
}

@end
