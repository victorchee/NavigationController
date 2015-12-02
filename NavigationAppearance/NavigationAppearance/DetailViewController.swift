//
//  DetailViewController.swift
//  NavigationAppearance
//
//  Created by qihaijun on 12/2/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, NavigationControllerAppearanceContext {
    var appearance: Appearance? {
        didSet {
            setNeedsUpdateNavigationControllerAppearance()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.rightBarButtonItem = editButtonItem()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        setNeedsUpdateNavigationControllerAppearance()
    }
    
    // MARK: - AppearanceNavigationControllerContent
    func prefersNavigationControllerToolbarHidden(navigationController: UINavigationController) -> Bool {
        return editing // hide toolbar during editing
    }
    
    func preferredNavigationControllerAppearance(navigationController: UINavigationController) -> Appearance? {
        return editing ? appearance?.inverse() : appearance // inverse navigation bar color and status bar during editing
    }
}
