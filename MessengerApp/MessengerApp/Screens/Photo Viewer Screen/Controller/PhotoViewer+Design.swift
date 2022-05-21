//
//  PhotoViewer+Design.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 21.03.2022.
//

import UIKit

extension PhotoViewerViewController: DesignProtocol {
    
    func setupNavController() {
        title = "Photo"
    }
    
    func setupSubviews() {
        view.addSubview(closeButton)
        view.addSubview(imageView)
    }
    
    func setupConstraints() {
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           topConstant: 10,
                           leftConstant: 20,
                           widthConstant: 50,
                           heightConstant: 50)
        
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor)
    }
    
    func setupButtonsMethods() {
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction))
        view.addGestureRecognizer(panGesture)
    }
    
}
