//
//  AppearanceApplyingStrategy.swift
//  NavigationAppearance
//
//  Created by qihaijun on 12/2/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

public class AppearanceApplyingStrategy {
    public func apply(appearance: Appearance?, toNavigationController navigationiController: UINavigationController, animated: Bool) {
        guard let appearance = appearance else {
            return
        }
        
        let navigationBar = navigationiController.navigationBar
        let toolbar = navigationiController.toolbar
        
        if !navigationiController.navigationBarHidden {
            navigationBar.setBackgroundImage(ImageRenderer.rederImageOfColor(appearance.navigationBar.backgroundColor), forBarMetrics: .Default)
            navigationBar.tintColor = appearance.navigationBar.tintColor
            navigationBar.barTintColor = appearance.navigationBar.barTintColor
            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: appearance.navigationBar.tintColor]
        }
        
        if !navigationiController.toolbarHidden {
            toolbar.setBackgroundImage(ImageRenderer.rederImageOfColor(appearance.toolBar.backgroundColor), forToolbarPosition: .Any, barMetrics: .Default)
            toolbar.tintColor = appearance.toolBar.tintColor
            toolbar.barTintColor = appearance.toolBar.barTintColor
        }
    }
}
