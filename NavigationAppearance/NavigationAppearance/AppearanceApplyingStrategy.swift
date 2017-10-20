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
        
        if !navigationiController.isNavigationBarHidden {
            navigationBar.setBackgroundImage(ImageRenderer.rederImageOfColor(color: appearance.navigationBar.backgroundColor), for: .default)
            navigationBar.tintColor = appearance.navigationBar.tintColor
            navigationBar.barTintColor = appearance.navigationBar.barTintColor
            navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: appearance.navigationBar.tintColor]
        }
        
        if !navigationiController.isToolbarHidden {
            toolbar?.setBackgroundImage(ImageRenderer.rederImageOfColor(color: appearance.toolBar.backgroundColor), forToolbarPosition: .any, barMetrics: .default)
            toolbar?.tintColor = appearance.toolBar.tintColor
            toolbar?.barTintColor = appearance.toolBar.barTintColor
        }
    }
}
