//
//  ProjectsViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 21/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var projectScrollView: UIScrollView!
    @IBOutlet weak var beaconCartView: UIView!
    @IBOutlet weak var goWalkersView: UIView!
    
    private var transitionAnimation = JGTransitionExpandContract()
    
    private var mainStoryBoard: UIStoryboard!
    
    @IBAction func buttonClicked(sender: UIButton) {
        if let vc = mainStoryBoard.instantiateViewControllerWithIdentifier("Test") as? UIViewController {
            
            // convert the menu item center point that's in the  menu items container to the full view container point
            transitionAnimation.focalPoint = beaconCartView.superview?.convertPoint(beaconCartView.center, toView: self.view)
            
            
            // push the view controller onto the navigationController's stack
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        //assignDelegateAndTagSubviews(view)
        
        self.navigationController?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        projectScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width * 3)
    }
    

        
    internal func navigationController(navigationController: UINavigationController,
        animationControllerForOperation operation: UINavigationControllerOperation,
        fromViewController fromVC: UIViewController,
        toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            
            // set the transtion to isPresenting (i.e. expand) for the push
            if (operation == .Push) {
                transitionAnimation.isPresenting = true
            } else {
                // set the transtion to contract for the pop back
                transitionAnimation.isPresenting = false
            }
            
            return transitionAnimation
    }
    
    override func viewDidAppear(animated: Bool) {
        // ignore if currentIndex is nil, as when view first appears
//        if let index = currentIndex {
//            // menu item is done with display so flip to the front side
//            self.menuItems[index].flipToFrontSide()
//        }
    }

    /*
    // MARK: - Navigation
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Your Menu View Controller vew must know the following data for the proper animation
        let destinationVC = segue.destinationViewController as! GuillotineMenuViewController
        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        destinationVC.hostTitleText = self.navigationItem.title
        destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
        destinationVC.setMenuButtonWithImage(barButton.imageView!.image!)
    }

}
