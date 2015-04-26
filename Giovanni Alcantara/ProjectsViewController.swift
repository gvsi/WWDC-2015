//
//  ProjectsViewController.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 21/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, ImagePickerDelegate {

    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var projectScrollView: UIScrollView!
    @IBOutlet weak var beaconCartView: UIView!
    @IBOutlet weak var goWalkersView: UIView!
    @IBOutlet weak var verbaCoreView: UIView!
    
    var imagePicker1 : ImagePicker?
    
    @IBAction func buttonClicked(sender: UIButton) {
        let view = ScreenModalView.instantiateFromNib()
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
        let modal = ProjectScreenShowcaseModal.show(modalView: view, inView: window!)
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
        
        var imagePicker1 = ImagePicker(frame: CGRect(x: self.view.frame.width / 2 - 50, y: 130, width: 100, height: 100))
        imagePicker1.color = UIColor(hex: "a8d4ff")
        imagePicker1.projectIdentifier = "BeaconCart"
        imagePicker1.delegate = self
        
        var imagePicker2 = ImagePicker(frame: CGRect(x: self.view.frame.width / 2 - 50, y: 130, width: 100, height: 100))
        imagePicker2.projectIdentifier = "GoWalkers"
        imagePicker2.color = UIColor(hex: "005510")
        imagePicker2.delegate = self
        
        var imagePicker3 = ImagePicker(frame: CGRect(x: self.view.frame.width / 2 - 50, y: 130, width: 100, height: 100))
        imagePicker3.projectIdentifier = "VerbaCore"
        imagePicker3.color = UIColor(hex: "e67e22")
        imagePicker3.delegate = self
        
        self.beaconCartView.addSubview(imagePicker1)
        self.goWalkersView.addSubview(imagePicker2)
        self.verbaCoreView.addSubview(imagePicker3)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        projectScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width * 3)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    // Picker
    
    func imagePickerDidSelectIndex(index: Int, imagePicker: ImagePicker) {
        let view = ScreenModalView.instantiateFromNib()
        
        switch imagePicker.projectIdentifier! {
        case "BeaconCart":
            view.image = UIImage(named: "BeaconCart\(index)")
        case "GoWalkers":
            view.image = UIImage(named: "GoWalkers\(index)")
        case "VerbaCore":
            view.image = UIImage(named: "VerbaCore\(index)")
        default:
            break
        }
        
        let window = UIApplication.sharedApplication().delegate?.window!
        let modal = ProjectScreenShowcaseModal.show(modalView: view, inView: window!)
        view.closeButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        view.bottomButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
    }

    
    
    /*
    // MARK: - Navigation
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Your Menu View Controller vew must know the following data for the proper animation
        let destinationVC = segue.destinationViewController as! MainMenuViewController
        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        destinationVC.hostTitleText = self.navigationItem.title
        destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
        destinationVC.setMenuButtonWithImage(barButton.imageView!.image!)
    }

}
