//
//  LWExpandAnimator.swift
//  LWTransitionAnimation
//
//  Created by Hoang Dong on 7/13/16.
//  Copyright © 2016 Hoang Dong. All rights reserved.
//

import UIKit

class LWExpandAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum PopTransitionMode: Int {
        case Present, Dismiss
    }
    
    // Capture view
    var topView:UIView?
    var bottomView:UIView?
    
    var transitionMode:PopTransitionMode = .Present
    var animationFrame: CGRect?
    
    // Animation duration
    var presentDuration = 0.5
    var dismissDuration = 0.45
    
    var imageName:String?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        if transitionMode == .Present {
            return presentDuration
        } else {
            return dismissDuration
        }
    }
 
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromViewFrame = fromVC!.view.frame
        
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let containerView = transitionContext.containerView()
        
        if transitionMode == .Present {
            
            toVC?.view.center = CGPointMake(CGRectGetMidX(self.animationFrame!), CGRectGetMidY(self.animationFrame!))
            containerView?.addSubview((toVC?.view)!)


            // Snapshot of top view
            topView = fromVC!.view.resizableSnapshotViewFromRect(fromViewFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsMake(animationFrame!.origin.y, 0, 0, 0))
            topView?.frame = CGRectMake(0, 0, fromViewFrame.width, animationFrame!.origin.y)
            
            containerView?.addSubview(topView!)
            
            // Snapshot of bottom view
            bottomView = fromVC!.view.resizableSnapshotViewFromRect(fromViewFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsMake(0, 0, fromViewFrame.height - (animationFrame?.origin.y)! - (animationFrame?.height)!, 0))
            bottomView?.frame = CGRectMake(0, animationFrame!.origin.y + animationFrame!.height, fromViewFrame.width, fromViewFrame.height - animationFrame!.origin.y - (animationFrame?.height)!)
            
            containerView?.addSubview(bottomView!)
            
            UIView.animateWithDuration(presentDuration, animations: {
                // Move top view out of screen
                self.topView?.frame = CGRectMake(0, -(self.topView?.frame.height)!, (self.topView?.frame.width)!, (self.topView?.frame.height)!)
                
                // Move bottom view out of screen
                self.bottomView?.frame = CGRectMake(0, fromViewFrame.height, (self.bottomView?.frame.width)!, (self.bottomView?.frame.height)!)
                
                // Expand animationView to fill entire frame
                toVC?.view.center = fromVC!.view.center
                toVC?.view.backgroundColor = UIColor.blackColor()
                
                }, completion: { (finished) in
                    transitionContext.completeTransition(true)
            })
        } else {
            UIView.animateWithDuration(dismissDuration, animations: {
                // Move top view to old position
                self.topView?.frame = CGRectMake(0, 0, (self.topView?.frame.width)!, (self.topView?.frame.height)!)
                
                // Move bottom view to old position
                self.bottomView?.frame = CGRectMake(0, fromViewFrame.height - (self.bottomView?.frame.height)!, (self.bottomView?.frame.width)!, (self.bottomView?.frame.height)!)
                
                fromVC!.view.center = CGPointMake(CGRectGetMidX(self.animationFrame!), CGRectGetMidY(self.animationFrame!))
                
                }, completion: { (finished) in
                    toVC!.view.alpha = 1.0
                    transitionContext.completeTransition(true)
            })
        }
    }
    
}
