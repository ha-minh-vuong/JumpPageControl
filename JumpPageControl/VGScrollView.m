//
//  VGScrollView.m
//  JumpPageControl
//
//  Created by Ha Minh Vuong on 3/5/13.
//  Copyright (c) 2013 Ha Minh Vuong. All rights reserved.
//

#import "VGScrollView.h"

@interface VGScrollView()

@end

@implementation VGScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _colors = @[ [UIColor redColor],
                     [UIColor yellowColor],
                     [UIColor greenColor],
                     [UIColor cyanColor],
                     [UIColor blueColor] ];
        [_colors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            CGRect frame;
            frame.origin.x = self.bounds.size.width * idx;
            frame.origin.y = 0;
            frame.size = self.bounds.size;
            UIView *view = [[UIView alloc] initWithFrame:frame];
            view.backgroundColor = (UIColor *)obj;
            [self addSubview:view];
        }];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.contentSize = CGSizeMake(self.bounds.size.width * _colors.count, self.bounds.size.height);
        self.pagingEnabled = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        CGRect frame;
        frame.origin.x = self.bounds.size.width * idx;
        frame.origin.y = 0;
        frame.size = self.bounds.size;
        obj.frame = frame;
    }];
    self.contentSize = CGSizeMake(self.bounds.size.width * self.colors.count, self.bounds.size.height);
//    [self.superview setNeedsLayout];
}

@end
