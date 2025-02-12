//
//  DSSCollectionViewFlowLayout.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 30/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import UIKit

@objc(DSSCollectionViewFlowLayout)
class DSSCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare () {
        super.prepare()

        var contentByItems: ldiv_t

        let contentSize = self.collectionViewContentSize
        let itemSize = self.itemSize

        if UICollectionView.ScrollDirection.vertical == self.scrollDirection {
            contentByItems = ldiv (Int(contentSize.width), Int(itemSize.width))
        } else {
            contentByItems = ldiv (Int(contentSize.height), Int(itemSize.height))
        }

        let layoutSpacingValue = CGFloat(NSInteger (CGFloat(contentByItems.rem))) / CGFloat (contentByItems.quot + 1) - 1

        let originalMinimumLineSpacing = self.minimumLineSpacing
        let originalMinimumInteritemSpacing = self.minimumInteritemSpacing
        let originalSectionInset = self.sectionInset

        if layoutSpacingValue != originalMinimumLineSpacing ||
            layoutSpacingValue != originalMinimumInteritemSpacing ||
            layoutSpacingValue != originalSectionInset.left ||
            layoutSpacingValue != originalSectionInset.right ||
            layoutSpacingValue != originalSectionInset.top ||
            layoutSpacingValue != originalSectionInset.bottom {

            var topValue = layoutSpacingValue
            if layoutSpacingValue > 30 {
                topValue = 30
            }
            
            let insetsForItem = UIEdgeInsets.init(top: topValue, left: layoutSpacingValue, bottom: topValue, right: layoutSpacingValue)

            self.minimumLineSpacing = topValue
            self.minimumInteritemSpacing = layoutSpacingValue 
            self.sectionInset = insetsForItem
        }
    }
}

