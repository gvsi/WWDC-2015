//
//  ViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 15/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit
import NotificationCenter

class HelloViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoButton: LogoButton!
    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var arrowMenu: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        func colorsWithHalfOpacity(colors: [CGColor]) -> [CGColor] {
            return colors.map({ CGColorCreateCopyWithAlpha($0, CGColorGetAlpha($0) * 0.5) })
        }
                
        logoButton.layer.addPulse { builder in
            builder.borderColors = [UIColor.whiteColor().CGColor]
            builder.backgroundColors = colorsWithHalfOpacity(builder.borderColors)
            builder.path = UIBezierPath(ovalInRect: self.logoButton.bounds).CGPath
            builder.duration *= 0.85
            builder.repeatCount = Int.max
            builder.lineWidth = 2.0;
            builder.backgroundColors = []
        }
        
    }
    
    @IBAction func activate(sender: LogoButton!) {
        
        self.logoButton.isActive = !self.logoButton.isActive
        
        let transitionOptions = UIViewAnimationOptions.TransitionCrossDissolve
        
        
        UIView.animateWithDuration(2.0, delay: 0.2, options: transitionOptions, animations: {
            self.backgroundImageView.alpha = 0.0
            self.infoLabel.hidden = true
            }, completion: nil)
        
        UIView.animateWithDuration(2.0, delay: 0.0, options: transitionOptions, animations: {
            self.logoButton.alpha = 0.0
            }, completion: { [unowned self] finished in
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.arrowMenu.hidden = false
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Your Menu View Controller vew must know the following data for the proper animation
        let destinationVC = segue.destinationViewController as! MainMenuViewController
        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        destinationVC.hostTitleText = self.navigationItem.title
        destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
        destinationVC.setMenuButtonWithImage(barButton.imageView!.image!)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false;
    }
    
}

