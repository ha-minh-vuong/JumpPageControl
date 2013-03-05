//
//  ViewController.h
//  JumpPageControl
//
//  Created by Ha Minh Vuong on 3/5/13.
//  Copyright (c) 2013 Ha Minh Vuong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIPageControl+Jump.h"
#import "VGScrollView.h"

@interface ViewController : UIViewController
@property (nonatomic, strong) VGScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end
