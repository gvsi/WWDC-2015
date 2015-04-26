//
//  AboutMeCollection.swift
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 2015-04-25.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import Foundation
import UIKit

let UIColors = [
    ("#55EFCB", "#5BCAFF"), ("#FF5E3A", "#FF2A68"), ("#FF9500", "#FF5E3A"), ("#87FC70", "#0BD318"), ("#52EDC7", "#5AC8FB"), ("#1AD6FD", "#1D62F0"), ("#C644FC", "#5856D6"), ("#1D77EF", "#81F3FD"), ("#55EFCB", "#5BCAFF")
]

struct AboutMeDetail{
    var imageName: String
    var backgroundColor: UIColor
    var text: String
    
    static func detailViewForCell(cell: UICollectionViewCell, atViewController viewController: UICollectionViewController) -> UIView{
        let view = NSBundle.mainBundle().loadNibNamed("AboutMeDetailView", owner: viewController, options: nil)[0] as! UIView
        
        view.frame = cell.frame
        view.frame.size.width = cell.frame.width * 2
        
        let indexPath = viewController.collectionView?.indexPathForCell(cell)
        
        
        var gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.frame.size.width = cell.frame.width * 2
        
        var randomColors = UIColors[Int(arc4random_uniform(UInt32(UIColors.count)))]
        gradient.colors = [UIColor(hex: randomColors.0).CGColor, UIColor(hex: randomColors.1).CGColor]
        
        view.layer.insertSublayer(gradient, atIndex: 0)
        
        let detailViewLabel = view.viewWithTag(1000) as! UILabel
        detailViewLabel.text = AboutMeCollection.collection()[indexPath!.row].text
        
        
        return view
    }
}

class AboutMeCollection{
    
    class func collection() -> [AboutMeDetail]{
        return [
            AboutMeDetail(
                imageName: "1",
                backgroundColor: UIColor(red:0.13, green:0.62, blue:0.52, alpha:1),
                text: "Yes, just like that! Good job!"
            ),
            AboutMeDetail(
                imageName: "2",
                backgroundColor: UIColor(red:0.16, green:0.5, blue:0.73, alpha:1),
                text: "Hello, world! I’m Giovanni. I'm a first-year university student in Computer Science.\nThis is my entry for the WWDC 2015 scholarship."
            ),
            AboutMeDetail(
                imageName: "3",
                backgroundColor: UIColor(red:0.56, green:0.27, blue:0.68, alpha:1),
                text: "I was born in Rome, Italy, from a Filipino family. I currently live in Edinburgh, Scotland, where I study at the University of Edinburgh (Yes, I’ve had my fair bit of diversity!)"
            ),
            AboutMeDetail(
                imageName: "4",
                backgroundColor: UIColor(red:0.89, green:0.49, blue:0.19, alpha:1),
                text: "What captivated me in the dynamic field of Computer Science is how it represents the heart of today’s fundamental technologies and the catalyst of multiple scientific disciplines."
            ),
            AboutMeDetail(
                imageName: "5",
                backgroundColor: UIColor(red:0.17, green:0.24, blue:0.31, alpha:1),
                text: "I started independently learning programming at a very young age. I was filled with exuberance when concepts just started to click realising, at thirteen, the limitless possibilities of those cryptic lines of code."
            ),
            AboutMeDetail(
                imageName: "6",
                backgroundColor: UIColor(red:0.13, green:0.62, blue:0.52, alpha:1),
                text: "I quickly became proficient with web technologies like HTML, CSS, Javascript and PHP. I gradually developed my own vision of software: it is not merely about programming but about making an impact."
            ),
            AboutMeDetail(
                imageName: "7",
                backgroundColor: UIColor(red:0.16, green:0.5, blue:0.73, alpha:1),
                text: "I have always been fascinated by design, and progressively realized how the smallest detail is functional to the final product."
            ),
            AboutMeDetail(
                imageName: "8",
                backgroundColor: UIColor(red:0.56, green:0.27, blue:0.68, alpha:1),
                text: "By offering web design services as a freelancing teenager, I was able to pay for part of my education, but most importantly my first personal computer: a Macbook Pro."
            ),
            AboutMeDetail(
                imageName: "9",
                backgroundColor: UIColor(red:0.89, green:0.49, blue:0.19, alpha:1),
                text: "I started learning iOS development in 2010 with an iTunes U course by Stanford: CS193P. I was quickly captivated realizing how behind every iOS device there is a great development environment and community."
            ),
            AboutMeDetail(
                imageName: "10",
                backgroundColor: UIColor(red:0.17, green:0.24, blue:0.31, alpha:1),
                text: "Learning Swift after languages like Java, Haskell or Javascript was extremely satisfying as I saw each language's best features condensed into one, to ultimately write the apps of the future."
            ),
            AboutMeDetail(
                imageName: "11",
                backgroundColor: UIColor(red:0.89, green:0.49, blue:0.19, alpha:1),
                text: "WWDC is a unique environment that would enable me to learn, share ideas, and have a first-hand experience of Apple’s innovation, to dream and live at the edge of the future."
            ),
            AboutMeDetail(
                imageName: "12",
                backgroundColor: UIColor(red:0.17, green:0.24, blue:0.31, alpha:1),
                text: "Thank you for reviewing my application for WWDC 2015!"
            )
            
        ]
    }
    
}