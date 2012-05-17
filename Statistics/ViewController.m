//
//  ViewController.m
//  Statistics
//
//  Created by zhenby on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize rectView;

- (void)dealloc
{
    [rectView release];
    rectView = nil;
    
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
    
    rectView = [[RectView alloc] initWithFrame:self.view.frame rectLayoutType:QuarterLayout];
    
    RectCellView *topLeftRectCellView = [[RectCellView alloc] initWithNumber:
                                         [NSNumber numberWithInt:6] caption:@"总计看过本数"];
    topLeftRectCellView.numberTextColor = [UIColor orangeColor];
    
    
    RectCellView *topRightRectCellView = [[RectCellView alloc] initWithNumber:
                                         [NSNumber numberWithInt:711] caption:@"总计翻过页数"];
    topRightRectCellView.numberTextColor = [UIColor orangeColor];
    
    RectCellView *bottomLeftRectCellView = [[RectCellView alloc] initWithNumber:
                                         [NSNumber numberWithFloat:3.6] caption:@"总共阅读小时数"];
    bottomLeftRectCellView.numberTextColor = [UIColor orangeColor];
    
    RectCellView *bottomRightRectCellView = [[RectCellView alloc] initWithNumber:
                                          [NSNumber numberWithInt:15] caption:@"书架书籍总数"];
    bottomRightRectCellView.numberTextColor = [UIColor orangeColor];
    [bottomRightRectCellView addTouchUpInsideActionWithTarget:self selector:@selector(bottomRightTouch)];
    
    
    NSDictionary *rectCellViews = [NSDictionary dictionaryWithObjectsAndKeys:
                                   topLeftRectCellView, [NSNumber numberWithInt:TopLeftLocation], 
                                   topRightRectCellView, [NSNumber numberWithInt:TopRightLocation], 
                                   bottomLeftRectCellView, [NSNumber numberWithInt:BottomLeftLocation], 
                                   bottomRightRectCellView, [NSNumber numberWithInt:BottomRightLocation], 
                                   nil];
    
    rectView.rectCellViews = rectCellViews;
    
    [self.view addSubview:rectView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [rectView release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma - mark touch action handle
- (void)bottomRightTouch
{
    NSLog(@"bottom right touch");
}

@end
