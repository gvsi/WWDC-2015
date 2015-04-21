//
//  ProjectsViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 21/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UINavigationControllerDelegate, JGFlipMenuItemDelegate {

    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var projectScrollView: UIScrollView!
    
    private var menuItems = [JGFlipMenuItem]()
    
    private var currentIndex: Int?
    
    private var transitionAnimation = JGTransitionExpandContract()
    
    private var mainStoryBoard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        assignDelegateAndTagSubviews(view)
        
        navigationController?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        projectScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width * 3)
    }
    
    private func assignDelegateAndTagSubviews(view: UIView) {
        for subview in view.subviews as [AnyObject] {
            if let subSubView = subview as?  UIView {
                assignDelegateAndTagSubviews(subSubView)
            }
            if let menuItem = subview as? JGFlipMenuItem {
                menuItem.delegate = self
                menuItem.tag = menuItems.endIndex // set tag to its array index
                menuItems.append(menuItem)
            }
        }
    }
    
    // JGFlipMenuItemDelegate method called when frontside of menu is selected
    internal func frontSideSelected(indexTag: Int) {
        // println("front side delegate tag: \(indexTag) title: \(menuItems[indexTag].frontSideTitle.text)")
        
        // get instance using the frontSideTitle.text which MUST be the same a view controller's Storyboard ID
        if let vc = mainStoryBoard.instantiateViewControllerWithIdentifier(menuItems[indexTag].frontSideTitle.text) as? UIViewController {
            
            // convert the menu item center point that's in the  menu items container to the full view container point
            transitionAnimation.focalPoint = menuItems[indexTag].superview?.convertPoint(menuItems[indexTag].center, toView: self.view)
            
            // keep the current index for fliping the menu back when popped back
            currentIndex = indexTag
            
            // push the view controller onto the navigationController's stack
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // JGFlipMenuItemDelegate method called when backside of menu is selected
    internal func backSideSelected(indexTag: Int) {
        // println("back side delegate tag: \(indexTag) title: \(menuItems[indexTag].frontSideTitle.text)")
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
        if let index = currentIndex {
            // menu item is done with display so flip to the front side
            self.menuItems[index].flipToFrontSide()
        }
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
