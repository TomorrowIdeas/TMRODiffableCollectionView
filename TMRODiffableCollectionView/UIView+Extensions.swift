//
//  UIView+Extensions.swift
//  TMRODiffableCollectionView
//
//  Created by Benji Dodgson on 11/9/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation
import UIKit

internal extension UIView {

    var centerX: CGFloat {
        get {
            return self.center.x
        }

        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }

    var centerY: CGFloat {
        get {
            return self.center.y
        }

        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }

    func centerOnXAndY() {
        self.centerOnY()
        self.centerOnX()
    }

    func centerOnY() {
        if let theSuperView = self.superview {
            self.centerY = theSuperView.halfHeight
        }
    }

    func centerOnX() {
        if let theSuperView = self.superview {
            self.centerX = theSuperView.halfWidth
        }
    }

    var halfWidth: CGFloat {
        get {
            return 0.5*self.frame.size.width
        }
    }

    var halfHeight: CGFloat {
        get {
            return 0.5*self.frame.size.height
        }
    }
}
