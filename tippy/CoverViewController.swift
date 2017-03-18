//
//  CoverViewController.swift
//  tippy
//
//  Created by Jessica Yang on 3/16/17.
//  Copyright © 2017 Jessica Yang. All rights reserved.
//

import UIKit

class CoverViewController: UIViewController, UIViewControllerTransitioningDelegate {
   
   
    @IBOutlet weak var menuButton: UIButton!
    
    let transition = CircularTransition()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.layer.cornerRadius = menuButton.frame.size.width/2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! ViewController
        //configure transition delegate
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
    }
   
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        return transition
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
