//
//  ViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 15/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoButton: LogoButton!
    @IBOutlet weak var pagedScrollView: UIScrollView!
    
    var pageView1 = UIScrollView()
    var pageView2 = UIScrollView()
    var pageView3 = UIScrollView()
    
    var backgroundImageView1 = UIImageView()
    var backgroundImageView2 = UIImageView()
    var backgroundImageView3 = UIImageView()

    
    
    func colorsWithHalfOpacity(colors: [CGColor]) -> [CGColor] {
        return colors.map({ CGColorCreateCopyWithAlpha($0, CGColorGetAlpha($0) * 0.5) })
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        
        var numberOfPages: CGFloat = 3
        var i: CGFloat = 0
        
        self.pagedScrollView.frame = CGRectMake(0, 0, self.view.frame.width + 2*SIDE_BAR_WIDTH, self.view.frame.height)
        self.pagedScrollView.contentSize = CGSize(width: self.pagedScrollView.frame.width * numberOfPages, height: self.pagedScrollView.frame.height)
        self.pagedScrollView.pagingEnabled = true
        self.pagedScrollView.delegate = self
        self.setPageView()
        //print("contentSize: \(self.scrollView.contentSize.width)\n")
        print("scrollView: \(self.pagedScrollView.frame.width)\n")
        //print("pageView: \(self.pageView2.frame.width)\n")
        //print("pageViewContent: \(self.pageView3.frame.origin.x)\n")
        
        
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
    
    
    let MAX_BACKGROUND_SCROLL_DISTANCE: CGFloat = 150
    let SIDE_BAR_WIDTH: CGFloat = 2

    
    func setPageView() {
        
        pageView1.contentSize = CGSize(width: self.view.frame.width + 2*MAX_BACKGROUND_SCROLL_DISTANCE, height: pagedScrollView.frame.height)
        pageView1.frame = CGRectMake(0, 0, self.view.frame.width, self.pagedScrollView.frame.height)
        pageView1.setContentOffset(CGPointMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0), animated: false)
        self.pageView1.userInteractionEnabled = false
        self.pagedScrollView.addSubview(pageView1)
        
        
        pageView2.contentSize = CGSize(width: self.view.frame.width + 2*MAX_BACKGROUND_SCROLL_DISTANCE, height: pagedScrollView.frame.height)
        pageView2.frame = CGRectMake(self.pagedScrollView.frame.width, 0, self.view.frame.width, self.pagedScrollView.frame.height)
        pageView2.setContentOffset(CGPointMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0), animated: false)
        self.pageView2.userInteractionEnabled = false
        self.pagedScrollView.addSubview(pageView2)
        
        pageView3.contentSize = CGSize(width: self.view.frame.width + 2*MAX_BACKGROUND_SCROLL_DISTANCE, height: pagedScrollView.frame.height)
        pageView3.frame = CGRectMake(self.pagedScrollView.frame.width*2, 0, self.view.frame.width, self.pagedScrollView.frame.height)
        pageView3.setContentOffset(CGPointMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0), animated: false)
        self.pageView3.userInteractionEnabled = false
        self.pagedScrollView.addSubview(pageView3)
        
        self.setBackgroundImageView()
    }
    
    func setBackgroundImageView() {
        
        backgroundImageView1.image = UIImage(named: "page1")
        backgroundImageView1.frame = CGRectMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0, self.pagedScrollView.frame.width, self.pagedScrollView.frame.height)
        self.pageView1.addSubview(backgroundImageView1)
        
        
        backgroundImageView2.image = UIImage(named: "page2")
        backgroundImageView2.frame = CGRectMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0, self.pagedScrollView.frame.width, self.pagedScrollView.frame.height)
        self.pageView2.addSubview(backgroundImageView2)
        
        
        backgroundImageView3.image = UIImage(named: "page3")
        backgroundImageView3.frame = CGRectMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0, self.pagedScrollView.frame.width, self.pagedScrollView.frame.height)
        self.pageView3.addSubview(backgroundImageView3)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var ratio = self.pagedScrollView.contentOffset.x / self.pagedScrollView.frame.width
        
        if ratio > -1 && ratio < 1 {
            self.pageView1.setContentOffset(CGPointMake(MAX_BACKGROUND_SCROLL_DISTANCE - ratio*MAX_BACKGROUND_SCROLL_DISTANCE, 0), animated: false)
        }
        if ratio > 0 && ratio < 2 {
            self.pageView2.setContentOffset(CGPointMake(MAX_BACKGROUND_SCROLL_DISTANCE - (ratio-1)*MAX_BACKGROUND_SCROLL_DISTANCE, 0), animated: false)
        }
        if ratio > 1 && ratio < 3 {
            self.pageView3.setContentOffset(CGPointMake(MAX_BACKGROUND_SCROLL_DISTANCE - (ratio-2)*MAX_BACKGROUND_SCROLL_DISTANCE, 0), animated: false)
        }
        print("\(self.pagedScrollView.contentOffset.x)\n")
        //print("\(ratio)\n")
    }
    
}

