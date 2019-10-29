//
//  DetailViewController.swift
//  Transition-Sample
//
//  Created by Yasin Akbaş on 28.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var planet:Planet!
    
    var duplicatePlanetImage: UIImageView?
    
    var rotating = CGFloat.pi * 2
    
    // MARK: - UI Objects
    
    lazy var planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var descContainer: UIView = {
        
        // container
        let containerView = UIView()
        containerView.frame = CGRect(
            x: -(self.view.bounds.width * 1.2 - self.view.bounds.width) / 2,
            y: self.view.bounds.height / 2,
            width: self.view.bounds.width * 1.2,
            height: self.view.bounds.height / 2
        )
        containerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2993899829)
        
        // title label
        let label = UILabel()
        label.frame = CGRect(
            x: 0,
            y: 20,
            width: containerView.bounds.width,
            height: 50
        )
        label.tag = 101
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: FontName.americantypewriter.rawValue, size: 30)
        containerView.addSubview(label)
        
        // tiny line
        let line = UIView()
        line.frame = CGRect(
            x: 0,
            y: 62,
            width: containerView.bounds.width * 0.7,
            height: 1
        )
        line.center.x = containerView.bounds.midX
        line.backgroundColor = .white
        containerView.addSubview(line)
        
        // descTextView
        let descTextView = UITextView()
        descTextView.frame = CGRect(
            x: 0,
            y: 80,
            width: containerView.bounds.width * 0.7,
            height: containerView.bounds.height - 120
        )
        descTextView.center.x = containerView.bounds.midX
        descTextView.backgroundColor = .clear
        descTextView.textColor = .white
        descTextView.textAlignment = .center
        descTextView.font = UIFont(name: FontName.americantypewriter.rawValue, size: 16)
        descTextView.isEditable = false
        descTextView.alpha = 0.0
        descTextView.tag = 102
        containerView.addSubview(descTextView)
        
        return containerView
    }()
    
    // MARK: - view lifecycle
    override func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.animatePlanetImageView()
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
        
        view.addSubview(planetImageView)
        view.addSubview(descContainer)
        
        configureView()
    }
    
    // MARK: - initial animation
    func animatePlanetImageView() {
        
        UIView.animate(
            withDuration: 1,
            animations: {
                self.planetImageView.transform = CGAffineTransform(scaleX: 0.45, y: 0.45)
                self.getDescTextView()?.alpha = 1.0
        },completion: { _ in
            self.view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(gesture:)))
            )
            self.rotatePlanet()
        }
        )
    }
    
    func rotatePlanet() {
        planetImageView.isHidden = true
        
        duplicatePlanetImage = UIImageView(frame: planetImageView.frame)
        duplicatePlanetImage?.image = planetImageView.image
        duplicatePlanetImage?.contentMode = .scaleAspectFill
        
        view.addSubview(duplicatePlanetImage!)
        planetImageView.superview?.bringSubviewToFront(duplicatePlanetImage!)
        planetImageView.superview?.bringSubviewToFront(descContainer)
        startRotatingDuplicatePlanetImage()
    }
    
    func startRotatingDuplicatePlanetImage() {
        UIView.animate(
            withDuration: 15,
            delay: 0.0,
            options: [.curveLinear],
            animations: { [weak self] in
                guard let self = self else { return }
                self.rotating += .pi / 4
                self.duplicatePlanetImage?.transform = CGAffineTransform(rotationAngle: self.rotating)
                
                print("rotating \(self.rotating)")
            },
            completion: { [weak self] _ in
                guard let self = self else { return }
                self.startRotatingDuplicatePlanetImage()
            }
        )
    }
    
    // MARK: - configure view
    func configureView() {
        planetImageView.image = planet.image
        
        let titleLabel = getTitleLabel()
        titleLabel?.text = self.planet.name
        
        let descTextView = getDescTextView()
        descTextView?.text = self.planet.desc
        
    }
    
    // MARK: - Get view
    func getDescTextView() -> UITextView? {
        let textView = getView(withTag: 102, in: descContainer) as? UITextView
        
        return textView
    }
    
    
    func getTitleLabel() -> UILabel? {
        let label = getView(withTag: 101, in: descContainer) as? UILabel
        
        return label
    }
    
    func getView(withTag tag: Int, in superView: UIView) -> UIView? {
        let view = superView.subviews.filter({ $0.tag == tag }).first
        
        return view
    }
    
    // MARK: - Gesture
    @objc func imageViewTapped(gesture: UIGestureRecognizer) {
        planetImageView.isHidden = false
        dismiss(animated: true, completion: nil)
    }
}
