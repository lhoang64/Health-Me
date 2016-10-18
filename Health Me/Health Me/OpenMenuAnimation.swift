//
//  OpenMenuAnimation.swift
//  Health Me
//
//  Created by Linh Hoang on 5/4/16.
//  Copyright © 2016 Linh Hoang. All rights reserved.
//

import Foundation
import UIKit

class OpenMenuAnimation: NSObject, UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //could also be written as if let statement, but this is more readable
        guard let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let containerView = transitionContext.containerView()
            else{
                return
        }
        
        containerView.insertSubview(toView.view, belowSubview: fromView.view)
        
        let snapShot = fromView.view.snapshotViewAfterScreenUpdates(false)
        snapShot.tag = 1234
        snapShot.userInteractionEnabled = false
        snapShot.layer.shadowOpacity = 0.7
        containerView.insertSubview(snapShot, aboveSubview: toView.view)
        fromView.view.hidden = true
        
        UIView.animateWithDuration(transitionDuration(transitionContext),
            animations: {
                snapShot.center.x += UIScreen.mainScreen().bounds.width * 0.5
            },
            completion:{ _ in
                fromView.view.hidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}