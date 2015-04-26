//
//  HackathonViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 20/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class HackathonViewController : UIViewController, HackathonPickerDelegate {
    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var hackathonIntroView: UIView!
    
    @IBOutlet weak var hackView: UIView!
    @IBOutlet weak var hackImageView: UIImageView!
    @IBOutlet weak var hackNameLabel: UILabel!
    @IBOutlet weak var hackDetailsLabel: UILabel!
    @IBOutlet weak var hackDescriptionTextView: UITextView!
    
    var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyMenuItemImage: UIImage = UIImage(named: "bg-menuitem")!
        let storyMenuItemImagePressed: UIImage = UIImage(named: "bg-menuitem-highlighted")!
        
        let starImage: UIImage = UIImage(named: "icon-code")!
        
        let hackItem1: HackathonPickerItem = HackathonPickerItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        let hackItem2: HackathonPickerItem = HackathonPickerItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        let hackItem3: HackathonPickerItem = HackathonPickerItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        let hackItem4: HackathonPickerItem = HackathonPickerItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        let hackItem5: HackathonPickerItem = HackathonPickerItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        let hackItem6: HackathonPickerItem = HackathonPickerItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
        
        var menus: [HackathonPickerItem] = [hackItem1, hackItem2, hackItem3, hackItem4, hackItem5, hackItem6]
        
        let startItem: HackathonPickerItem = HackathonPickerItem(image: UIImage(named: "bg-addbutton_x"), highlightedImage: UIImage(named: "bg-addbutton-highlighted"), ContentImage: UIImage(named: "icon-navigate"), highlightedContentImage: UIImage(named: "icon-navigate-highlighted"))
        
        var menu: HackathonPicker = HackathonPicker(frame: self.view.bounds, startItem: startItem, optionMenus: menus)
        menu.delegate = self
        menu.startPoint = CGPointMake(UIScreen.mainScreen().bounds.width/2, self.view.frame.size.height - 30.0)
        menu.menuWholeAngle = CGFloat(M_PI) - CGFloat(M_PI/5)
        menu.rotateAngle = -CGFloat(M_PI_2) + CGFloat(M_PI/5) * 1/2
        menu.timeOffset = 0.0
        menu.farRadius = 110.0
        menu.nearRadius = 90.0
        menu.endRadius = 100.0
        menu.animationDuration = 0.5
        
        self.backgroundView.addSubview(menu)
        //self.backgroundView.backgroundColor = UIColor(hex: "7f8c8d")
        self.view.addSubview(self.backgroundView!)
        self.view.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.92, alpha:1)
        
    }
    
    
    // HackathonPickerDelegate
    
    func hackathonPicker(menu: HackathonPicker, didSelectIndex idx: Int) {
        //println("Selected index: \(idx)")
        self.backgroundView?.backgroundColor = UIColor(hex: "#34495e")
        self.hackathonIntroView.removeFromSuperview()
        
        switch idx {
        case 0:
            self.hackNameLabel.text = "MLH Launch Hack - London"
            self.hackImageView.image = UIImage(named: "VerbaCore")
            self.originalImage = UIImage(named: "VerbaCore")
            self.hackDetailsLabel.text = "October 4th - 5th, 2014"
            self.hackDescriptionTextView.text = " VerbaCore is a social network concept focused on minimalist design and features. The team aimed at creating an immediate user experience with features like predictive typing and limited queries for status updates, which were also based on current Google Trends. Our approach to the data structure for the web app was at the base of our project and that allowed us to to create a powerful filtering system, ideal environment for big data.\n I worked on implementing the backend with PHP framework Laravel, and part of the UI and UX."
        case 1:
            self.hackNameLabel.text = "GUTS Hackathon - Glasgow"
            self.hackImageView.image = UIImage(named: "StockRun")
            self.originalImage = UIImage(named: "StockRun")
            self.hackDetailsLabel.text = "October 10th - 13th, 2014"
            self.hackDescriptionTextView.text = " StockRun is a 3D game we developed with Unity’s game engine which takes stock market prices using Bloomberg’s APIs and generates an adventure maps to be completed by the user. The game fetches stock market prices of particular indexes and proceeds to generate the map. It uses Java to fetch the data from the Bloomberg Terminal and C# for the game mechanics.\n I worked on fetching the data and on the implementation of the game interface through Unity."
        case 2:
            self.hackNameLabel.text = "3 Day Startup - Edinburgh"
            self.hackImageView.image = UIImage(named: "3DS")
            self.originalImage = UIImage(named: "3DS")
            self.hackDetailsLabel.text = "October 10th - 13th, 2014"
            self.hackDescriptionTextView.text = " 3 Day Startup is an entrepreneurship education program, so my approach to this event was focusing on the entrepreneurial side of developing a product. I worked on Lemma, a centralised discussion and problem-solving platform developed by two software engineers from the University of Edinburgh. Besides working on the technical and coding aspect of it, I focused my attention on the creation of a business model, the development of a user base and techniques to run a modern franchise business. What fascinated me the most was how building a product based on new perspective from people coming from different cultural and social backgrounds turned out to be as important as writing lines of codes efficiently."
        case 3:
            self.hackNameLabel.text = "Student Hack - Manchester"
            self.hackImageView.image = UIImage(named: "Klix")
            self.originalImage = UIImage(named: "Klix")
            self.hackDetailsLabel.text = "October 31st - November 2nd, 2014"
            self.hackDescriptionTextView.text = " Klix is a web application that allows a better and more interactive participation during lectures and classes. Klix is a real-time question and answer web app replicating the use of university clickers, the installation and distribution of which is particularly expensive. I realised how Computer Science can make a difference in many aspects of our daily life.\n I got to work with Node.js with Socket.io framework, Express, AngularJS and MongoDB to store questions and answers."
        case 4:
            self.hackNameLabel.text = "Hack The Burgh - Edinburgh"
            self.hackImageView.image = UIImage(named: "MotionFighter")
            self.originalImage = UIImage(named: "MotionFighter")
            self.hackDetailsLabel.text = "March 14th - March 15th, 2015"
            self.hackDescriptionTextView.text = " MotionFighter is a multiplayer Unity game using Leap Motions for hand detection movements to control a boxer and fight friends on a multiplayer server.\n I worked on implementing the game engine and the networking features."
        case 5:
            self.hackNameLabel.text = "MLH Landing - London"
            self.hackImageView.image = UIImage(named: "BC")
            self.originalImage = UIImage(named: "BC")
            self.hackDetailsLabel.text = "April 11th - April 12th, 2015"
            self.hackDescriptionTextView.text = " BeaconCart is an iOS app I developed as an entry for the finale of Major League Hacking in London. The app, winner of the MLH Braintree challenge, uses the Estimote Bluetooth Beacons APIs with the CoreLocation framework to identify any surrounding shops, restaurants or business to enhance the shopping experience. It fetches data (e.g. a menu, a list of items in sale or tickets) from the server. The user then checks out (through in-app purchases or Paypal mobile) and a receipt is generated. I have talked to businesses in Edinburgh and several have expressed interest. I am planning to launch the app and service later this year."
        default: break
        }
        self.hackView.hidden = false
        
        
    }
    
    func hackathonPickerWillAnimateOpen(menu: HackathonPicker) {
        self.backgroundView?.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.7)
        if let orIm = self.originalImage {
            self.hackImageView.image = imageBlackAndWhite(orIm)
        }
    }
    
    func hackathonPickerWillAnimateClose(menu: HackathonPicker) {
        if let orIm = self.originalImage {
            self.hackImageView.image = orIm
        }
    }
    
    func hackathonPickerDidFinishAnimationOpen(menu: HackathonPicker) {
        //println("Menu opened!")
    }
    
    func hackathonPickerDidFinishAnimationClose(menu: HackathonPicker) {
        self.backgroundView?.backgroundColor = UIColor(hex: "#34495e")
    }

    
    func imageBlackAndWhite(image: UIImage) -> UIImage {
        var imageRect = CGRectMake(0, 0, image.size.width, image.size.height)
        var colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(CGImageAlphaInfo.None.rawValue)
        var context = CGBitmapContextCreate(nil, Int(image.size.width), Int(image.size.height), 8, 0, colorSpace, bitmapInfo)
        CGContextDrawImage(context, imageRect, image.CGImage)
        var imageRef = CGBitmapContextCreateImage(context)
        var newImage = UIImage(CGImage: imageRef)
        return newImage!
    }
    
    // Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! MainMenuViewController
        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        destinationVC.hostTitleText = self.navigationItem.title
        destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
        destinationVC.setMenuButtonWithImage(barButton.imageView!.image!)
    }
    
    
}