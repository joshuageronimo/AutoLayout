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
    
    /// This function will make landscape mode work
    /// - Using invalidateLayout will refresh the layout to conform to autolayout set up
    /// - index path will get the current page index
    /// - scrollToItem uses indexPath so that when the user changes the orientation it will go to the correct page
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }) { (_) in }
    }
    
    // This array contains the information for each page of the CollectionView
    private let pages = [Page(imageName: "bear_first", headerDescription: "Join us today in our fun and games!", bodyDescription: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
                 Page(imageName: "heart_second", headerDescription: "Subscribe and get coupons our daily event.", bodyDescription: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
                 Page(imageName: "leaf_third", headerDescription: "VIP members special services.", bodyDescription: "Join the private club of elite customers will get you into select drawings and giveaways.")]
    
    // This Button will act as the previous button
    private let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    // This button will swipe to the previous page
    @objc private func handlePrev() {
        let previousIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: previousIndex, section: 0)
        pageControl.currentPage = previousIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // This UIPageControl will show the user which page they are on
    lazy private var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
    // This Button will act as the next button
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    // This button will swipe to the next page
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

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
    
    // This function will make the Page Control work while swiping.
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x
        /*
         By the dividing the index variable to the width of the frame,
         I will get the appropriate value to use as the index for
         the current page for the UIPageController.
        */
        pageControl.currentPage = Int(index / view.frame.width)
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
