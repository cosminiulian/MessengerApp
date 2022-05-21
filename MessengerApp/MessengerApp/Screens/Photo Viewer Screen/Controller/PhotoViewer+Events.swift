//
//  PhotoViewer+Events.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 21.03.2022.
//

import UIKit

extension PhotoViewerViewController {
    
    @objc func closeButtonAction() {
        dismiss(animated: true)
    }
    
    @objc func panGestureAction(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: { [weak self] in
                
                guard let self = self else { return }
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
            
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 0.7,
                               initialSpringVelocity: 1,
                               options: .curveEaseOut,
                               animations: { [weak self] in
                    
                    self?.view.transform = .identity })
            } else {
                dismiss(animated: true)
            }
            
        default:
            break
        }
    }
    
}
