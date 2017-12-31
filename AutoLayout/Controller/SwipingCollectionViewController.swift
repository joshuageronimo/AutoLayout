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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Register PageCollectionViewCell
        self.collectionView!.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Sets the background to white
        collectionView?.backgroundColor = .white
        // This code will do the snapping effect on each scroll between pages
        collectionView?.isPagingEnabled = true
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
