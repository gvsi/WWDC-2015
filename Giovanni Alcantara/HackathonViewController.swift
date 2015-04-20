//
//  HackathonViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 20/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class HackathonViewController : UIViewController, PathMenuDelegate {
    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var hackathonIntroView: UIView!
    
    @IBOutlet weak var hackView: UIView!
    @IBOutlet weak var hackImageView: UIImageView!
    @IBOutlet weak var hackNameLabel: UILabel!
    @IBOutlet weak var hackDetailsLabel: UILabel!
    @IBOutlet weak var hackDescriptionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyMenuItemImage: UIImage = UIImage(named: "bg-menuitem")!
        let storyMenuItemImagePressed: UIImage = UIImage(named: "bg-menuitem-highlighted")!
        
        let starImage: UIImage = UIImage(named: "icon-star")!
        
        let starMenuItem1: PathMenuItem = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        let starMenuItem2: PathMenuItem = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        let starMenuItem3: PathMenuItem = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        let starMenuItem4: PathMenuItem = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        let starMenuItem5: PathMenuItem = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        var menus: [PathMenuItem] = [starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5]
        
        let startItem: PathMenuItem = PathMenuItem(image: UIImage(named: "bg-addbutton"), highlightedImage: UIImage(named: "bg-addbutton-highlighted"), ContentImage: UIImage(named: "icon-plus"), highlightedContentImage: UIImage(named: "icon-plus-highlighted"))
        
        var menu: PathMenu = PathMenu(frame: self.view.bounds, startItem: startItem, optionMenus: menus)
        menu.delegate = self
        menu.startPoint = CGPointMake(UIScreen.mainScreen().bounds.width/2, self.view.frame.size.height - 30.0)
        menu.menuWholeAngle = CGFloat(M_PI) - CGFloat(M_PI/5)
        menu.rotateAngle = -CGFloat(M_PI_2) + CGFloat(M_PI/5) * 1/2
        menu.timeOffset = 0.0
        menu.farRadius = 110.0
        menu.nearRadius = 90.0
        menu.endRadius = 100.0
        menu.animationDuration = 0.5
        
        self.blackView.addSubview(menu)
        //self.blackView.backgroundColor = UIColor(hex: "7f8c8d")
        self.view.addSubview(self.blackView!)
        self.view.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.92, alpha:1)
        
    }
    
    
    // PathMenuDelegate
    
    func pathMenu(menu: PathMenu, didSelectIndex idx: Int) {
        println("Select the index : \(idx)")
        self.blackView?.backgroundColor = UIColor(hex: "#34495e")
        self.hackathonIntroView.removeFromSuperview()
        
        switch idx {
        case 0:
            self.hackNameLabel.text = "MLH Launch Hack - London"
            self.hackImageView.image = UIImage(named: "VerbaCore")
            self.hackDetailsLabel.text = "October 4th - 5th, 2014"
            self.hackDescriptionTextView.text = " VerbaCore is a social network concept focused on minimalist design and features. The team aimed at creating an immediate user experience with features like predictive typing and limited queries for status updates, which were also based on current Google Trends. Our approach to the data structure for the web app was at the base of our project and that allowed us to to create a powerful filtering system, ideal environment for big data.\n I worked on implementing the backend with PHP framework Laravel, and part of the UI and UX."
        case 1:
            self.hackNameLabel.text = "GUTS Hackathon - Glasgow"
            self.hackImageView.image = UIImage(named: "StockRun")
            self.hackDetailsLabel.text = "October 10th - 13th, 2014"
            self.hackDescriptionTextView.text = " StockRun is a 3D game we developed with Unity’s game engine which takes stock market prices using Bloomberg’s APIs and generates an adventure maps to be completed by the user. The game fetches stock market prices of particular indexes and proceeds to generate the map. It uses Java to fetch the data from the Bloomberg Terminal and C# for the game mechanics.\n I worked on fetching the data and on the implementation of the game interface through Unity."
        case 2:
            self.hackNameLabel.text = "3 Day Startup - Edinburgh"
            self.hackImageView.image = UIImage(named: "3DS")
            self.hackDetailsLabel.text = "October 10th - 13th, 2014"
            self.hackDescriptionTextView.text = " 3 Day Startup is an entrepreneurship education program, so my approach to this event was focusing on the entrepreneurial side of developing a product. I worked on Lemma, a centralised discussion and problem-solving platform developed by two software engineers from the University of Edinburgh. Besides working on the technical and coding aspect of it, I focused my attention on the creation of a business model, the development of a user base and techniques to run a modern franchise business. What fascinated me the most was how building a product based on new perspective from people coming from different cultural and social backgrounds turned out to be as important as writing lines of codes efficiently."
        case 3:
            self.hackNameLabel.text = "Student Hack - Manchester"
            self.hackImageView.image = UIImage(named: "Klix")
            self.hackDetailsLabel.text = "October 31st - November 2nd, 2014"
            self.hackDescriptionTextView.text = " Klix is a web application that allows a better and more interactive participation during lectures and classes. Klix is a real-time question and answer web app replicating the use of university clickers, the installation and distribution of which is particularly expensive. I realised how Computer Science can make a difference in many aspects of our daily life.\n I got to work with Node.js with Socket.io framework, Express, AngularJS and MongoDB to store questions and answers."
        case 4:
            self.hackNameLabel.text = "Hack The Burgh - Edinburgh"
            self.hackImageView.image = UIImage(named: "MotionFighter")
            self.hackDetailsLabel.text = "March 14th - March 15th, 2015"
            self.hackDescriptionTextView.text = " MotionFighter is a multiplayer Unity game using Leap Motions for hand detection movements to control a boxer and fight friends on a multiplayer server.\n I worked on implementing the game engine and the networking features."
        default: break
        }
        self.hackView.hidden = false
        
        
    }
    
    func pathMenuWillAnimateOpen(menu: PathMenu) {
        println("Menu will open!")
        self.blackView?.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.7)
    }
    
    func pathMenuWillAnimateClose(menu: PathMenu) {
        println("Menu will close!")
    }
    
    func pathMenuDidFinishAnimationOpen(menu: PathMenu) {
        println("Menu was open!")
    }
    
    func pathMenuDidFinishAnimationClose(menu: PathMenu) {
        println("Menu was closed!")
        self.blackView?.backgroundColor = UIColor(hex: "#34495e")
    }

    
    // segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Your Menu View Controller vew must know the following data for the proper animation
        let destinationVC = segue.destinationViewController as! GuillotineMenuViewController
        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        destinationVC.hostTitleText = self.navigationItem.title
        destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
        destinationVC.setMenuButtonWithImage(barButton.imageView!.image!)
    }
}