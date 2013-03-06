//
//  UIPageControl+Jump.m
//  JumpPageControl
//
//  Created by Ha Minh Vuong on 3/5/13.
//  Copyright (c) 2013 Ha Minh Vuong. All rights reserved.
//

#import "UIPageControl+Jump.h"

@implementation UIPageControl (Jump)

- (void)vgRegisterTapOnIndicator
{
    NSArray *subviews = self.subviews;
    for (UIView *view in subviews) {
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRecogniser:)];
        [view addGestureRecognizer:recognizer];
    }
}

- (void)handleTapRecogniser:(UIGestureRecognizer *)recognizer
{
    UIView *view = recognizer.view;
    NSInteger index = [view.superview.subviews indexOfObject:view];
    self.currentPage = index;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
