//
//  PageCollectionViewCell.swift
//  AutoLayout
//
//  Created by Joshua Geronimo on 12/28/17.
//  Copyright © 2017 Joshua Geronimo. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    var page: Page? {
        didSet{
            // Make sure to safely unwrap Page
            guard let unwrappedPage = page else { return }
            // set the image for bearImageView
            bearImageView.image = UIImage(named: unwrappedPage.imageName)
            // Set the header and body description of descriptionTextView
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerDescription, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyDescription)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    // This UIView contains bearImageView
    private let topImageViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // This UIImageView contains bear_first.png
    private let bearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // This TextView is used as a UILabel to contain the description
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
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
        pc.numberOfPages = 3
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Show UI
        setUpLayoutConstraints()
        setUpBottomControlsWithStackViews()
    }
    
    // Contains all the constraints of the views initialized at the top
    private func setUpLayoutConstraints() {
        // MARK: - topImageViewContainer
        addSubview(topImageViewContainer)
        topImageViewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageViewContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        topImageViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        // MARK: - bearImageView-Constraint
        topImageViewContainer.addSubview(bearImageView)
        bearImageView.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImageViewContainer.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.5).isActive = true
        
        // MARK: - descriptionTextView-Constraint
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageViewContainer.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - Bottom-Controls-StackView
    fileprivate func setUpBottomControlsWithStackViews() {
        // StackView Container
        let bottomContainerStackView = UIStackView(arrangedSubviews: [prevButton, pageControl,  nextButton])
        addSubview(bottomContainerStackView)
        bottomContainerStackView.distribution = .fillEqually
        bottomContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for the StackView
        NSLayoutConstraint.activate([
            bottomContainerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomContainerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bottomContainerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            bottomContainerStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
