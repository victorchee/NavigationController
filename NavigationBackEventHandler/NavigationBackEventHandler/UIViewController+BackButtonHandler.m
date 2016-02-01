//
//  UIViewController+BackButtonHandler.m
//  NavigationBackEventHandler
//
//  Created by qihaijun on 2/1/16.
//  Copyright © 2016 VictorChee. All rights reserved.
//

#import "UIViewController+BackButtonHandler.h"

@implementation UIViewController(BackButtonHandler)

@end




@implementation UINavigationController(ShouldPopOnBackButton)

- (BOOL)navigationBar:(nonnull UINavigationBar *)navigationBar shouldPopItem:(nonnull UINavigationItem *)item
{
    if (self.viewControllers.count < navigationBar.items.count) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    if ([self.topViewController respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [self.topViewController navigationShouldPopOnBackButton];
    }
    
    if (shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // Workaround for iOS7.1
        for (UIView *subView in navigationBar.subviews) {
            if (subView.alpha < 1.0) {
                [UIView animateWithDuration:025 animations:^{
                    subView.alpha = 1.0;
                }];
            }
        }
    }
    return NO;
}

@end