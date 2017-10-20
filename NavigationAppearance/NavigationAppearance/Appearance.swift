//
//  Appearance.swift
//  NavigationAppearance
//
//  Created by qihaijun on 12/2/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

public struct Appearance: Equatable {
    public struct Bar: Equatable {
        var style: UIBarStyle = .default
        var backgroundColor = UIColor(red: 234 / 255, green: 46 / 255, blue: 73 / 255, alpha: 1)
        var tintColor = UIColor.white
        var barTintColor: UIColor?
    }
    
    var statusBarStyle: UIStatusBarStyle = .default
    var navigationBar = Bar()
    var toolBar = Bar()
}

public func ==(lhs: Appearance.Bar, rhs: Appearance.Bar) -> Bool {
    return lhs.style == rhs.style && lhs.backgroundColor == rhs.backgroundColor && lhs.tintColor == rhs.tintColor && lhs.barTintColor == rhs.barTintColor
}

public func ==(lhs: Appearance, rhs: Appearance) -> Bool {
    return lhs.statusBarStyle == rhs.statusBarStyle && lhs.navigationBar == rhs.navigationBar && lhs.toolBar == rhs.toolBar
}
