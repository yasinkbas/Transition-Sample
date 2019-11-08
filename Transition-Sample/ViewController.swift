//
//  ViewController.swift
//  Transition-Sample
//
//  Created by Yasin Akbaş on 28.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

enum Direction {
    case up, down, left, right
}

class ViewController: UIViewController {
    
    var transition = PopTransition()
    var planetSlider: PlanetScrollView!
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
        label.frame = CGRect(
            x: 0,
            y: -60,
            width: self.view.bounds.width,
            height: 60
        )
        label.alpha = 0.0
        label.center.x = self.view.bounds.midX
        label.text = "Our Solar System"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: FontName.americantypewriterbold.rawValue, size: 35)
        
        return label
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupGestures()
        makeSlider()
        addSubViews()
        onStartup()
    }
    
    func addSubViews() {
        view.addSubview(scrollContainerView)
        view.addSubview(planetSlider)
        view.addSubview(titleLabel)
    }
    
    // MARK: - Setup
    func setupGestures() {
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureHandler(_:)))
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureHandler(_:)))
        upSwipeGesture.direction = .up
        downSwipeGesture.direction = .down
        view.addGestureRecognizer(upSwipeGesture)
        view.addGestureRecognizer(downSwipeGesture)
    }
    
    @objc
    func gestureHandler(_ gesture: UISwipeGestureRecognizer) {
        print("gesture worked")
        switch gesture.direction {
        case .up:
            animateTitleLabel(direction: .up)
        case .down:
            animateTitleLabel(direction: .down)
        default: break
        }
    }
    
    // MARK: - Make
    func makeSlider() {
        planetSlider = PlanetScrollView(inView: scrollContainerView)
        planetSlider.didSelectPlanet = { index, image in
            guard let image = image else { return }
            self.clickPlanet(index: index, image: image)
        }
    }
    
    // MARK: - Action
    func clickPlanet(index: Int, image: UIImageView) {
        print(index)
        selectedPlanetImage = image
        let detailViewController =  DetailViewController()
        detailViewController.planet = planets[index]
        detailViewController.modalPresentationStyle = .fullScreen
        detailViewController.transitioningDelegate = self
        present(detailViewController,animated: true,completion: nil)
    }
    
    // MARK: - On Startup
    func onStartup() {
        animateTitleLabel(direction: .down)
    }
    
    func animateTitleLabel(direction: Direction) {
        var yPosition: CGFloat = 0
        
        switch direction {
        case .up:
            yPosition = -50
        case .down:
            yPosition = 100
        default: break
        }
        UIView.animate(
            withDuration: 1.6,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            animations: {
                self.titleLabel.frame = CGRect(
                    x: 0,
                    y: yPosition,
                    width: self.view.bounds.width,
                    height: 50
                )
                self.titleLabel.alpha = 1
        })
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
