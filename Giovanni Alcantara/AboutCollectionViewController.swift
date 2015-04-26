//
//  AboutCollectionViewController
//  Giovanni Alcantara
//
//  Created by Giovanni Alcantara on 19/04/2015.
//  Copyright (c) 2015 Giovanni Alcantara. All rights reserved.
//

import UIKit
import AVFoundation

class AboutCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var barButton: UIButton!
    
    var animationInProgress = false
    var indexPathOfCellBeingOpened: NSIndexPath?
    var cellBeingOpened: UICollectionViewCell?
    var positionOfcellBeingOpened: String?
    var panStartXPoint: CGFloat?
    var panEndXPoint: CGFloat?
    var imageOfCellBeingOpened: UIImageView?
    var detailViewOfCellBeingOpened: UIView?
    var firstImageOfDetailView: UIImageView?
    var lastImageOfDetailView: UIImageView?
    
    var photos: [AboutMeDetail] = AboutMeCollection.collection()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.delegate = self
    }
    
    @IBAction func handleGesture(sender: AnyObject) {
        var location = sender.locationInView(sender as? UIView)
        location = CGPointMake(location.x, location.y + collectionView!.contentOffset.y)
        
        let velocity = panRecognizer.velocityInView(sender as? UIView)
        let centerXPoint = view.frame.width / 2
        var direction: String
        var distanceDistanceOfCompleteTransition: CGFloat
        var percentageToCompletelyOpen: CGFloat!
        
        
        if panRecognizer.state == UIGestureRecognizerState.Began {
            if !animationInProgress {
            animationInProgress = true
            indexPathOfCellBeingOpened = collectionView?.indexPathForItemAtPoint(location)
            cellBeingOpened = collectionView?.cellForItemAtIndexPath(indexPathOfCellBeingOpened!)
            positionOfcellBeingOpened = (indexPathOfCellBeingOpened!.row % 2 == 0) ? "left" : "right"
            panStartXPoint = location.x
            panEndXPoint = centerXPoint + (centerXPoint - location.x)
            
            imageOfCellBeingOpened = UIImageView(image: ImageFactory.captureView(cellBeingOpened!.contentView))
            imageOfCellBeingOpened?.frame = cellBeingOpened!.frame
            imageOfCellBeingOpened?.frame.origin.y -= collectionView!.contentOffset.y
            imageOfCellBeingOpened?.layer.anchorPoint = (positionOfcellBeingOpened == "left") ? CGPointMake(1.0, 0.5) : CGPointMake(0.0, 0.5)
            
            // Hiding cell view
            cellBeingOpened?.alpha = 0
            view.addSubview(imageOfCellBeingOpened!)
            
            detailViewOfCellBeingOpened = AboutMeDetail.detailViewForCell(cellBeingOpened!, atViewController: self)
            
            // Snapshot
            let imagesOfDetailViewParts = ImageFactory.split(
                ImageFactory.captureView(detailViewOfCellBeingOpened!)
            )
            
            let leftPartView = UIImageView(image: imagesOfDetailViewParts.left)
            let rightPartView = UIImageView(image: imagesOfDetailViewParts.right)
            
            leftPartView.frame = cellBeingOpened!.frame
            leftPartView.frame.origin.y -= collectionView!.contentOffset.y
            
            rightPartView.frame = cellBeingOpened!.frame
            rightPartView.frame.origin.y -= collectionView!.contentOffset.y
            
            rightPartView.frame.origin.x = cellBeingOpened!.frame.width
            
            if positionOfcellBeingOpened == "left"{
                firstImageOfDetailView = leftPartView
                view.addSubview(firstImageOfDetailView!)
                
                lastImageOfDetailView = rightPartView
                lastImageOfDetailView?.layer.anchorPoint = CGPointMake(0.0, 0.5) // Anchor point to the left side of the image
                view.addSubview(lastImageOfDetailView!)
                
            }else{
                firstImageOfDetailView = rightPartView
                view.addSubview(firstImageOfDetailView!)
                
                lastImageOfDetailView = leftPartView
                lastImageOfDetailView?.layer.anchorPoint = CGPointMake(1.0, 0.5) // Anchor point to the right side of the image
                view.addSubview(lastImageOfDetailView!)
            }
            }
        }
        
        // Simmetric completion point
        distanceDistanceOfCompleteTransition = abs(panEndXPoint! - panStartXPoint!)
        distanceDistanceOfCompleteTransition = distanceDistanceOfCompleteTransition < 100 ? 100 : distanceDistanceOfCompleteTransition
        percentageToCompletelyOpen = ((location.x - panStartXPoint!) / distanceDistanceOfCompleteTransition) * 100
        
        direction = (velocity.x > 0) ? "right" : "left"
        
        if positionOfcellBeingOpened == "right"{
            percentageToCompletelyOpen = CGFloat(percentageToCompletelyOpen * -1)
        }
        
        if percentageToCompletelyOpen > 0 && percentageToCompletelyOpen <= 50 {
            lastImageOfDetailView?.alpha = 0
            imageOfCellBeingOpened?.alpha = 1
            
            imageOfCellBeingOpened?.layer.transform = cellTransformToPercent(
                percentageToCompletelyOpen / 100,
                cellPosition: positionOfcellBeingOpened!,
                panDirection: direction,
                secondHalf: false
            )
            
        } else if percentageToCompletelyOpen > 50 && percentageToCompletelyOpen <= 100 {
            lastImageOfDetailView?.alpha = 1
            imageOfCellBeingOpened?.alpha = 0
            
            lastImageOfDetailView?.layer.transform = cellTransformToPercent(
                percentageToCompletelyOpen / 100,
                cellPosition: positionOfcellBeingOpened!,
                panDirection: direction,
                secondHalf: true
            )
        }
        
        
        if(panRecognizer.state == UIGestureRecognizerState.Ended){
            // animate half
            if percentageToCompletelyOpen <= 50 {
                
                UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn | UIViewAnimationOptions.CurveEaseOut, animations: {
                    
                    self.imageOfCellBeingOpened?.layer.transform = self.cellTransformToPercent(
                        0 / 100,
                        cellPosition: self.positionOfcellBeingOpened!,
                        panDirection: direction,
                        secondHalf: false
                    )
                    return
                    
                    }, completion: {_ in
                        self.imageOfCellBeingOpened?.removeFromSuperview()
                        self.firstImageOfDetailView?.removeFromSuperview()
                        self.lastImageOfDetailView?.removeFromSuperview()
                        self.detailViewOfCellBeingOpened = nil
                        self.cellBeingOpened?.alpha = 1
                        self.animationInProgress = false
                    }
                )
   
                
            }else{
                // animate all
                UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn | UIViewAnimationOptions.CurveEaseOut, animations: {
                    
                    self.lastImageOfDetailView?.layer.transform = self.cellTransformToPercent(
                        50 / 100,
                        cellPosition: self.positionOfcellBeingOpened!,
                        panDirection: direction,
                        secondHalf: true
                    )
                    return
                    
                    }, completion: {_ in
                        self.imageOfCellBeingOpened?.alpha = 1
                        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn | UIViewAnimationOptions.CurveEaseOut, animations: {
                            
                            self.imageOfCellBeingOpened?.layer.transform = self.cellTransformToPercent(
                                0 / 100,
                                cellPosition: self.positionOfcellBeingOpened!,
                                panDirection: direction,
                                secondHalf: false
                            )
                            return
                            
                            }, completion: {_ in
                                self.imageOfCellBeingOpened?.removeFromSuperview()
                                self.firstImageOfDetailView?.removeFromSuperview()
                                self.lastImageOfDetailView?.removeFromSuperview()
                                self.detailViewOfCellBeingOpened = nil
                                self.cellBeingOpened?.alpha = 1
                                self.animationInProgress = false
                            }
                        )
                    }
                )
                
            }
        }
    }
    
    func cellTransformToPercent(percent: CGFloat, cellPosition: String, panDirection: String, secondHalf: Bool) -> CATransform3D {
        var identity = CATransform3DIdentity
        var angle: CGFloat
        var percentForAngle: CGFloat
        
        identity.m34 = -1.0/2000
        percentForAngle = secondHalf ? (1 - percent) : percent
        
        angle = percentForAngle * 2 * CGFloat(M_PI_2)
        var translation = cellBeingOpened!.frame.width * 0.5
        
        if cellPosition == "right"{
            angle *= -1
            translation *= -1
        }
        if secondHalf{
            angle *= -1
            translation *= (cellPosition == "left") ? -1 : 1
        }
        
        let rotationTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0)
        let translationTransform = CATransform3DMakeTranslation(translation, 0, 0)
        
        return CATransform3DConcat(rotationTransform, translationTransform)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let velocity = panRecognizer.velocityInView(self.view)
        
        return fabs(velocity.x) > fabs(velocity.y);
    }
    
}

extension AboutCollectionViewController{
    
    // CollectionView Delegate
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(indexPath.row != 11 ? "Cell" : "Cell2", forIndexPath: indexPath) as! UICollectionViewCell
        
        let imageView = cell.viewWithTag(1000) as! UIImageView
        var view = cell.viewWithTag(2000)!
        
        if indexPath.row != 11 {
            let photo = photos[indexPath.row] as AboutMeDetail
            imageView.image = UIImage(named: photo.imageName)
        } else {
            var view = cell.viewWithTag(2000)!
            dispatch_async(dispatch_get_main_queue(),{
                var cameraView = AboutMeCameraView(frame: view.frame, position: DevicePosition.Front, blur: UIBlurEffectStyle.Dark)
                cameraView.removeBlurEffect()
                view.addSubview(cameraView)
            })
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let halfTheWidthOfTheWindow = collectionView.frame.width / 2
        
        return CGSizeMake(halfTheWidthOfTheWindow, halfTheWidthOfTheWindow)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    // Sege
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! MainMenuViewController
        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        destinationVC.hostTitleText = self.navigationItem.title
        destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
        destinationVC.setMenuButtonWithImage(barButton.imageView!.image!)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
