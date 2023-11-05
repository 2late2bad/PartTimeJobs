//
//  UICollectionView+ext.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 03.11.2023.
//

import UIKit.UICollectionView

extension UICollectionView.CellRegistration {

    var cellProvider: (UICollectionView, IndexPath, Item) -> Cell {
        { collectionView, indexPath, product in
            collectionView.dequeueConfiguredReusableCell(using: self, for: indexPath, item: product)
        }
    }
}

extension UICollectionView {
    
    func select(_ indexPaths: [IndexPath], animated: Bool = false, scrollPosition: UICollectionView.ScrollPosition = []) {
        for path in indexPaths {
            selectItem(at: path, animated: animated, scrollPosition: scrollPosition)
        }
    }
    
    func deselect(_ indexPaths: [IndexPath], animated: Bool = true) {
        for path in indexPaths {
            deselectItem(at: path, animated: animated)
        }
    }
    
    func deselectAll(animated: Bool = true) {
        deselect(indexPathsForSelectedItems ?? [], animated: animated)
    }
    
    func deselectAllInSection(except indexPath: IndexPath) {
        let indexPathToDeselect = (indexPathsForSelectedItems ?? []).filter {
            $0.section == indexPath.section && $0.row != indexPath.row
        }
        deselect(indexPathToDeselect)
    }
}
