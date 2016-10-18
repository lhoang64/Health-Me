//
//  CloseMenuAnimation.swift
//  Health Me
//
//  Created by Linh Hoang on 5/4/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit

class CloseMenuAnimation: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let containerView = transitionContext.containerView()
            else{
                return
        }
        
        let snapShot = containerView.viewWithTag(1234)
        
        UIView.animateWithDuration(transitionDuration(transitionContext),
            animations: {
                snapShot?.frame = CGRect(origin: CGPoint.zero, size: UIScreen.mainScreen().bounds.size)
            },
            completion: { _ in
                let didTransitioned = !transitionContext.transitionWasCancelled()
                if didTransitioned{
                    containerView.insertSubview(toView.view, aboveSubview: fromView.view)
                    snapShot?.removeFromSuperview()
                }
                transitionContext.completeTransition(didTransitioned)
        })
    }
}