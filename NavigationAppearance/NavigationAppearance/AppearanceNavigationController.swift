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
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let appearanceContext = viewController as? NavigationControllerAppearanceContext else {
            return
        }
        setNavigationBarHidden(appearanceContext.prefersNavigationControllerBarHidden(navigationController: self), animated: animated)
        setToolbarHidden(appearanceContext.prefersNavigationControllerToolbarHidden(navigationController: self), animated: animated)
        applyAppearance(appearance: appearanceContext.preferredNavigationControllerAppearance(navigationController: self), animated: animated)
        
        // interactive gesture requires more complex login.
        guard let coordinator = viewController.transitionCoordinator, coordinator.isInteractive else {
            return
        }
        coordinator.animate(alongsideTransition: { (_) -> Void in
            
            }) { (context) -> Void in
                if context.isCancelled, let appearanceContext = self.topViewController as? NavigationControllerAppearanceContext {
                    // hiding navigation bar & toolbar within interaction completion will result into inconsistent UI state
                    self.setNavigationBarHidden(appearanceContext.prefersNavigationControllerBarHidden(navigationController: self), animated: animated)
                    self.setToolbarHidden(appearanceContext.prefersNavigationControllerToolbarHidden(navigationController: self), animated: animated)
                }
        }
        coordinator.notifyWhenInteractionEnds { (context) -> Void in
            if context.isCancelled, let from = context.viewController(forKey: UITransitionContextViewControllerKey.from) as? NavigationControllerAppearanceContext {
                // changing navigation bar & toolbar appearance within animate completion will result into UI glitch
                self.applyAppearance(appearance: from.preferredNavigationControllerAppearance(navigationController: self), animated: true)
            }
        }
    }
    
    // MARK: - Appearance Applying
    private var appliedAppearance: Appearance?
    public var appearanceApplyingStrategy = AppearanceApplyingStrategy() {
        didSet {
            applyAppearance(appearance: appliedAppearance, animated: false)
        }
    }
    
    private func applyAppearance(appearance: Appearance?, animated: Bool) {
        if appearance != nil && appliedAppearance != appearance {
            appliedAppearance = appearance
            appearanceApplyingStrategy.apply(appearance: appearance, toNavigationController: self, animated: animated)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - Appearance Update
    func updateAppearanceForViewController(viewController: UIViewController) {
        guard let context = viewController as? NavigationControllerAppearanceContext, viewController == topViewController && transitionCoordinator == nil else {
            return
        }
        setNavigationBarHidden(context.prefersNavigationControllerBarHidden(navigationController: self), animated: true)
        setToolbarHidden(context.prefersNavigationControllerToolbarHidden(navigationController: self), animated: true)
        applyAppearance(appearance: context.preferredNavigationControllerAppearance(navigationController: self), animated: true)
    }
    
    public func updateAppearance() {
        guard let top = topViewController else {
            return
        }
        updateAppearanceForViewController(viewController: top)
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return appliedAppearance?.statusBarStyle ?? super.preferredStatusBarStyle
    }
    
    override public var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return appliedAppearance != nil ? .fade : super.preferredStatusBarUpdateAnimation
    }
}
