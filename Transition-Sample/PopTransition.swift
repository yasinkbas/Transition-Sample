//
//  PopTransition.swift
//  Transition-Sample
//
//  Created by Yasin Akbaş on 28.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class PopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - parameters
    let duration = 0.5
    var originFrame = CGRect.zero
    var presenting = true
    var rotation: CGAffineTransform?
    
    // MARK: - duration function
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    // MARK: - Operation
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // MARK: Settings
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let baseView = presenting ? toView : transitionContext.view(forKey: .from) else { return }
        
        let initialFrame = presenting ? originFrame : baseView.frame
        let finalFrame = presenting ? baseView.frame : originFrame
        
        let scaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scale = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        
        if presenting {
            baseView.transform = scale
            baseView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(baseView)
        
        // MARK: Animations
        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 5,
            options: .curveLinear,
            animations: {
                
                baseView.transform = self.presenting ? .identity : scale
                baseView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                
                if !self.presenting {
                    let viewController = transitionContext.viewController(forKey: .from) as! DetailViewController
                    viewController.descContainer.alpha = 0.0
                    viewController.duplicatePlanetImage?.alpha = 0.0
                    viewController.view.backgroundColor = .clear
                    viewController.planetImageView.contentMode = .redraw
                    viewController.planetImageView.transform = .identity
                }
                
        }) { _ in
            
            // MARK: Completion
            if !self.presenting {
                let viewController = transitionContext.viewController(forKey: .to) as! ViewController
                viewController.selectedPlanetImage?.isHidden = false
            }
            
            transitionContext.completeTransition(true) // provides enable dismiss
        }
    }
}
