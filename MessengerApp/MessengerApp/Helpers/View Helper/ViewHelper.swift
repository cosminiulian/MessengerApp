//
//  ViewHelper.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit

extension UIView {
    
    // MARK: - Constraints Helper
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
        
        if widthConstant > 0 {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        
        if heightConstant > 0 {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
    
    func anchorToCenterX(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0, centerX: NSLayoutXAxisAnchor) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: centerX).isActive = true
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        
        if widthConstant > 0 {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        
        if heightConstant > 0 {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
    
    func anchorToCenterY(left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, leftConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0, centerY: NSLayoutYAxisAnchor) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: centerY).isActive = true
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
        
        if widthConstant > 0 {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        
        if heightConstant > 0 {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
    
    func anchorToCenterXAndY(widthConstant: CGFloat = 0, heightConstant: CGFloat = 0, centerX: NSLayoutXAxisAnchor, centerY: NSLayoutYAxisAnchor) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: centerX).isActive = true
        centerYAnchor.constraint(equalTo: centerY).isActive = true
        
        if widthConstant > 0 {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        
        if heightConstant > 0 {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
    
    func updateConstraint(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = constant
            self.layoutIfNeeded()
        }
    }
    
}
