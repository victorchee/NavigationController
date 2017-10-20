//
//  Appearance+Extension.swift
//  NavigationAppearance
//
//  Created by qihaijun on 12/2/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

extension Appearance {
    static func random() -> Appearance {
        var value = Appearance()
        
        let navigationBarColor = UIColor.randomColor()
        value.navigationBar.backgroundColor = navigationBarColor
        value.navigationBar.tintColor = navigationBarColor.isBright ? UIColor.black : UIColor.white
        
        let toolbarColor = UIColor.randomColor()
        value.toolBar.backgroundColor = toolbarColor
        value.toolBar.tintColor = toolbarColor.isBright ? UIColor.black : UIColor.white
        
        value.statusBarStyle = navigationBarColor.brightness > 0.5 ? .default : .lightContent
        
        return value
    }
    
    func inverse() -> Appearance {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = navigationBar.backgroundColor.inverse()
        value.navigationBar.tintColor = navigationBar.tintColor.inverse()
        value.toolBar.backgroundColor = toolBar.backgroundColor.inverse()
        value.toolBar.tintColor = toolBar.tintColor.inverse()
        value.statusBarStyle = value.navigationBar.backgroundColor.isBright ? .default : .lightContent
        
        return value
    }
    
    static let lightAppearance: Appearance = {
        var value = Appearance()
        
        value.navigationBar.backgroundColor = UIColor.lightGray
        value.navigationBar.tintColor = UIColor.white
        value.statusBarStyle = .lightContent
        
        return value
    }()
}
