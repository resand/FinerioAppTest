//
//  UIView+Extension.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation
import UIKit
import Lottie

extension UIView {
    // MARK: - Safe anchors

    /// Contains view's top anchor depending to iOS version.
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }

    /// Contains view's leading anchor depending to iOS version.
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leadingAnchor
        } else {
            return self.leadingAnchor
        }
    }

    /// Contains view's trailing anchor depending to iOS version.
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.trailingAnchor
        } else {
            return self.trailingAnchor
        }
    }

    /// Contains view's bottom anchor depending to iOS version.
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }

    // MARK: - Common constraints

    /// Adds a constraint (top) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    /// Adds a constraint (bottom) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    /// Adds a constraint (leading) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    /// Adds a constraint (trailing) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    // MARK: - Height constraints

    /// Adds a height constraint with constant value.
    /// - Parameter constant: The constant offset for the constraint.
    @discardableResult
    func heightAnchor(equalTo constant: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    /// Adds a constraint (height) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - multiplier: The multiplier constant for the constraint.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func heightAnchor(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        return self
    }

    // MARK: - Width constraints

    /// Adds a width constraint with constant value.
    /// - Parameter constant: The constant offset for the constraint.
    @discardableResult
    func widthAnchor(equalTo constant: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    /// Adds a constraint (width) that defines one item’s attribute as greater than or equal to another item’s attribute plus a constant offset.
    /// - Parameter constant: The constant offset for the constraint.
    @discardableResult
    func widthAnchor(greaterThanOrEqualTo constant: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
        return self
    }

    /// Adds a constraint (width) that defines one item’s attribute as less than or equal to another item’s attribute plus a constant offset.
    /// - Parameter constant: The constant offset for the constraint.
    @discardableResult
    func widthAnchor(lessThanOrEqualToConstant constant: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
        return self
    }

    /// Adds a constraint (width) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func widthAnchor(equalTo anchor: NSLayoutDimension, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    // MARK: - Center constraints

    /// Adds a constraint (center X) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func centerXAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    /// Adds a constraint (center Y) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }


    // MARK: - Helpers

    /// Adds four constraints (top, bottom, leading, trailing) to the current view and another view.
    /// - Parameters:
    ///   - anotherView: The view for the right side of the constraint.
    ///   - insets: The constant inset for the constraint.
    ///   - usingSafeArea: Use safe area or standart anchors.
    func pinAnchors(to anotherView: UIView, insets: UIEdgeInsets = .zero, usingSafeArea: Bool = false) {
        if usingSafeArea {
            self
                .topAnchor(equalTo: anotherView.safeTopAnchor, constant: insets.top)
                .leadingAnchor(equalTo: anotherView.safeLeadingAnchor, constant: insets.left)
                .trailingAnchor(equalTo: anotherView.safeTrailingAnchor, constant: -insets.right)
                .bottomAnchor(equalTo: anotherView.safeBottomAnchor, constant: -insets.bottom)
        } else {
            self
                .topAnchor(equalTo: anotherView.topAnchor, constant: insets.top)
                .leadingAnchor(equalTo: anotherView.leadingAnchor, constant: insets.left)
                .trailingAnchor(equalTo: anotherView.trailingAnchor, constant: -insets.right)
                .bottomAnchor(equalTo: anotherView.bottomAnchor, constant: -insets.bottom)
        }
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
            
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }

    func addLoader(gameAnimation: Bool) {
        let grayView = UIView()
        grayView.backgroundColor = .white
        grayView.tag = 200
        self.addSubview(grayView)
        self.bringSubviewToFront(grayView)
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: grayView)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: grayView)

        let animationView = LOTAnimationView(name: "loading")
        animationView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height / 2)
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 1.0
        animationView.loopAnimation = true

        grayView.addSubview(animationView)
        animationView.play()
    }

    func removeLoader() {
        for subview in self.subviews {
            if subview.tag == 200 {
                subview.removeFromSuperview()
            }
        }
    }
}