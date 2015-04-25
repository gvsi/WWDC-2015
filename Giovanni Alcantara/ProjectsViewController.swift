//
//  ProjectsViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 21/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, GooeyDelegate {

    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var projectScrollView: UIScrollView!
    @IBOutlet weak var beaconCartView: UIView!
    @IBOutlet weak var goWalkersView: UIView!
    
    var gooey = Gooey(frame: CGRect(x: 100, y: 100, width: 120, height: 120))
    
    
    @IBAction func buttonClicked(sender: UIButton) {
        let view = ImageModalView.instantiateFromNib()
        switch sender.tag {
        case 0:
            view.image = UIImage(named: "BeaconCart2")
        case 1:
            view.image = UIImage(named: "GoWalkers1")
        case 2:
            view.image = UIImage(named: "VerbaCore1")
        default:
            break
        }
        
        let window = UIApplication.sharedApplication().delegate?.window!
        let modal = PathDynamicModal.show(modalView: view, inView: window!)
        view.closeButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        view.bottomButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gooey.color = UIColor(red: 29/255.0, green: 163/255, blue: 1, alpha: 1.0)
        gooey.delegate = self
        self.beaconCartView.addSubview(gooey)
        
        
//        let slider = UISlider(frame: CGRect(x: 20, y: 300, width: 280, height: 40))
//        slider.addTarget(self, action: "update:", forControlEvents: UIControlEvents.ValueChanged)
//        self.view.addSubview(slider)
        
//        let label = UILabel(frame: CGRect(x: 0, y: 350, width: 320, height: 40))
//        label.textAlignment = NSTextAlignment.Center
//        label.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
//        self.view.addSubview(label)
//        
//        durationLabel = label
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        projectScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width * 3)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    // Picker
    func update(s : UISlider){
        let duration = 0.13 + Double(s.value)
        
        let string = NSMutableAttributedString(string: String(format: "Duration: %0.2f", duration))
        string.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!, range: NSMakeRange(0, 9))
//        self.durationLabel.attributedText = string
        self.gooey.duration = duration
    }
    
    func gooeyDidSelectIndex(index: Int) {
        println("Gooey did select index \(index)")
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
