//
//  ViewController.swift
//  Transition-Sample
//
//  Created by Yasin Akbaş on 28.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var planetSlider: PlanetScrollView!
    
    // MARK: transition object
    var transition = PopTransition()
    
    var selectedPlanetImage: UIImageView?
    
    lazy var scrollContainerView: UIView = {
        let view = UIView()
        view.frame = CGRect(
            x: 0,
            y: self.view.bounds.height - 125,
            width: self.view.bounds.width,
            height: 100
        )
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        let width = self.view.bounds.width
        label.frame = CGRect(
            x: 0,
            y: 200,
            width: width,
            height: 50
        )
        label.center.x = self.view.bounds.midX
        label.text = "Our Solar System"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: FontName.americantypewriterbold.rawValue, size: 35)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        makeSlider()
        addSubViews()
    }
    
    func addSubViews() {
        view.addSubview(scrollContainerView)
        view.addSubview(planetSlider)
        view.addSubview(titleLabel)
    }
    
    func makeSlider() {
        planetSlider = PlanetScrollView(inView: scrollContainerView)
        planetSlider.didSelectPlanet = { index, image in
            guard let image = image else { return }
            self.clickPlanet(index: index, image: image)
        }
    }
    
    func clickPlanet(index: Int, image: UIImageView) {
        print(index)
        selectedPlanetImage = image
        let detailViewController =  DetailViewController()
        detailViewController.planet = planets[index]
        detailViewController.modalPresentationStyle = .fullScreen
        detailViewController.transitioningDelegate = self
        present(detailViewController,animated: true,completion: nil)
    }
}

// MARK: - TransitionDelegate
extension ViewController: UIViewControllerTransitioningDelegate {
    
    // MARK: present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = (selectedPlanetImage!.superview?.convert(selectedPlanetImage!.frame, to: nil))!
        transition.presenting = true
        selectedPlanetImage?.isHidden = true
        return transition
    }
    
    // MARK: dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

