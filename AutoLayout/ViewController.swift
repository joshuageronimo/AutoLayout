//
//  ViewController.swift
//  AutoLayout
//
//  Created by Joshua Geronimo on 12/26/17.
//  Copyright © 2017 Joshua Geronimo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // This UIView contains bearImageView
    let topImageViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // This UIImageView contains bear_first.png
    let bearImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // This TextView is used as a UILabel to contain the description
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // This Button will act as the previous button
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    // This UIPageControl will show the user which page they are on
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
    // This Button will act as the next button
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show UI
        setUpLayoutConstraints()
        setUpBottomControlsWithStackViews()
        
            }
    
    // Contains all the constraints of the views initialized at the top
    private func setUpLayoutConstraints() {
        // MARK: - topImageViewContainer
        view.addSubview(topImageViewContainer)
        topImageViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topImageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
       
        // MARK: - bearImageView-Constraint
        topImageViewContainer.addSubview(bearImageView)
        bearImageView.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImageViewContainer.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.5).isActive = true
        
        // MARK: - descriptionTextView-Constraint
        view.addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageViewContainer.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Bottom-Controls-StackView
    fileprivate func setUpBottomControlsWithStackViews() {
        // StackView Container
        let bottomContainerStackView = UIStackView(arrangedSubviews: [prevButton, pageControl,  nextButton])
        view.addSubview(bottomContainerStackView)
        bottomContainerStackView.distribution = .fillEqually
        bottomContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for the StackView
        NSLayoutConstraint.activate([
            bottomContainerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomContainerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomContainerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomContainerStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}

