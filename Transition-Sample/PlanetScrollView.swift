//
//  PlanetScrollView.swift
//  Transition-Sample
//
//  Created by Yasin Akbaş on 28.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

let itemCount = planets.count

class PlanetScrollView: UIScrollView {
    
    var didSelectPlanet: ((_ index:Int, _ image: UIImageView?) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(inView view: UIView) {
        self.init(frame: view.frame)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        alpha = 1.0
        
        let baseViewWidth = view.frame.height
        let baseViewHeight = view.frame.height
        
        for i in 0..<Int(itemCount) {
            
            let view = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: baseViewWidth,
                height: baseViewHeight
                )
            )
            view.center = CGPoint(
                x: Double(i) * 1.1 * Double(baseViewWidth) + Double(baseViewWidth) / 2,
                y: Double(baseViewHeight) / 2
            )
            view.tag = i
            view.isUserInteractionEnabled = true
            view.layer.cornerRadius = view.frame.height / 2
            
            let planetImage = UIImageView()
            planetImage.frame = view.bounds
            planetImage.contentMode = .scaleAspectFill
            planetImage.image = planets[i].image
            planetImage.isUserInteractionEnabled = true
            planetImage.tag = i
            
            view.addSubview(planetImage)
            
            addSubview(view)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapPlanet(_:)))
            planetImage.addGestureRecognizer(tap)
        }
        
        contentSize = CGSize(
            width: CGFloat(itemCount) * 1.1 * (baseViewWidth) - (baseViewWidth * 1.1 - baseViewWidth) + 5,
            height: baseViewHeight
        )
    }
    
    @objc func didTapPlanet(_ tap: UITapGestureRecognizer) {
        let imageView = tap.view as? UIImageView
        
        didSelectPlanet?(tap.view!.tag, imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
