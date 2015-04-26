//
//  PagesNavigationController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 18/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

public class PagesNavigationController : UINavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationBar.barTintColor = UIColor(hex: "2c3e50")
        
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        let appDelegate = UIApplication.sharedApplication().delegate
        
        center.addObserverForName("MenuButtonPressed", object: appDelegate, queue: queue) {notification in
            if let button = notification?.userInfo?["Button"] as? UIButton {
                //println("button is: \(button.titleLabel?.text)")
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                
                if button.tag == 3 {
                    var newVC = mainStoryboard.instantiateViewControllerWithIdentifier("HelloPage") as! UIViewController
                    self.viewControllers = [newVC]
                } else {
                    switch button.titleLabel!.text! {
                    case " About Me":
                        var newVC = mainStoryboard.instantiateViewControllerWithIdentifier("AboutPage") as! UIViewController
                        self.viewControllers = [newVC]
                    case "Hackathons":
                        var newVC = mainStoryboard.instantiateViewControllerWithIdentifier("HackathonPage") as! UIViewController
                        self.viewControllers = [newVC]
                    case "Projects":
                        var newVC = mainStoryboard.instantiateViewControllerWithIdentifier("ProjectsPage") as! UIViewController
                        self.viewControllers = [newVC]
                    default:
                        break;
                    }
                }
                
            }
        }
    }
}