//
//  LWDetailViewController.swift
//  LWTransitionAnimation
//
//  Created by Hoang Dong on 7/13/16.
//  Copyright © 2016 Hoang Dong. All rights reserved.
//

import UIKit

class LWDetailViewController: UIViewController {
    
    @IBOutlet var imageView:UIImageView?
    
    var imageName:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView?.image = UIImage(named: imageName!)
    }

    @IBAction func handleCloseButton() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
