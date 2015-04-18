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
        println("test")
        
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        let appDelegate = UIApplication.sharedApplication().delegate
        
        center.addObserverForName("MenuButtonPressed", object: appDelegate, queue: queue) {notification in
            if let button = notification?.userInfo?["Button"] as? UIButton {
                println("button is: \(button.titleLabel?.text)")
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                var newVC = mainStoryboard.instantiateViewControllerWithIdentifier("NewViewController") as! UIViewController
                self.viewControllers = [newVC]
                
            } else {
                println("nope")
            }
        }
    }
}