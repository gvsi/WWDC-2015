//
//  ScreenModalView.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 21/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class ScreenModalView: UIView {
    var bottomButtonHandler: (() -> Void)?
    var closeButtonHandler: (() -> Void)?
    var image: UIImage? {
        set {
            self.imageView.image = newValue
        }
        get {
            return self.imageView.image
        }
    }
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var contentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    private func configure() {
        self.contentView.layer.cornerRadius = 5.0
        self.closeButton.layer.cornerRadius = CGRectGetHeight(self.closeButton.bounds) / 2.0
        self.closeButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.closeButton.layer.shadowOffset = CGSizeZero
        self.closeButton.layer.shadowOpacity = 0.3
        self.closeButton.layer.shadowRadius = 2.0
    }
    
    class func instantiateFromNib() -> ScreenModalView {
        let view = UINib(nibName: "ScreenModalView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! ScreenModalView
        
        return view
    }
    
    @IBAction func handleCloseButton(sender: UIButton) {
        self.closeButtonHandler?()
    }
    
    @IBAction func handleBottomButton(sender: UIButton) {
        self.bottomButtonHandler?()
    }
}