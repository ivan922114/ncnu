//
//  MenuTransitionManager.swift
//  SlideDownMenu
//
//  Created by Simon Ng on 16/11/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 0.5
    var isPresenting = false
    
    var delegate: MenuTransitionManagerDelegate?
    
    var snapshot: UIView? {
        didSet {
            if let delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: delegate, action: #selector(delegate.dismiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // Get reference to our fromView, toView and the container view
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        
        // Set up the transform we'll use in the animation
        let container = transitionContext.containerView
        let moveDown = CGAffineTransform(translationX: container.frame.width - 200, y: 0)
        let moveUp = CGAffineTransform(translationX: -50, y: 0)
        
        // Add both views to the container view
        if isPresenting {
            toView.transform = moveUp
            snapshot = fromView.snapshotView(afterScreenUpdates: true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
        }
        
        // Perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransform.identity
            } else {
                self.snapshot?.transform = CGAffineTransform.identity
                fromView.transform = moveUp
            }
            
        }, completion: { finished in
            
            transitionContext.completeTransition(true)
            
            if !self.isPresenting {
                self.snapshot?.removeFromSuperview()
            }
        })
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
}
