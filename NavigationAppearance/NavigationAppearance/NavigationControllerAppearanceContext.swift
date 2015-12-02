//
//  NavigationControllerAppearanceContext.swift
//  NavigationAppearance
//
//  Created by qihaijun on 12/2/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

public protocol NavigationControllerAppearanceContext: class {
    func prefersNavigationControllerBarHidden(navigationController: UINavigationController) -> Bool
    func prefersNavigationControllerToolbarHidden(navigationController: UINavigationController) -> Bool
    
    func preferredNavigationControllerAppearance(navigationController: UINavigationController) -> Appearance?
    
    func setNeedsUpdateNavigationControllerAppearance()
}

extension NavigationControllerAppearanceContext {
    func prefersNavigationControllerBarHidden(navigationController: UINavigationController) -> Bool {
        return false
    }
    func prefersNavigationControllerToolbarHidden(navigationController: UINavigationController) -> Bool {
        return true
    }
    
    func preferredNavigationControllerAppearance(navigationController: UINavigationController) -> Appearance? {
        return nil
    }
    
    func setNeedsUpdateNavigationControllerAppearance() {
        guard let viewcontroller = self as? UIViewController, navigationController = viewcontroller.navigationController as? AppearanceNavigationController else {
            return
        }
        navigationController.updateAppearanceForViewController(viewcontroller)
    }
}
