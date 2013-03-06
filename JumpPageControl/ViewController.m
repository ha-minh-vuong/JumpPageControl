//
//  ViewController.m
//  JumpPageControl
//
//  Created by Ha Minh Vuong on 3/5/13.
//  Copyright (c) 2013 Ha Minh Vuong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self createUI];
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:[UIDevice currentDevice]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI
{
    _scrollView = [[VGScrollView alloc] initWithFrame:self.view.bounds];
    _pageControl = [[UIPageControl alloc] init];
    // Setup scroll view
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    // Set up page control
    NSString *kPageHorizontal   = @"H:|-[_pageControl]-|";
    NSString *kPageVertical     = @"V:[_pageControl]-|";
    [self.view addSubview:_pageControl];
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kPageHorizontal
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_pageControl)]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kPageVertical
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_pageControl)]];
    [self.view addConstraints:constraints];
    _pageControl.numberOfPages = _scrollView.colors.count;
    [_pageControl addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
    [_pageControl vgRegisterTapOnIndicator];
}

- (void)orientationChanged:(NSNotification *)notification
{
    [self performSelector:@selector(handleRelayout) withObject:nil afterDelay:0.1f];

//    NSInteger page = self.pageControl.currentPage;
//    UIDevice *device = notification.object;
//    CGFloat width = 0.0;
//    switch (device.orientation) {
//        case UIDeviceOrientationLandscapeLeft:;
//        case UIDeviceOrientationLandscapeRight:
//            width = 480;
//            break;
//        case UIDeviceOrientationPortrait:;
//        case UIDeviceOrientationPortraitUpsideDown:
//            width = 320;
//            break;
//            
//        default:
//            break;
//    }

//    CGFloat width = self.scrollView.frame.size.width;
//    [self.scrollView setContentOffset:CGPointMake(page * width, 0) animated:YES];

//    NSLog(@"%f / %f = %d", x, width, self.pageControl.currentPage);
//    NSLog(@"page: %d, width: %f", page, width);
    /*
     It needs to perform relayout after orientation changed!
     When getting the scroll view properties directly in this method, 
     it gives old ones which belonged to the old orientation.
     */
}

- (void)handleRelayout
{
    CGFloat width = self.scrollView.bounds.size.width;
//    CGFloat x = self.scrollView.contentOffset.x;
//    self.pageControl.currentPage = x / width ;
    NSInteger page = self.pageControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake(page * width, 0) animated:NO];
//    NSLog(@"width: %f\nx: %f\npage:%d", width, x, page);
}

- (void)handlePageControl:(UIPageControl *)sender
{
    NSInteger page = self.pageControl.currentPage;
    CGFloat width = self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(page * width, 0) animated:YES];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = scrollView.bounds.size.width;
    self.pageControl.currentPage = x / width;
}

@end
