//
//  ViewController.m
//  Statistics
//
//  Created by zhenby on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize rectView = _rectView;

- (void)dealloc
{
    [_rectView release];
    _rectView = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _rectView = [[RectView alloc] initWithFrame:self.view.frame
                                rectLayoutType:BottomHalfLayout
                                      delegate:self];
    [self.view addSubview:_rectView];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Touch Action Handle
- (void)bottomRightTouch
{
    NSLog(@"bottom right touch");
}

#pragma mark - RectViewDelegate
- (RectCellView *)rectCellViewInRectView:(RectView *)rectView inLocation:(RectCellLocation)location
{
    RectCellView *cellView = nil;
    switch (location) {
        case TopLeftLocation:
        {
            cellView = [[[RectCellView alloc] initWithNumber:[NSNumber numberWithInt:6]
                                                     caption:@"总计看过本数"]
                        autorelease];
            cellView.numberTextColor = [UIColor orangeColor];
            break;
        }
        case TopRightLocation:
        {
            cellView = [[[RectCellView alloc] initWithNumber:[NSNumber numberWithInt:711]
                                                     caption:@"总计翻过页数"]
                        autorelease];
            cellView.numberTextColor = [UIColor orangeColor];
            break;
        }
        case BottomLocation:
        {
            cellView = [[[RectCellView alloc] initWithNumber:[NSNumber numberWithInt:105]
                                                     caption:@"为阅读奋斗了多少个日夜"]
                        autorelease];
            cellView.numberTextColor = [UIColor orangeColor];
            break;
        }
            
        default:
            break;
    }
    
    return cellView;
}

@end
