//
//  ProfileHeaderView.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 03.03.2022.
//

import UIKit
import SDWebImage

class ProfileHeaderView: UIView {
    
    private let penImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PenIcon")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .link
        return imageView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 80
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil {
            setupViews()
            setupConstraints()
            setupProfilePicture()
        }
    }
    
    private func setupViews() {
        addSubview(penImageView)
        addSubview(profileImageView)
        addSubview(saveButton)
    }
    
    private func setupConstraints() {
        penImageView.anchor(top: topAnchor,
                            left: profileImageView.rightAnchor,
                            topConstant: 20,
                            leftConstant: -20,
                            widthConstant: 20,
                            heightConstant: 20)
        
        profileImageView.anchorToCenterX(top: topAnchor,
                                         topConstant: 20,
                                         widthConstant: 160,
                                         heightConstant: 160,
                                         centerX: centerXAnchor)
        
        saveButton.anchorToCenterX(top: profileImageView.bottomAnchor,
                                   topConstant: 10,
                                   widthConstant: 70,
                                   heightConstant: 35,
                                   centerX: centerXAnchor)
    }
    
    func addActions(_ viewController: ProfileViewController, saveAction: Selector, profileAction: Selector) {
        saveButton.addTarget(viewController, action: saveAction, for: .touchUpInside)
        
        let profileTapGesture = UITapGestureRecognizer(target: viewController, action: profileAction)
        profileImageView.addGestureRecognizer(profileTapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    
    func setupProfilePicture() {
        guard let email = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
            return
        }
        
        let filename = email + "_profile_picture.png"
        let path = "images/" + filename
        
        StorageManager.shared.getDownloadURL(for: path, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let url):
                self.profileImageView.sd_setImage(with: url)
                
            case . failure(let error):
                print("Failed to get download url: \(error)")
            }
        })
    }
    
}
