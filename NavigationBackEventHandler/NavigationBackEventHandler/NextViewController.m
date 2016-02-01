//
//  NextViewController.m
//  NavigationBackEventHandler
//
//  Created by qihaijun on 2/1/16.
//  Copyright © 2016 VictorChee. All rights reserved.
//

#import "NextViewController.h"
#import "UIViewController+BackButtonHandler.h"

@implementation NextViewController

- (BOOL)navigationShouldPopOnBackButton
{
    NSLog(@"will pop");
    return YES;
}

@end
