//
//  TestViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 21/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
