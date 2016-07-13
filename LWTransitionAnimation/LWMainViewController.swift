//
//  ViewController.swift
//  LWTransitionAnimation
//
//  Created by Hoang Dong on 7/12/16.
//  Copyright © 2016 Hoang Dong. All rights reserved.
//

import UIKit

class LWMainViewController: UIViewController, UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // List image names
    let imageNames = ["image01", "image02", "image03", "image04", "image05"]
    
    // Init transition animator
    let transition = LWExpandAnimator()
    
    // Frame to open cell
    var animationFrame: CGRect?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? LWDetailViewController {
            viewController.imageName = sender as? String
            viewController.modalPresentationStyle = .Custom
            viewController.transitioningDelegate = self
        }
    }
    
    // MARK: UITableView's delegate & datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell")

        let imageView:UIImageView? = cell?.viewWithTag(1000) as? UIImageView
        imageView?.image = UIImage(named: imageNames[indexPath.row])
        cell?.selectionStyle = .None
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellRect = tableView.rectForRowAtIndexPath(indexPath)
        animationFrame = tableView.convertRect(cellRect, toView: tableView.superview)
        
        performSegueWithIdentifier("PushDetail", sender: imageNames[indexPath.row])
    }

    
    // MARK: Transition delegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.animationFrame = animationFrame
        
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.animationFrame = animationFrame
        
        return transition
    }
}

