//
//  CircularTransition.swift
//  tippy
//
//  Created by Jessica Yang on 3/16/17.
//  Copyright © 2017 Jessica Yang. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {
    var circle = UIView()
    var startingPoint = CGPoint.zero{
        didSet{
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    var duration = 2.0
    enum CircularTransitionMode:Int{
        case present, dismiss, pop
    }
    var transitionMode:CircularTransitionMode = .present
}

extension CircularTransition:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                //reinitialize new view for circle
                circle = UIView()
                //size of circle depends on screen size, to cover completed screen
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height/2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                //transform circle and shrink it down
                circle.transform = CGAffineTransform(scaleX: 0.001, y:0.001)
                containerView.addSubview(circle)
                
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0 // invisable in the beginning
                containerView.addSubview(presentedView)
                
                //start animating
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity //original size of the circle
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1 // make it visable
                    presentedView.center = viewCenter //change center to view's center
                    
                }, completion: { (success:Bool) in
                    transitionContext.completeTransition(success)
                })
                
            }
        }else{
            //dismiss pop animation
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey){
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height/2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    //scale it down
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y:0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y:0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0//beck to invisable
                    
                    if self.transitionMode == .pop{
                        //if you use a navigator bar
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                    
                }, completion: {(success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
            
        }
    }
    
    func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect{
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        // calc offest vector, distance bewteen two points
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
}
