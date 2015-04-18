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

    var contentScrollView: UIScrollView?
    var bgNoBlurView: UIImageView?
    var bgBlurView: UIImageView?

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        func colorsWithHalfOpacity(colors: [CGColor]) -> [CGColor] {
            return colors.map({ CGColorCreateCopyWithAlpha($0, CGColorGetAlpha($0) * 0.5) })
        }
        
        logoButton.layer.addPulse { builder in
            //builder.borderColors = [UIColor(hex: "34495e").CGColor]
            builder.borderColors = [UIColor.blackColor().CGColor]
            builder.backgroundColors = colorsWithHalfOpacity(builder.borderColors)
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
        self.pagedScrollView.directionalLockEnabled = true
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
    
    
    let MAX_BACKGROUND_SCROLL_DISTANCE: CGFloat = 50
    let SIDE_BAR_WIDTH: CGFloat = 2

    
    func setPageView() {
        
        pageView1 = UIScrollView(frame: CGRectMake(0,0, view.bounds.width, view.bounds.height))
        pageView1.alwaysBounceVertical   = false
        pageView1.userInteractionEnabled = false
        pageView1.contentSize = CGSize(width: self.view.frame.width + 2*MAX_BACKGROUND_SCROLL_DISTANCE, height: pagedScrollView.frame.height)
        pageView1.frame = CGRectMake(0, 0, self.view.frame.width, self.pagedScrollView.frame.height)
        pageView1.setContentOffset(CGPointMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0), animated: false)
        let square   = UIView(frame: CGRectMake (25,600, 325, 200))
        square.alpha = 0.6
        square.backgroundColor = UIColor.blackColor()
        
        
        let text             = UITextView(frame: CGRectMake(50,625, 275, 175))
        text.font            = UIFont(name: "Helvetica Neue", size: CGFloat(15))
        text.textColor       = UIColor.whiteColor()
        text.backgroundColor = nil
        text.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent commodo et justo vel porta. In fermentum tortor neque, sed sodales sapien pretium id. Donec suscipit eros nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent commodo et justo vel porta."
        
        let bgNoBlur = UIImage(named: "page1")
        let bgBlur   = UIImage(named: "profile_blurred")
        
        bgNoBlurView        = UIImageView(image: bgNoBlur)
        bgNoBlurView?.frame = CGRectMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0, self.pagedScrollView.frame.width, 867)
        bgBlurView          = UIImageView(image: bgBlur)
        bgBlurView?.frame   = CGRectMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0, self.pagedScrollView.frame.width, 867)
        bgBlurView?.alpha   = 0
        
        contentScrollView = UIScrollView(frame: CGRectMake(0,0, view.bounds.width, view.bounds.height))
        contentScrollView?.alwaysBounceVertical = false
        contentScrollView?.addSubview(square)
        contentScrollView?.addSubview(text)
        contentScrollView?.contentSize = bgBlurView!.frame.size
        contentScrollView?.delegate    = self
        
        
        pageView1.addSubview(bgNoBlurView!)
        pageView1.addSubview(bgBlurView!)
        //pageView1.contentSize = bgBlurView!.frame.size
        
        self.pagedScrollView.addSubview(pageView1)
        self.pagedScrollView.addSubview(contentScrollView!)
        self.pagedScrollView.backgroundColor = UIColor.whiteColor()

//        pageView1.contentSize = CGSize(width: self.view.frame.width + 2*MAX_BACKGROUND_SCROLL_DISTANCE, height: pagedScrollView.frame.height)
//        pageView1.frame = CGRectMake(0, 0, self.view.frame.width, self.pagedScrollView.frame.height)
//        pageView1.setContentOffset(CGPointMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0), animated: false)
//        self.pageView1.userInteractionEnabled = false
//        self.pagedScrollView.addSubview(pageView1)
        
        
        
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
        //self.pageView1.addSubview(backgroundImageView1)
        
        
        backgroundImageView2.image = UIImage(named: "page2")
        backgroundImageView2.frame = CGRectMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0, self.pagedScrollView.frame.width, self.pagedScrollView.frame.height)
        self.pageView2.addSubview(backgroundImageView2)
        
        
        backgroundImageView3.image = UIImage(named: "page3")
        backgroundImageView3.frame = CGRectMake(MAX_BACKGROUND_SCROLL_DISTANCE, 0, self.pagedScrollView.frame.width, self.pagedScrollView.frame.height)
        self.pageView3.addSubview(backgroundImageView3)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (scrollView == contentScrollView) {
            println("draggin")
            println(self.contentScrollView?.contentOffset)
            parallaxScroll()
            updateBlur()
        } else {
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
    
    func updateBlur() {
        var offset = CGFloat(self.contentScrollView!.contentOffset.y/200)
        if(self.contentScrollView?.contentOffset.y <= 0){
            self.bgBlurView?.alpha = 0
            println(self.contentScrollView?.frame)
        } else if (self.contentScrollView?.contentOffset.y >= 200) {
            self.bgBlurView?.alpha = 1
        } else {
            self.bgBlurView?.alpha = 0 + offset
            
        }
    }
    
    func parallaxScroll() {
        println("content: \(self.contentScrollView!.contentOffset.x), \(self.contentScrollView!.contentOffset.y)")
        println("scroll: \(pageView1.contentOffset.x), \(pageView1.contentOffset.y)")
        self.pagedScrollView.setContentOffset(CGPointZero, animated: false)
        pageView1.setContentOffset(CGPointMake(MAX_BACKGROUND_SCROLL_DISTANCE, contentScrollView!.contentOffset.y * 0.5), animated: false)
//        pageView1.setContentOffset(CGPointMake(contentScrollView!.contentOffset.x,
//            contentScrollView!.contentOffset.y * 0.5), animated: false)
    }
    
}

