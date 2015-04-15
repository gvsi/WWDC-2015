//
//  LogoButton.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 15/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class LogoButton: UIButton {
    
    private var logoShape: CAShapeLayer!
    private var outerRingShape: CAShapeLayer!
    private var fillRingShape: CAShapeLayer!
    
    private let logoKey = "ACTANIMKEY"
    private let activeKey = "ACTIVE"
    private let notActiveKey = "NOTACTIVE"
    
    @IBInspectable
    var lineWidth: CGFloat = 0 {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    var activeColor: UIColor = UIColor(hex:"2c3e50") {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    var notActiveColor: UIColor = UIColor(hex:"8e44ad") {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    var logoActiveColor: UIColor = UIColor(hex:"27ae60") {
        didSet {
            updateLayerProperties()
        }
    }
    
    var isActive : Bool = false {
        didSet {
            if self.isActive {
                activate()
            }else {
                deactivate()
            }
        }
    }
    
    private func updateLayerProperties() {
        if fillRingShape != nil {
            fillRingShape.fillColor = activeColor.CGColor
        }
        
        if outerRingShape != nil {
            outerRingShape.lineWidth = lineWidth
            outerRingShape.strokeColor = notActiveColor.CGColor
        }
        
        if logoShape != nil {
            if isActive {
                logoShape.fillColor = logoActiveColor.CGColor
            } else {
                logoShape.fillColor = notActiveColor.CGColor
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createLayersIfNeeded()
        updateLayerProperties()
    }
    
    private func createLayersIfNeeded() {
        if fillRingShape == nil {
            fillRingShape = CAShapeLayer()
            fillRingShape.path = Paths.circle(frameWithInset())
            fillRingShape.bounds = CGPathGetBoundingBox(fillRingShape.path)
            fillRingShape.fillColor = activeColor.CGColor
            fillRingShape.lineWidth = lineWidth
            fillRingShape.position = CGPoint(x: CGRectGetWidth(fillRingShape.bounds)/2, y: CGRectGetHeight(fillRingShape.bounds)/2)
            fillRingShape.transform = CATransform3DMakeScale(0.2, 0.2, 0.2)
            fillRingShape.opacity = 0
            self.layer.addSublayer(fillRingShape)
        }
        if outerRingShape == nil {
            outerRingShape = CAShapeLayer()
            outerRingShape.path = Paths.circle(frameWithInset())
            outerRingShape.bounds = frameWithInset()
            outerRingShape.lineWidth = lineWidth
            outerRingShape.strokeColor = notActiveColor.CGColor
            outerRingShape.fillColor = UIColor.clearColor().CGColor
            outerRingShape.position = CGPoint(x: CGRectGetWidth(self.bounds)/2, y: CGRectGetHeight(self.bounds)/2)
            outerRingShape.transform = CATransform3DIdentity
            outerRingShape.opacity = 0.5
            self.layer.addSublayer(outerRingShape)
        }
        if logoShape == nil {
            var logoFrame = self.bounds
            logoFrame.size.width = CGRectGetWidth(logoFrame)/1.1
            logoFrame.size.height = CGRectGetHeight(logoFrame)/1.1
            
            logoShape = CAShapeLayer()
            logoShape.path = CGPath.rescaleForFrame(path: Paths.myLogo, frame: logoFrame)
            logoShape.bounds = CGPathGetBoundingBox(logoShape.path)
            logoShape.fillColor = notActiveColor.CGColor
            logoShape.position = CGPoint(x: CGRectGetWidth(CGPathGetBoundingBox(outerRingShape.path))/2, y: CGRectGetHeight(CGPathGetBoundingBox(outerRingShape.path))/2)
            logoShape.transform = CATransform3DIdentity
            logoShape.opacity = 0.5
            self.layer.addSublayer(logoShape)
        }
    }
    
    private func frameWithInset() -> CGRect {
        return CGRectInset(self.bounds, lineWidth/2, lineWidth/2)
    }
    
    private func deactivate(){
        let logoFillColor = CABasicAnimation(keyPath: "fillColor")
        logoFillColor.toValue = notActiveColor.CGColor
        logoFillColor.duration = 0.3
        
        let logoOpacity = CABasicAnimation(keyPath: "opacity")
        logoOpacity.toValue = 0.5
        logoOpacity.duration = 0.3
        
        let logoGroup = CAAnimationGroup()
        logoGroup.animations = [logoFillColor, logoOpacity]
        
        logoShape.addAnimation(logoGroup, forKey: nil)
        logoShape.fillColor = notActiveColor.CGColor
        logoShape.opacity = 0.5
        
        let fillCircle = CABasicAnimation(keyPath: "opacity")
        fillCircle.toValue = 0
        fillCircle.duration = 0.3
        fillCircle.setValue(notActiveKey, forKey: logoKey)
        fillCircle.delegate = self
        
        fillRingShape.addAnimation(fillCircle, forKey: nil)
        fillRingShape.opacity = 0
        
        let outerCircle = CABasicAnimation(keyPath: "opacity")
        outerCircle.toValue = 0.5
        outerCircle.duration = 0.3
        
        outerRingShape.addAnimation(outerCircle, forKey: nil)
        outerRingShape.opacity = 0.5
        
    }
    
    private func activate(){
        var logoGoUp = CATransform3DIdentity
        logoGoUp = CATransform3DScale(logoGoUp, 1.5, 1.5, 1.5)
        var logoGoDown = CATransform3DIdentity
        logoGoDown = CATransform3DScale(logoGoDown, 0.01, 0.01, 0.01)
        
        let logoKeyFrames = CAKeyframeAnimation(keyPath: "transform")
        logoKeyFrames.values = [NSValue(CATransform3D:CATransform3DIdentity),NSValue(CATransform3D:logoGoUp),NSValue(CATransform3D:logoGoDown)]
        logoKeyFrames.keyTimes = [0.0,0.4,0.6]
        logoKeyFrames.duration = 0.4
        logoKeyFrames.beginTime = CACurrentMediaTime() + 0.05
        logoKeyFrames.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        logoKeyFrames.fillMode =  kCAFillModeBackwards
        logoKeyFrames.setValue(activeKey, forKey: logoKey)
        logoKeyFrames.delegate = self
        
        logoShape.addAnimation(logoKeyFrames, forKey: activeKey)
        logoShape.transform = logoGoDown
        
        var grayGoUp = CATransform3DIdentity
        grayGoUp = CATransform3DScale(grayGoUp, 1.5, 1.5, 1.5)
        var grayGoDown = CATransform3DIdentity
        grayGoDown = CATransform3DScale(grayGoDown, 0.01, 0.01, 0.01)
        
        let outerCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
        outerCircleAnimation.values = [NSValue(CATransform3D:CATransform3DIdentity),NSValue(CATransform3D:grayGoUp),NSValue(CATransform3D:grayGoDown)]
        outerCircleAnimation.keyTimes = [0.0,0.4,0.6]
        outerCircleAnimation.duration = 0.4
        outerCircleAnimation.beginTime = CACurrentMediaTime() + 0.01
        outerCircleAnimation.fillMode =  kCAFillModeBackwards
        outerCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        outerRingShape.addAnimation(outerCircleAnimation, forKey: "Gray circle Animation")
        outerRingShape.transform = grayGoDown
        
        var activeFillGrow = CATransform3DIdentity
        activeFillGrow = CATransform3DScale(activeFillGrow, 1.5, 1.5, 1.5)
        let fillCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
        fillCircleAnimation.values = [NSValue(CATransform3D:fillRingShape.transform),NSValue(CATransform3D:activeFillGrow),NSValue(CATransform3D:CATransform3DIdentity)]
        fillCircleAnimation.keyTimes = [0.0,0.4,0.6]
        fillCircleAnimation.duration = 0.4
        fillCircleAnimation.beginTime = CACurrentMediaTime() + 0.22
        fillCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        fillCircleAnimation.fillMode =  kCAFillModeBackwards
        
        let activeFillOpacity = CABasicAnimation(keyPath: "opacity")
        activeFillOpacity.toValue = 1
        activeFillOpacity.duration = 1
        activeFillOpacity.beginTime = CACurrentMediaTime()
        activeFillOpacity.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        activeFillOpacity.fillMode =  kCAFillModeBackwards
        
        fillRingShape.addAnimation(activeFillOpacity, forKey: "Show fill circle")
        fillRingShape.addAnimation(fillCircleAnimation, forKey: "fill circle Animation")
        fillRingShape.transform = CATransform3DIdentity
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if let key = anim.valueForKey(logoKey) as? String {
            switch(key) {
            case (activeKey):
                endActive()
            case (notActiveKey):
                prepareForActive()
            default:
                break
            }
        }
        enableTouch()
    }
    
    private func endActive() {
        
        executeWithoutActions {
            self.logoShape.fillColor = self.logoActiveColor.CGColor
            self.logoShape.opacity = 1
            self.fillRingShape.opacity = 1
            self.outerRingShape.transform = CATransform3DIdentity
            self.outerRingShape.opacity = 0
        }
        
        let logoAnimations = CAAnimationGroup()
        var logoGoUp = CATransform3DIdentity
        logoGoUp = CATransform3DScale(logoGoUp, 2, 2, 2)
        
        let logoKeyFrames = CAKeyframeAnimation(keyPath: "transform")
        logoKeyFrames.values = [NSValue(CATransform3D: logoShape.transform),NSValue(CATransform3D:logoGoUp),NSValue(CATransform3D:CATransform3DIdentity)]
        logoKeyFrames.keyTimes = [0.0,0.4,0.6]
        logoKeyFrames.duration = 0.2
        logoKeyFrames.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        logoShape.addAnimation(logoKeyFrames, forKey: nil)
        logoShape.transform = CATransform3DIdentity
    }
    
    private func prepareForActive() {
        executeWithoutActions {
            self.fillRingShape.opacity = 0
            self.fillRingShape.transform = CATransform3DMakeScale(0.2, 0.2, 0.2)
        }
    }
    
    private func executeWithoutActions(closure: () -> ()) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        closure()
        CATransaction.commit()
    }
    
    override func animationDidStart(anim: CAAnimation!) {
        disableTouch()
    }
    
    private func disableTouch() {
        self.userInteractionEnabled = false
    }
    
    private func enableTouch() {
        self.userInteractionEnabled = true
    }
}