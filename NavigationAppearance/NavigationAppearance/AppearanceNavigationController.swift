//
//  AppearanceNavigationController.swift
//  NavigationAppearance
//
//  Created by qihaijun on 12/2/15.
//  Copyright © 2015 VictorChee. All rights reserved.
//

import UIKit

public class AppearanceNavigationController: UINavigationController, UINavigationControllerDelegate {
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
    }
    
    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        delegate = self
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - UINavigationControllerDelegate
    public func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        guard let appearanceContext = viewController as? NavigationControllerAppearanceContext else {
            return
        }
        setNavigationBarHidden(appearanceContext.prefersNavigationControllerBarHidden(self), animated: animated)
        setToolbarHidden(appearanceContext.prefersNavigationControllerToolbarHidden(self), animated: animated)
        applyAppearance(appearanceContext.preferredNavigationControllerAppearance(self), animated: animated)
        
        // interactive gesture requires more complex login.
        guard let coordinator = viewController.transitionCoordinator() where coordinator.isInteractive() else {
            return
        }
        coordinator.animateAlongsideTransition({ (_) -> Void in
            
            }) { (context) -> Void in
                if context.isCancelled(), let appearanceContext = self.topViewController as? NavigationControllerAppearanceContext {
                    // hiding navigation bar & toolbar within interaction completion will result into inconsistent UI state
                    self.setNavigationBarHidden(appearanceContext.prefersNavigationControllerBarHidden(self), animated: animated)
                    self.setToolbarHidden(appearanceContext.prefersNavigationControllerToolbarHidden(self), animated: animated)
                }
        }
        coordinator.notifyWhenInteractionEndsUsingBlock { (context) -> Void in
            if context.isCancelled(), let from = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as? NavigationControllerAppearanceContext {
                // changing navigation bar & toolbar appearance within animate completion will result into UI glitch
                self.applyAppearance(from.preferredNavigationControllerAppearance(self), animated: true)
            }
        }
    }
    
    // MARK: - Appearance Applying
    private var appliedAppearance: Appearance?
    public var appearanceApplyingStrategy = AppearanceApplyingStrategy() {
        didSet {
            applyAppearance(appliedAppearance, animated: false)
        }
    }
    
    private func applyAppearance(appearance: Appearance?, animated: Bool) {
        if appearance != nil && appliedAppearance != appearance {
            appliedAppearance = appearance
            appearanceApplyingStrategy.apply(appearance, toNavigationController: self, animated: animated)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - Appearance Update
    func updateAppearanceForViewController(viewController: UIViewController) {
        guard let context = viewController as? NavigationControllerAppearanceContext where viewController == topViewController && transitionCoordinator() == nil else {
            return
        }
        setNavigationBarHidden(context.prefersNavigationControllerBarHidden(self), animated: true)
        setToolbarHidden(context.prefersNavigationControllerToolbarHidden(self), animated: true)
        applyAppearance(context.preferredNavigationControllerAppearance(self), animated: true)
    }
    
    public func updateAppearance() {
        guard let top = topViewController else {
            return
        }
        updateAppearanceForViewController(top)
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return appliedAppearance?.statusBarStyle ?? super.preferredStatusBarStyle()
    }
    
    public override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return appliedAppearance != nil ? .Fade : super.preferredStatusBarUpdateAnimation()
    }
}
