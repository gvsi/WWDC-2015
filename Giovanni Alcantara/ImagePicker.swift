//
//  ImagePicker.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 2015-04-25.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

enum State {
    case Open
    case Closed
    case Animating
}

protocol ImagePickerDelegate{
    func imagePickerDidSelectIndex(index : Int, imagePicker: ImagePicker)
}

class ImagePicker : UIView, ImagePickerItemDelegate{
    
    var imagePicker : ImagePickerLayer
    var state : State = State.Closed
    var projectIdentifier : String?
    
    var items : [ImagePickerItem] = [ImagePickerItem]()
    
    let angles : [CGFloat] = [ImagePicker.radians(40), ImagePicker.radians(90), ImagePicker.radians(140)]
    let bridgeAngles : [CGFloat] = [ImagePicker.radians(-50), ImagePicker.radians(0), ImagePicker.radians(50)]
    var duration : Double = 0.13
    var delegate : ImagePickerDelegate?
    let imagePickerImage = ImageIcon()
    var color : UIColor?{
        didSet{
            imagePicker.color = color?.CGColor
            for i in items{
                i.color = color
            }
        }
    }
    
    class func radians(degrees: CGFloat)->CGFloat {
        return degrees * CGFloat(M_PI) / 180
    }
    
    override init(frame: CGRect) {
        imagePicker = ImagePickerLayer()
        
        let item1 = ImagePickerItem()
        let item2 = ImagePickerItem()
        let item3 = ImagePickerItem()
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
        imagePicker.contentsScale = UIScreen.mainScreen().scale
        let imagePickerwidth = min(self.frame.size.width, self.frame.size.height)
        imagePicker.frame = CGRect(x:self.frame.size.width/2-imagePickerwidth/2, y:self.frame.size.height-imagePickerwidth, width:imagePickerwidth, height:imagePickerwidth)
        imagePicker.masksToBounds = false
        imagePicker.setNeedsDisplay()
        
        let width : CGFloat = 48
        imagePickerImage.contentScaleFactor = UIScreen.mainScreen().scale
        imagePickerImage.frame = CGRect(x: self.frame.size.width/2-width/2, y: self.frame.size.height/2-width/2, width: width, height: width)
        imagePickerImage.setNeedsDisplay()
        imagePickerImage.backgroundColor = UIColor.clearColor()
        
        self.layer.addSublayer(imagePicker)
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.addSubview(imagePickerImage)
        
        let tapper = UITapGestureRecognizer(target: self, action: "tapped:")
        self.addGestureRecognizer(tapper)
        
        addItem(item1)
        addItem(item2)
        addItem(item3)
        
        self.bringSubviewToFront(imagePickerImage)        
    }
    
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        for v in items{
            if v.pointInside(point, withEvent: event) {
                return true
            }
        }
        return true
    }
    
    func tapped(tapper : UITapGestureRecognizer){
        for v in items{
            if v.state == State.Animating{
                return
            }
        }
        
        let point = tapper.locationInView(tapper.view)
        
        if(!CGRectContainsPoint(CGRectInset(imagePicker.frame, imagePicker.insets!, imagePicker.insets!), point)){
            return
        }
        if (state == State.Closed){
            animateOpen(self.duration)
            state = State.Open
        } else if(state == State.Open){
            animateClose(self.duration)
            state = State.Closed
        }
    }

    
    func addItem(v : ImagePickerItem){
        
        let angle = angles[items.count]
        let bridgeAngle = bridgeAngles[items.count]
        var point = CGPoint(x: self.frame.size.width/2 - cos(angle) * 65, y: self.frame.size.height/2 - sin(angle) * 65)
        v.frame = CGRect(x: 0, y: 0, width: 60, height: 78)
        v.angle = bridgeAngle
        v.center = CGPoint(x: imagePicker.frame.origin.x + point.x, y: imagePicker.frame.origin.y + point.y)
        v.color = self.color
        v.delegate = self
        v.imageView.image = UIImage(named: "icon_photo")
        self.addSubview(v)
        items.append(v)
        
    }
    
    func animateOpen(duration : Double){
        
        for i in 0...items.count-1{
            let b = items[i]
            let angle = angles[i]
            let delay = duration * Double(i) + duration*2
            b.animateOpen(duration, delay: delay)
        }
        
        imagePickerImage.animate(360, fromangle:0, duration: duration*2)
        
        let out1 = imagePicker.getAnimation(duration*2.5, direction: Direction.LeftOut, type: Animation.Calm)
        let out2 = imagePicker.getAnimation(duration*2.5, direction: Direction.RightOut, type: Animation.Calm)
        let in1 = imagePicker.getAnimation(duration * 8, direction: Direction.Back, type: Animation.ImagePicker)
        imagePicker.animateGroup([out1, out2, in1])
    }
    
    func animateClose(duration : Double){
        
        for i in 1...items.count {
            let b = items[items.count - i]
            let angle = angles[angles.count - i]
            let delay = Double(i-1) * (duration) + duration/**1.5*/
            b.animateClose(duration, delay: delay)
        }
    
        imagePickerImage.animate(0, fromangle:360, duration: duration*2)
        
        let out1 = imagePicker.getAnimation(duration * 3.0, direction: Direction.RightOut, type: Animation.Calm)
        let out2 = imagePicker.getAnimation(duration * 2.1, direction: Direction.LeftOut, type: Animation.Calm)
        let in1 = imagePicker.getAnimation(duration * 8, direction: Direction.Back, type: Animation.ImagePicker)
        imagePicker.animateGroup([out1, out2, in1])
    }
    
    func imagePickerItemDidSelect(item: ImagePickerItem) {
        var i = 0
        for v in items{
            if v == item{
                break
            }
            i++
        }
        let index = i
        self.delegate?.imagePickerDidSelectIndex(index, imagePicker: self)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
