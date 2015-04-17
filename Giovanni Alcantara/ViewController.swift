//
//  ViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 15/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoButton: LogoButton!
    
    func colorsWithHalfOpacity(colors: [CGColor]) -> [CGColor] {
        return colors.map({ CGColorCreateCopyWithAlpha($0, CGColorGetAlpha($0) * 0.5) })
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        println(self.view.frame)
        
        logoButton.layer.addPulse { builder in
            //builder.borderColors = [UIColor(hex: "34495e").CGColor]
            builder.borderColors = [UIColor.blackColor().CGColor]
            builder.backgroundColors = self.colorsWithHalfOpacity(builder.borderColors)
            builder.path = UIBezierPath(ovalInRect: self.logoButton.bounds).CGPath
            builder.duration *= 0.85
            builder.repeatCount = Int.max
            builder.lineWidth = 2.0;
            builder.backgroundColors = []
        }
        
        var size = max(self.view.frame.size.width, self.view.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func activate(sender: LogoButton!) {
        
        self.logoButton.isActive = !self.logoButton.isActive
        
        //self.logoButton.isActive = !self.logoButton.isActive
        let transitionOptions = UIViewAnimationOptions.TransitionCrossDissolve
    
        
        UIView.animateWithDuration(2.0, delay: 0.2, options: transitionOptions, animations: {
            self.backgroundImageView.alpha = 0.0
            }, completion: { finished in
        })
        
        UIView.animateWithDuration(2.0, delay: 0.0, options: transitionOptions, animations: {
            self.logoButton.alpha = 0.0
            }, completion: { finished in
        })

    }
    
}

