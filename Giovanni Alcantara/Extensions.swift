//
//  Extensions.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 15/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init (hex:String) {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (count(cString) != 6) {
            self.init()
            return
        }
        
        var rString = (cString as NSString).substringToIndex(2)
        var gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        var bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}

import UIKit

extension CALayer {
    func applyAnimation(animation: CABasicAnimation) {
        let copy = animation.copy() as! CABasicAnimation
        if copy.fromValue == nil {
            copy.fromValue = self.presentationLayer().valueForKeyPath(copy.keyPath)
        }
        self.addAnimation(copy, forKey: copy.keyPath)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.setValue(copy.toValue, forKeyPath:copy.keyPath)
        CATransaction.commit()
    }
}

extension CGPath {
    class func rescaleForFrame(#path: CGPath, frame: CGRect) -> CGPath{
        let boundingBox = CGPathGetBoundingBox(path);
        let boundingBoxAspectRatio = CGRectGetWidth(boundingBox)/CGRectGetHeight(boundingBox);
        let viewAspectRatio = CGRectGetWidth(frame)/CGRectGetHeight(frame);
        
        var scaleFactor: CGFloat = 1.0;
        if (boundingBoxAspectRatio > viewAspectRatio) {
            scaleFactor = CGRectGetWidth(frame)/CGRectGetWidth(boundingBox);
        } else {
            scaleFactor = CGRectGetHeight(frame)/CGRectGetHeight(boundingBox);
        }
        
        var scaleTransform = CGAffineTransformIdentity;
        scaleTransform = CGAffineTransformScale(scaleTransform, scaleFactor, scaleFactor);
        scaleTransform = CGAffineTransformTranslate(scaleTransform, -CGRectGetMinX(boundingBox), -CGRectGetMinY(boundingBox));
        let scaledSize = CGSizeApplyAffineTransform(boundingBox.size, CGAffineTransformMakeScale(scaleFactor, scaleFactor));
        let centerOffset = CGSizeMake((CGRectGetWidth(frame)-scaledSize.width)/(scaleFactor*2.0), (CGRectGetHeight(frame)-scaledSize.height)/(scaleFactor*2.0));
        scaleTransform = CGAffineTransformTranslate(scaleTransform, centerOffset.width, centerOffset.height);
        return CGPathCreateCopyByTransformingPath(path, &scaleTransform);
    }
}

import QuartzCore

extension CALayer {
    
    public typealias PulsarClosure = (Builder) -> ()
    
    public func addPulse(closure: PulsarClosure? = nil) -> CAShapeLayer? {
        if (self.masksToBounds) {
            println("Aborting. CALayers with 'masksToBounds' set to YES cannot show pulse.");
            return nil;
        }
        
        let builder = Builder(self)
        if let closure = closure {
            closure(builder);
        }
        
        let pulseLayer = CAShapeLayer()
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        assert((builder.borderColors.count > 0) || (builder.backgroundColors.count > 0))
        
        pulseLayer.fillColor = builder.backgroundColors.first
        pulseLayer.frame = self.bounds
        pulseLayer.opacity = 0.0
        pulseLayer.path = builder.path
        pulseLayer.strokeColor = builder.borderColors.first
        pulseLayer.lineWidth = builder.lineWidth
        
        CATransaction.commit()
        
        self.insertSublayer(pulseLayer, atIndex:0)
        
        if var pulsarLayers = self.pulsarLayers as? [CAShapeLayer] {
            pulsarLayers.append(pulseLayer)
            self.pulsarLayers = pulsarLayers
        }
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 1.0
        alphaAnimation.toValue = 0.0
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        scaleAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(2.0, 2.0, 1.0))
        
        var animations: [CAAnimation] = [alphaAnimation, scaleAnimation]
        
        if (builder.borderColors.count > 1) {
            let colorAnimation = CAKeyframeAnimation(keyPath: "strokeColor")!
            colorAnimation.values = builder.borderColors;
            animations.append(colorAnimation)
        }
        
        if (builder.backgroundColors.count > 1) {
            let colorAnimation = CAKeyframeAnimation(keyPath: "fillColor")!
            colorAnimation.values = builder.backgroundColors;
            animations.append(colorAnimation)
        }
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = builder.duration;
        animationGroup.animations = animations;
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animationGroup.repeatCount = Float(min(Float(builder.repeatCount), FLT_MAX))
        animationGroup.delegate = Delegate(pulseLayer: pulseLayer)
        pulseLayer.addAnimation(animationGroup, forKey: nil)
        
        return pulseLayer
    }
    
    public func removePulses() {
        for pulseLayer in self.pulsarLayers {
            pulseLayer.removeAllAnimations()
            pulseLayer.removeFromSuperlayer()
        }
        self.pulsarLayers = []
    }
    
    var pulsarLayers: NSArray {
        set {
            self.setValue(newValue, forKey: PulsarConstants.layersKey)
        }
        get {
            let pulsarLayers = self.valueForKey(PulsarConstants.layersKey) as? NSArray
            return pulsarLayers ?? NSArray()
        }
    }
}
