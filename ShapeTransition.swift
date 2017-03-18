//
//  ShapeTransition.swift
//  tippy
//
//  Created by Jessica Yang on 3/16/17.
//  Copyright © 2017 Jessica Yang. All rights reserved.
//

import UIKit

class ShapeTransition: NSObject {
    
    var circle = UIView()
    var startingPoint = CGPoint.zero{
        didSet{
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    var duration = 0.3
    enum CircularTransitionMode:Int{
        case present, dismiss, pop
    }
    var transitionMode:CircularTransitionMode = .present
}

extension CircularTransition:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerAnimatedTransitioning?) -> TimeInterval{
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                
                
                
                
                
                
            }
        }else{
            
        }
    }
    
    func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect{
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
}






