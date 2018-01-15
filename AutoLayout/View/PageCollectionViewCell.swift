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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Show UI
        setUpLayoutConstraints()
    }
    
    // Contains all the constraints of the views initialized at the top
    private func setUpLayoutConstraints() {
        // add Subviews
        addSubview(topImageViewContainer)
        topImageViewContainer.addSubview(bearImageView)
        addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            // topImageViewContainer-Constraint
            topImageViewContainer.topAnchor.constraint(equalTo: topAnchor),
            topImageViewContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            topImageViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            // bearImageView-Constraint
            bearImageView.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor),
            bearImageView.centerYAnchor.constraint(equalTo: topImageViewContainer.centerYAnchor),
            bearImageView.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.5),
            // descriptionTextView-Constraint
            descriptionTextView.topAnchor.constraint(equalTo: topImageViewContainer.bottomAnchor),
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
