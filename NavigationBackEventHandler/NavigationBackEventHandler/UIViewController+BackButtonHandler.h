//
//  UIViewController+BackButtonHandler.h
//  NavigationBackEventHandler
//
//  Created by qihaijun on 2/1/16.
//  Copyright © 2016 VictorChee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>

@optional
// Override this method in UIViewController derived class to handler 'Back' button click
- (BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController(BackButtonHandler) <BackButtonHandlerProtocol>

@end
