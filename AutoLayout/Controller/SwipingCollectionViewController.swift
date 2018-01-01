//
//  SwipingCollectionViewController.swift
//  AutoLayout
//
//  Created by Joshua Geronimo on 12/28/17.
//  Copyright © 2017 Joshua Geronimo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SwipingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // This array contains the information for each page of the CollectionView
    let pages = [Page(imageName: "bear_first", headerDescription: "Join us today in our fun and games!", bodyDescription: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
                 Page(imageName: "heart_second", headerDescription: "Subscribe and get coupons our daily event.", bodyDescription: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
                 Page(imageName: "leaf_third", headerDescription: "VIP members special services.", bodyDescription: "Join the private club of elite customers will get you into select drawings and giveaways.")]
    
    // This Button will act as the previous button
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    // This UIPageControl will show the user which page they are on
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
    // This Button will act as the next button
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
//        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Register PageCollectionViewCell
        self.collectionView!.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Sets the background to white
        collectionView?.backgroundColor = .white
        // This code will do the snapping effect on each scroll between pages
        collectionView?.isPagingEnabled = true
        // Sets up bottom control UI
        setUpBottomControlsWithStackViews()
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
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // there will be four pages
        return pages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PageCollectionViewCell {
            let page = pages[indexPath.item]
            cell.page = page
            return cell
        } else {
            return PageCollectionViewCell()
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    // This function dictates the size of each cell.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Make each cell take up the whole screen.
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // This function dictates the amount of spaces between each cell.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0    // no space
    }
    
    

}
