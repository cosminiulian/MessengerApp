//
//  NewConversationTableViewCell.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 13.03.2022.
//

import UIKit
import SDWebImage

class NewConversationTableViewCell: UITableViewCell {
    
    static let identifier = "NewConversationTableViewCell"
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "message.fill")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubview(userImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(messageImageView)
    }
    
    private func setupConstraints() {
        userImageView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             topConstant: 10,
                             leftConstant: 10,
                             widthConstant: 80,
                             heightConstant: 80)
        
        fullNameLabel.anchor(top: contentView.topAnchor,
                             left: userImageView.rightAnchor,
                             right: messageImageView.leftAnchor,
                             topConstant: 10,
                             leftConstant: 10,
                             rightConstant: 10,
                             heightConstant: 25)
        
        emailLabel.anchor(top: fullNameLabel.bottomAnchor,
                          left: userImageView.rightAnchor,
                          right: messageImageView.leftAnchor,
                          topConstant: 10,
                          leftConstant: 10,
                          rightConstant: 10,
                          heightConstant: 25)
        
        messageImageView.anchor(top: contentView.topAnchor,
                                right: contentView.rightAnchor,
                                topConstant: 30,
                                rightConstant: 10,
                                widthConstant: 35,
                                heightConstant: 35)
    }
    
    public func configure(with user: User) {
        fullNameLabel.text = user.fullName
        emailLabel.text = user.email
        setupProfilePicture(fileName: user.getProfilePictureFileName())
    }
    
    private func setupProfilePicture(fileName: String) {
        let path = "images/" + fileName
        
        StorageManager.shared.getDownloadURL(for: path, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let url):
                DispatchQueue.main.async {
                    self.userImageView.sd_setImage(with: url)
                }
                
            case . failure(let error):
                print("Failed to get download url: \(error)")
            }
        })
    }
    
}
