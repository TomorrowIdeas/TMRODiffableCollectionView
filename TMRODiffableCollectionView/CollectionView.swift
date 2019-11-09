//
//  CollectionView.swift
//  TMRODiffableCollectionView
//
//  Created by Benji Dodgson on 11/9/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation
import UIKit

open class CollectionView: UICollectionView {

    public let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    public init(layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        self.initialize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    open func initialize() {
        self.backgroundColor = .clear 
        self.addSubview(self.activityIndicator)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        self.activityIndicator.centerOnXAndY()
    }

    public func scrollToBottom(animated: Bool = true) {
        let collectionViewContentHeight = collectionViewLayout.collectionViewContentSize.height

        self.performBatchUpdates(nil) { _ in
            self.scrollRectToVisible(CGRect(x: 0.0,
                                            y: collectionViewContentHeight - 1.0,
                                            width: 1.0, height: 1.0),
                                     animated: animated)
        }
    }

    public func reloadDataAndKeepOffset() {
        // stop scrolling
        self.setContentOffset(self.contentOffset, animated: false)

        // calculate the offset and reloadData
        let beforeContentSize = self.contentSize
        self.reloadData()
        self.layoutIfNeeded()
        let afterContentSize = self.contentSize

        // reset the contentOffset after data is updated
        let newOffset = CGPoint(
            x: self.contentOffset.x + (afterContentSize.width - beforeContentSize.width),
            y: self.contentOffset.y + (afterContentSize.height - beforeContentSize.height))
        self.setContentOffset(newOffset, animated: false)
    }

    public func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: String(describing: T.self))
    }

    /// Registers a reusable view for a specific SectionKind
    public func register<T: UICollectionReusableView>(_ reusableViewClass: T.Type,
                                                      forSupplementaryViewOfKind kind: String) {
        self.register(reusableViewClass,
                      forSupplementaryViewOfKind: kind,
                      withReuseIdentifier: String(describing: T.self))
    }

    /// Generically dequeues a cell of the correct type allowing you to avoid scattering your code with guard-let-else-fatal
    public func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable to dequeue \(String(describing: cellClass)) with reuseId of \(String(describing: T.self))")
        }
        return cell
    }

    /// Generically dequeues a header of the correct type allowing you to avoid scattering your code with guard-let-else-fatal
    public func dequeueReusableHeaderView<T: UICollectionReusableView>(_ viewClass: T.Type, for indexPath: IndexPath) -> T {
        let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: T.self), for: indexPath)
        guard let viewType = view as? T else {
            fatalError("Unable to dequeue \(String(describing: viewClass)) with reuseId of \(String(describing: T.self))")
        }
        return viewType
    }

    /// Generically dequeues a footer of the correct type allowing you to avoid scattering your code with guard-let-else-fatal
    public func dequeueReusableFooterView<T: UICollectionReusableView>(_ viewClass: T.Type, for indexPath: IndexPath) -> T {
        let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: T.self), for: indexPath)
        guard let viewType = view as? T else {
            fatalError("Unable to dequeue \(String(describing: viewClass)) with reuseId of \(String(describing: T.self))")
        }
        return viewType
    }
}
