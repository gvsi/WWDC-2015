//
//  ImageIcon.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 2015-04-25.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit

class ImageIcon: UIView {

    func animate(angle : CGFloat, fromangle: CGFloat, duration : NSTimeInterval){
        let diff = abs(angle - fromangle)
        UIView.animateWithDuration(duration*1.8, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransformMakeRotation(diff/2 * CGFloat(M_PI)/180)
            }) { (ended) -> Void in
                UIView.animateWithDuration(duration*0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.transform = CGAffineTransformMakeRotation(angle * CGFloat(M_PI)/180)
                    }) { (ended) -> Void in
                }
        }
    }
    
    override func drawRect(rect: CGRect) {
        //image icon bezier path
        
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(43, 41))
        bezier2Path.addLineToPoint(CGPointMake(5, 41))
        bezier2Path.addCurveToPoint(CGPointMake(1, 37), controlPoint1: CGPointMake(2.79, 41), controlPoint2: CGPointMake(1, 39.21))
        bezier2Path.addLineToPoint(CGPointMake(1, 11))
        bezier2Path.addCurveToPoint(CGPointMake(5, 7), controlPoint1: CGPointMake(1, 8.79), controlPoint2: CGPointMake(2.79, 7))
        bezier2Path.addLineToPoint(CGPointMake(43, 7))
        bezier2Path.addCurveToPoint(CGPointMake(47, 11), controlPoint1: CGPointMake(45.21, 7), controlPoint2: CGPointMake(47, 8.79))
        bezier2Path.addLineToPoint(CGPointMake(47, 37))
        bezier2Path.addCurveToPoint(CGPointMake(43, 41), controlPoint1: CGPointMake(47, 39.21), controlPoint2: CGPointMake(45.21, 41))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(45, 11))
        bezier2Path.addCurveToPoint(CGPointMake(43, 9), controlPoint1: CGPointMake(45, 9.9), controlPoint2: CGPointMake(44.1, 9))
        bezier2Path.addLineToPoint(CGPointMake(5, 9))
        bezier2Path.addCurveToPoint(CGPointMake(3, 11), controlPoint1: CGPointMake(3.9, 9), controlPoint2: CGPointMake(3, 9.9))
        bezier2Path.addLineToPoint(CGPointMake(3, 37))
        bezier2Path.addCurveToPoint(CGPointMake(5, 39), controlPoint1: CGPointMake(3, 38.1), controlPoint2: CGPointMake(3.9, 39))
        bezier2Path.addLineToPoint(CGPointMake(43, 39))
        bezier2Path.addCurveToPoint(CGPointMake(45, 37), controlPoint1: CGPointMake(44.1, 39), controlPoint2: CGPointMake(45, 38.1))
        bezier2Path.addLineToPoint(CGPointMake(45, 11))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(41.33, 34.72))
        bezier2Path.addLineToPoint(CGPointMake(35, 28.38))
        bezier2Path.addLineToPoint(CGPointMake(31.38, 32))
        bezier2Path.addLineToPoint(CGPointMake(34.72, 35.33))
        bezier2Path.addCurveToPoint(CGPointMake(34.72, 36.72), controlPoint1: CGPointMake(35.1, 35.72), controlPoint2: CGPointMake(35.1, 36.33))
        bezier2Path.addCurveToPoint(CGPointMake(33.33, 36.72), controlPoint1: CGPointMake(34.33, 37.1), controlPoint2: CGPointMake(33.72, 37.1))
        bezier2Path.addLineToPoint(CGPointMake(19, 22.38))
        bezier2Path.addLineToPoint(CGPointMake(6.67, 34.72))
        bezier2Path.addCurveToPoint(CGPointMake(5.29, 34.72), controlPoint1: CGPointMake(6.29, 35.1), controlPoint2: CGPointMake(5.67, 35.1))
        bezier2Path.addCurveToPoint(CGPointMake(5.29, 33.33), controlPoint1: CGPointMake(4.9, 34.33), controlPoint2: CGPointMake(4.9, 33.72))
        bezier2Path.addLineToPoint(CGPointMake(18.19, 20.43))
        bezier2Path.addCurveToPoint(CGPointMake(18.29, 20.28), controlPoint1: CGPointMake(18.22, 20.38), controlPoint2: CGPointMake(18.24, 20.33))
        bezier2Path.addCurveToPoint(CGPointMake(19, 20), controlPoint1: CGPointMake(18.48, 20.09), controlPoint2: CGPointMake(18.74, 20))
        bezier2Path.addCurveToPoint(CGPointMake(19.71, 20.28), controlPoint1: CGPointMake(19.26, 20), controlPoint2: CGPointMake(19.52, 20.09))
        bezier2Path.addCurveToPoint(CGPointMake(19.81, 20.43), controlPoint1: CGPointMake(19.76, 20.33), controlPoint2: CGPointMake(19.78, 20.38))
        bezier2Path.addLineToPoint(CGPointMake(30, 30.62))
        bezier2Path.addLineToPoint(CGPointMake(34.19, 26.43))
        bezier2Path.addCurveToPoint(CGPointMake(34.28, 26.28), controlPoint1: CGPointMake(34.22, 26.38), controlPoint2: CGPointMake(34.24, 26.33))
        bezier2Path.addCurveToPoint(CGPointMake(35, 26), controlPoint1: CGPointMake(34.48, 26.09), controlPoint2: CGPointMake(34.74, 26))
        bezier2Path.addCurveToPoint(CGPointMake(35.72, 26.28), controlPoint1: CGPointMake(35.26, 26), controlPoint2: CGPointMake(35.52, 26.09))
        bezier2Path.addCurveToPoint(CGPointMake(35.81, 26.43), controlPoint1: CGPointMake(35.76, 26.33), controlPoint2: CGPointMake(35.78, 26.38))
        bezier2Path.addLineToPoint(CGPointMake(42.72, 33.33))
        bezier2Path.addCurveToPoint(CGPointMake(42.72, 34.72), controlPoint1: CGPointMake(43.1, 33.72), controlPoint2: CGPointMake(43.1, 34.33))
        bezier2Path.addCurveToPoint(CGPointMake(41.33, 34.72), controlPoint1: CGPointMake(42.33, 35.1), controlPoint2: CGPointMake(41.72, 35.1))
        bezier2Path.closePath()
        bezier2Path.moveToPoint(CGPointMake(29, 19))
        bezier2Path.addCurveToPoint(CGPointMake(25, 15), controlPoint1: CGPointMake(26.79, 19), controlPoint2: CGPointMake(25, 17.21))
        bezier2Path.addCurveToPoint(CGPointMake(27.36, 11.36), controlPoint1: CGPointMake(25, 13.38), controlPoint2: CGPointMake(25.97, 11.99))
        bezier2Path.addCurveToPoint(CGPointMake(27, 13), controlPoint1: CGPointMake(27.13, 11.86), controlPoint2: CGPointMake(27, 12.41))
        bezier2Path.addCurveToPoint(CGPointMake(31, 17), controlPoint1: CGPointMake(27, 15.21), controlPoint2: CGPointMake(28.79, 17))
        bezier2Path.addCurveToPoint(CGPointMake(32.64, 16.64), controlPoint1: CGPointMake(31.59, 17), controlPoint2: CGPointMake(32.14, 16.87))
        bezier2Path.addCurveToPoint(CGPointMake(29, 19), controlPoint1: CGPointMake(32.01, 18.03), controlPoint2: CGPointMake(30.62, 19))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 4;
        
        bezier2Path.usesEvenOddFillRule = true;

        UIColor.whiteColor().setFill()
        bezier2Path.fill()

        
    }
}
