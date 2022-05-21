//
//  LoginSeparatorView.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 05.04.2022.
//

import UIKit

class LoginSeparatorView: UIView {
    
    private let rightLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemBackground
        return view
    }()
    
    private let centerLabel: UIView = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "or"
        label.textColor = .tertiarySystemBackground
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let leftLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemBackground
        return view
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil {
            setupSubviews()
            setupConstraints()
        }
    }
    
    private func setupSubviews() {
        addSubview(rightLineView)
        addSubview(centerLabel)
        addSubview(leftLineView)
    }
    
    private func setupConstraints() {
        rightLineView.anchorToCenterY(left: leftAnchor,
                                      right: centerLabel.leftAnchor,
                                      rightConstant: 10,
                                      heightConstant: 1,
                                      centerY: centerYAnchor)
        
        centerLabel.anchorToCenterX(top: topAnchor,
                                    bottom: bottomAnchor,
                                    widthConstant: 20,
                                    centerX: centerXAnchor)
        
        leftLineView.anchorToCenterY(left: centerLabel.rightAnchor,
                                     right: rightAnchor,
                                     leftConstant: 10,
                                     heightConstant: 1,
                                     centerY: centerYAnchor)
    }
    
}
