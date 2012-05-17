//
//  RectView.h
//  Statistics
//
//  Created by zhenby on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NUMBER_DEFAULT_FONT_SIZE 44
#define CAPTION_DEFAULT_FONT_SIZE 16
#define DEFAULT_INTERVAL_OF_NUMBER_AND_CAPTION 5
#define DIVIDER_LINE_WIDTH 0.5

typedef enum {
    TopRightLocation    = 1,
	TopLeftLocation     = 2,
	BottomLeftLocation  = 3,
	BottomRightLocation = 4,
    TopLocation         = 5,
    BottomLocation      = 6,
    RightLocation       = 7,
    LeftLocation        = 8
} RectCellLocation;

typedef enum {
    TopHalfLayout       = 1,
    TopBottomHalfLayout = 2,
    BottomHalfLayout    = 3,
    LeftHalfLayout      = 4,
    LeftRightHalfLayout = 5,
    RightHalfLayout     = 6,
    QuarterLayout       = 7
} RectLayoutType;

@interface RectCellView : UIView

@property(retain, nonatomic) NSNumber *number;
@property(retain, nonatomic) UIFont *numberFont;
@property(retain, nonatomic) UIColor *numberTextColor;

@property(retain, nonatomic) NSString *caption;
@property(retain, nonatomic) UIFont *captionFont;
@property(retain, nonatomic) UIColor *captionTextColor;

@property(assign, nonatomic) int intervalOfNumberAndCaption;

- (id)initWithNumber:(NSNumber *)number 
             caption:(NSString *)caption;
- (void)addTouchUpInsideActionWithTarget:(id) target 
                                selector:(SEL) selector;

@end

@interface RectView : UIView

@property(assign, nonatomic) RectLayoutType rectLayoutType;
@property(retain, nonatomic) NSDictionary *rectCellViews;

- (id)initWithFrame:(CGRect)frame rectLayoutType:(RectLayoutType) rectLayoutType;

@end
